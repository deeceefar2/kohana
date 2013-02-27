<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Referral extends Controller_Base {

	public function action_index()
	{
		// Set the name of the template to use
		$this->template->set_filename('referral');

		// On form submission
		if( $this->request->method() == Request::POST ){
/*
			try{
				// Initialize the validation library and setup some rules
				$validation = Validation::factory($this->request->post());

				$validation
					->rule('csrf',							'not_empty')
					->rule('csrf',							'Security::check')
				;

				if(!$this->request->is_ajax()) {
					$validation->rule('recaptcha_response_field',	'not_empty');
					$validation->rule('recaptcha_response_field',	'Recaptcha::validRecaptcha', array(':validation'));
				}

				$report = ORM::factory('report');
				$report->values($this->request->post());
				$report->user_id = $this->user->user_id;
				$report->report_type_id = $report_type->report_type_id;
				$report->object_id = $object->pk();
				$report->object_user_id = $object->user_id;

				$report->save($validation);

				# Log new User Email
				$message = ORM::factory('message');
				$message->addTo($object->user->email);
				$message->addReplyTo('admin@medvoyager.com');
				$message->message_from = 'noreply@colorfulstudio.com';
				$message->message_subject = "MedVoyager: Listing Reported";

				$email_template = View::factory('email/report');
				$email_template->report = $report->as_array();
				$email_template->report_type = $report->report_type->as_array();
				$email_template->report_category = $report->report_category->as_array();
				$email_template->object = $object->as_array();
				$email_template->object_user = $report->object_user->as_array();


				$response = SimpleEmailService::factory()->sendEmail($message,$email_template);

				//Admin Email
				$message->message_to = array();
				$message->addTo('noreply@colorfulstudio.com');
				$message->addTo('admin@medvoyager.com');
				$message->addTo('davidf@colorfulstudio.com');

				$email_template->user = $this->user;

				$response = SimpleEmailService::factory()->sendEmail($message,$email_template);

				// Redirect to report thank you
				$this->template->set_filename('message');
				$this->template->message_title = 'Report Submitted';
				$this->template->message_text = 'Thank you for reporting this issue.  We appreciate your help in improving MedVoyager.';
				$this->template->message_icon = 1;
				if(!$this->request->is_ajax())
					$this->template->set_global('redirect', '/'.$this->request->controller().'/'.$this->request->param('slug').'/'.$this->request->param('id'));

				return;

			} catch (ORM_Validation_Exception $e) {
				$this->template->errors = $e->errors('models');
			}
			*/
		}
	}
}
