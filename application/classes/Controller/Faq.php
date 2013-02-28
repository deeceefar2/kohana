<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Faq extends Controller_Base {

	public function action_index()
	{
		// Set the name of the template to use
		$this->template->set_filename('faq');

		// Create new Recaptcha object from global keys
		$Recaptcha = new Recaptcha();

		// On form submission
		if( $this->request->method() == Request::POST ){

			// Initialize the validation library and setup some rules
			$validation = Validation::factory($this->request->post());

			$validation
				->rule('faq_email',						'not_empty')
				->rule('faq_email',						'regex', array(':value','/^(?!Your e-mail Address)/'))
				->rule('faq_email',						'email')
				->rule('faq_question',					'not_empty')
				->rule('faq_question',					'regex', array(':value','/^(?!What is your question\?)/'))
				->rule('recaptcha_response_field',		'not_empty')
				->rule('recaptcha_response_field',		'Recaptcha::validRecaptcha', array(':validation'))
				->rule('csrf',							'not_empty')
				->rule('csrf',							'Security::check')
			;

			if( $validation->check() ){

				# Send it
				$message = ORM::factory('message');
				$message->addTo('noreply@colorfulstudio.com');
				$message->message_from = 'noreply@colorfulstudio.com';
				$message->message_subject = "MedVoyager: FAQ Form";

				$email_template = View::factory('email/faq');
				$email_template->post = $this->request->post();

				$response = SimpleEmailService::factory()->sendEmail($message,$email_template);

				// Redirect to report thank you
				$this->template->set_filename('message');
				$this->template->message_title = 'FAQ Form Submitted';
				$this->template->message_text = 'Thank you helping us make MedVoyager better.  We\'ll be in touch shortly.';
				$this->template->message_icon = 1;
				$this->template->set_global('redirect', '/faq');

			} else {

				// Display data that was previously as well as any validation errors
				$this->template->errors = $validation->errors('faq');
			}
		}

		// Normal data to display
		$this->template->recaptcha = array(
			'server'=>RECAPTCHA_API_SERVER,
			'key'=>$Recaptcha->public_key(),
		);

		if( $this->request->method() == 'GET' and $this->request->query('question_title')){
			$this->template->question_sections = ORM::factory('question_section')->find_all();
			$query = $this->request->query('question_title');
			$this->template->questions = ORM::factory('question')->where('question_answer','!=','')
				->and_where_open()
					->where('question_title','like',"%$query%")
					->or_where('question_answer','like',"%$query%")
				->and_where_close()
				->find_all();
		} else {
			$this->template->question_sections = ORM::factory('question_section')->find_all();
			$this->template->questions = ORM::factory('question')->and_where('question_answer','!=','')->find_all();
		}
	}
}
