<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Listing extends Controller_Base {

	public $auth_required = array('login','active');
/*
	public $secure_actions = array(
		'bookmark'			=> array('login','active'),
		'bookmark_delete'	=> array('login','active'),
		'review'			=> array('login','active'),
		'report'			=> array('login','active'),
		'contact'			=> array('login','active'),
	);
	*/

	public function action_index()
	{
		// Set the name of the template to use
		$this->template->set_filename('listing');

		$listing = ORM::factory('Listing')->where('listing_id','=',$this->request->param('id'))->with('default_category:parent:parent:parent')->find();

		if(!$listing->loaded()) {
			throw new HTTP_Exception_404('The requested URL :uri was not found on this server.', array(
				':uri' => $this->request->uri()
			));
		}

		$this->template->title = $listing->listing_name;

		$category = $listing->default_category;
		$categories = array();
		while($category->loaded()) {
			array_push($categories, $category);
			$category = $category->parent;
		}
		$this->template->listing_categories = $categories;

		$this->template->listing = $listing->as_array(($this->user)?$this->user->user_id:NULL);
		$this->template->listing_files = $listing->files->find_all();
		$this->template->listing_fields = $listing->listing_fields->find_all();

		$this->template->reviews = $listing->reviews->where('review_title','!=','')->and_where('review_body','!=','')->order_by('review_date_modified','desc')->find_all();
/*
		$this->template->scripts = array(
			'script' => array(
				array(
					'source'	=> 'http://www.google.com/jsapi?autoload={modules:[{name:"maps",version:3,other_params:"sensor=false"}]}&key=ABQIAAAACgq4GHPTtYlEBLFv4j9ZABQcBjVj5tvavvjodnc9kSqL208uSxRhJVJtcIYy25R8xiXpsCye3H-v6Q',
				),
			)
		);
*/
	}

	public function action_bookmark()
	{
		$listing = ORM::factory('Listing')->where('listing_id','=',$this->request->param('id'))->find();
		if($listing->loaded()) {
			try{
				$bookmark = ORM::factory('Bookmark');
				$bookmark->listing_id = $listing->listing_id;
				$bookmark->user_id = $this->user->user_id;
				$bookmark->save();

				// Message View
				$this->template->set_filename('message');
				$this->template->message_title = 'Bookmark Added';
				$this->template->message_text = 'Bookmark for "' . $listing->listing_name . '" successfully added.';
				$this->template->message_icon = 1;
				$this->template->set_global('redirect', '/'.$this->request->controller().'/'.$this->request->param('slug').'/'.$this->request->param('id'));

				return;
			} catch (Exception $e) {
				$this->template->errors = $e->errors('models');
			}
		}
		$this->template->set_filename('message');
		$this->template->message_title = 'Bookmark Add Failed';
		$this->template->message_text = 'Bookmark for "' . $listing->listing_name . '" was not successfully added.';
		$this->template->message_icon = 1;
		$this->template->set_global('redirect', '/'.$this->request->controller().'/'.$this->request->param('slug').'/'.$this->request->param('id'));
	}

	public function action_bookmark_delete() {
		$listing = ORM::factory('Listing')->where('listing_id','=',$this->request->param('id'))->find();
		if($listing->loaded()) {
			try{
				$this->user->bookmarks->where('listing_id','=',$listing->listing_id)->find()->delete();

				// Redirect to report thank you
				$this->template->set_filename('message');
				$this->template->message_title = 'Bookmark Deleted';
				$this->template->message_text = 'Bookmark for "' . $listing->listing_name . '" successfully deleted.';
				$this->template->message_icon = 1;
				$this->template->set_global('redirect', '/'.$this->request->controller().'/'.$this->request->param('slug').'/'.$this->request->param('id'));

				return;
			} catch (Exception $e) {
				$this->template->errors = $e->errors('models');
			}
		}
		$this->template->set_filename('message');
		$this->template->message_title = 'Bookmark Delete Failed';
		$this->template->message_text = 'Bookmark for "' . $listing->listing_name . '" was not successfully deleted.';
		$this->template->message_icon = 1;
		$this->template->set_global('redirect', '/'.$this->request->controller().'/'.$this->request->param('slug').'/'.$this->request->param('id'));
	}

	public function action_review()
	{
		$listing = ORM::factory('Listing')->where('listing_id','=',$this->request->param('id'))->find();
		if($listing->loaded()) {
			try{
				// Initialize the validation library and setup some rules
				$validation = Validation::factory($this->request->post());

				$validation
					->rule('csrf',							'not_empty')
					->rule('csrf',							'Security::check')
				;
				$old_review = NULL;
				if($this->request->post('review_id')) {
					$old_review = ORM::factory('Review')->where('review_id','=',$this->request->post('review_id'))->and_where('user_id','=',$this->user->user_id)->and_where('listing_id','=',$listing->listing_id)->find();
					if($old_review->loaded())
						$old_review->delete();
				}
				$review = ORM::factory('Review');
				$review->values($this->request->post());
				$review->listing_id = $listing->listing_id;
				$review->user_id = $this->user->user_id;
				$review->save($validation);

				if(floor($listing->listing_state / 2) % 2 == 1 && $old_review==NULL && $review->review_title != '' && $review->review_body != '' && !$this->request->post('review_id')) {
					# Log new User Email
					$message = ORM::factory('Message');
					$message->addTo($listing->user->email);
					$message->addReplyTo('admin@medvoyager.com');
					$message->message_from = 'noreply@colorfulstudio.com';
					$message->message_subject = "MedVoyager: Premium Listing Reviewed";

					$email_template = View::factory('email/review');
					$email_template->listing = $listing->as_array();
					$email_template->review = $review->as_array();

					$response = SimpleEmailService::factory()->sendEmail($message,$email_template);
				}

				$this->template->set_filename('message');
				if($this->request->post('review_id'))
					$this->template->message_title = 'Review Edited';
				else
					$this->template->message_title = 'Review Added';

				if($this->request->post('review_id'))
					$this->template->message_text = 'Review for "' . $listing->listing_name . '" was successfully edited.';
				else
					$this->template->message_text = 'Review for "' . $listing->listing_name . '" was successfully added.';
				$this->template->message_icon = 1;
				$this->template->set_global('redirect', '/'.$this->request->controller().'/'.$this->request->param('slug').'/'.$this->request->param('id'));

				return;
			} catch (ORM_Validation_Exception $e) {
				$this->template->errors = $e->errors('models');
			}
		}
		$this->template->set_filename('message');
		$this->template->message_title = 'Review Save Failed';
		$this->template->message_text = 'Review for "' . $listing->listing_name . '" was not successfully saved.';
		$this->template->message_icon = 2;
		$this->template->set_global('redirect', '/'.$this->request->controller().'/'.$this->request->param('slug').'/'.$this->request->param('id'));
	}

	public function action_report()
	{
		// Set the name of the template to use
		$this->template->set_filename('report');

		// Create new Recaptcha object from global keys
		$Recaptcha = new Recaptcha();

		$object = ORM::factory('listing');
		$object->where($object->primary_key(),'=',$this->request->param('id'))->find();

		$report_type = ORM::factory('Report_Type')->where('report_type_model','=',$object->object_name())->find();

		// On form submission
		if( $this->request->method() == Request::POST ){

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

				$report = ORM::factory('Report');
				$report->values($this->request->post());
				$report->user_id = $this->user->user_id;
				$report->report_type_id = $report_type->report_type_id;
				$report->object_id = $object->pk();
				$report->object_user_id = $object->user_id;

				$report->save($validation);

				# Log new User Email
				$message = ORM::factory('Message');
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
				$this->template->set_global('redirect', '/'.$this->request->controller().'/'.$this->request->param('slug').'/'.$this->request->param('id'));

				return;

			} catch (ORM_Validation_Exception $e) {
				$this->template->errors = $e->errors('models');
			}
		}

		$this->template->report_type = $report_type;

		$this->template->report_categories = $report_type->report_categories->find_all();

		// Normal data to display
		$this->template->recaptcha = array(
			'server'=>RECAPTCHA_API_SERVER,
			'key'=>$Recaptcha->public_key(),
		);
	}

	public function action_report_review()
	{
		// Set the name of the template to use
		$this->template->set_filename('report');

		// Create new Recaptcha object from global keys
		$Recaptcha = new Recaptcha();

		$object = ORM::factory('Review');
		$object->where($object->primary_key(),'=',$this->request->param('action_id'))->with('listing')->find();

		$report_type = ORM::factory('Report_Type')->where('report_type_model','=',$object->object_name())->find();

		// On form submission
		if( $this->request->method() == Request::POST ){

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

				$report = ORM::factory('Report');
				$report->values($this->request->post());
				$report->user_id = $this->user->user_id;
				$report->report_type_id = $report_type->report_type_id;
				$report->object_id = $object->pk();
				$report->object_user_id = $object->user_id;

				$report->save($validation);

				# Log new User Email
				$message = ORM::factory('Message');
				$message->addTo($object->user->email);
				$message->addReplyTo('admin@medvoyager.com');
				$message->message_from = 'noreply@colorfulstudio.com';
				$message->message_subject = "MedVoyager: Review Reported";

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
				$this->template->set_global('redirect', '/'.$this->request->controller().'/'.$this->request->param('slug').'/'.$this->request->param('id'));

				return;

			} catch (ORM_Validation_Exception $e) {
				$this->template->errors = $e->errors('models');
			}
		}

		$this->template->report_type = $report_type;

		$this->template->report_categories = $report_type->report_categories->find_all();

		// Normal data to display
		$this->template->recaptcha = array(
			'server'=>RECAPTCHA_API_SERVER,
			'key'=>$Recaptcha->public_key(),
		);
	}

	public function action_contact()
	{
		// Set the name of the template to use
		$this->template->set_filename('listing_contact');

		// Create new Recaptcha object from global keys
		$Recaptcha = new Recaptcha();

		// On form submission
		if( $this->request->method() == Request::POST ) {

			// Initialize the validation library and setup some rules
			$validation = Validation::factory($this->request->post());

			$validation
				->rule('contact_title',		'not_empty')
				->rule('contact_question',	'not_empty')
				->rule('csrf',				'not_empty')
				->rule('csrf',				'Security::check')
			;


			if(!$this->request->is_ajax()) {
				$validation->rule('recaptcha_response_field',	'not_empty');
				$validation->rule('recaptcha_response_field',	'Recaptcha::validRecaptcha', array(':validation'));
			}

			if( $validation->check() ){

				$listing = ORM::factory('Listing')->where('listing_id','=',$this->request->param('id'))->find();

				# Log new User Email
				$message = ORM::factory('Message');
				$message->addTo($listing->user->email);
				$message->addReplyTo($this->user->email);
				$message->message_from = 'noreply@colorfulstudio.com';
				$message->message_subject = "MedVoyager: Listing Contact Form";

				$email_template = View::factory('email/listing_contact');
				$email_template->contact_title = $this->request->post('contact_title');
				$email_template->contact_owner_question = $this->request->post('contact_owner_question');
				$email_template->listing = $listing;
				$email_template->user = $this->user;

				$response = SimpleEmailService::factory()->sendEmail($message,$email_template);

				// Redirect to report thank you
				$this->template->set_filename('message');
				$this->template->message_title = 'Contact Form Submitted';
				$this->template->message_text = 'Your question is being sent directly to the listing owner.';
				$this->template->message_icon = 1;

				$this->template->set_global('redirect', '/'.$this->request->controller().'/'.$this->request->param('slug').'/'.$this->request->param('id'));
			}

			// Display data that was previously as well as any validation errors
			$this->template->errors = $validation->errors('listing');
		}

		// Normal data to display
		$this->template->recaptcha = array(
			'server'=>RECAPTCHA_API_SERVER,
			'key'=>$Recaptcha->public_key(),
		);
	}
}