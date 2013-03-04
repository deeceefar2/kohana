<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Contact extends Controller_Base {

	public function action_index()
	{
		// Set the name of the template to use
		$this->template->set_filename('contact');

		// Create new Recaptcha object from global keys
		$Recaptcha = new Recaptcha();

		// On form submission
		if( $this->request->method() == Request::POST ){

			// Initialize the validation library and setup some rules
			$validation = Validation::factory($this->request->post());

			$validation
				->rule('name',						'not_empty')
				->rule('email',						'not_empty')
				->rule('email',						'email')
				->rule('subject',					'regex', array(':value','/^(?!default)/'))
				->rule('message',					'not_empty')
				->rule('csrf',						'not_empty')
				->rule('csrf',						'Security::check')
				->rule('recaptcha_response_field',	'not_empty')
				->rule('recaptcha_response_field',	'Recaptcha::validRecaptcha', array(':validation'))
			;

			if( $validation->check() ){

				# Log new User Email
				$message = ORM::factory('Message');
				$message->addTo('noreply@colorfulstudio.com');
				$message->addReplyTo($this->request->post('email'));
				$message->message_from = 'MedVoyager<noreply@colorfulstudio.com>';
				$message->message_subject = "MedVoyager: Contact Form";

				$email_template = View::factory('email/contact');
				$email_template->post = $this->request->post();

				$response = SimpleEmailService::factory()->sendEmail($message,$email_template);

				// Redirect to report thank you
				$this->template->set_filename('message');
				$this->template->message_title = 'Contact Form Submitted';
				$this->template->message_text = 'Thank you for contacting us.  We\'ll be in touch shortly.';
				$this->template->message_icon = 1;
				$this->template->set_global('redirect', '/');

				return;
			}

			// Display data that was previously as well as any validation errors
			$this->template->errors = $validation->errors('contact');
		}

		// Normal data to display
		$this->template->recaptcha = array(
			'server'=>RECAPTCHA_API_SERVER,
			'key'=>$Recaptcha->public_key(),
		);
	}

}
