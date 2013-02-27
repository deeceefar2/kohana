<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Register extends Controller_Base {

	public function action_index()
	{

		if($this->user) {
			$this->template->set_filename('message');
			$this->template->message_title = 'Please Logout';
			$this->template->message_text = 'You are already registered, you must <a href="/logout">logout</a> to access registration.';
			$this->template->message_icon = 3;
			if(isset($post_login_redirect_url))
				$this->template->set_global('redirect', $post_login_redirect_url);
			return;
		}

		// Set the name of the template to use
		$this->template->set_filename('register');

		// Create new Recaptcha object from global keys
		$Recaptcha = new Recaptcha();

		// On form submission
		if( $this->request->method() == Request::POST ){

			try{
				// Initialize the validation library and setup some rules
				$validation = Validation::factory($this->request->post());

				$validation
					->rule('csrf',							'not_empty')
					->rule('csrf',							'Security::check')
					->rule('recaptcha_response_field',		'not_empty')
					->rule('recaptcha_response_field',		'Recaptcha::validRecaptcha', array(':validation'))
					->rule('password_confirm',				'matches', array(':validation', 'password', ':field'))
					->rule('password_confirm',				'not_empty')
				;

				$user = ORM::factory('user');
				$user->values($this->request->post());

				$user->save($validation);
				$user->add('roles', ORM::factory('Role', array('name' => 'login')))->save();

				# Send registration email

				// Create a new autologin token
				$token = ORM::factory('User_Token');

				// Set token data
				$token->user_id = $user->pk();
				$token->expires = time() + 31536000;
				$token->save();

				$message = ORM::factory('Message');
				$message->addTo($user->email);
				$message->message_from = 'noreply@colorfulstudio.com';
				$message->message_subject = "MedVoyager: Email Confirmation";

				$email_template = View::factory('Email/EmailConfirmation');
				$email_template->token = $token->token;
				$email_template->user = $user;

				SimpleEmailService::factory()->sendEmail($message,$email_template);

				// Redirect to report thank you
				$this->template->set_filename('Message');
				$this->template->message_title = 'Registration Successful';
				$this->template->message_text = 'Thank you for registering for MedVoyager.  Please validate you email by clicking on the link sent to your registered email address.';
				$this->template->message_icon = 1;
				$this->template->set_global('redirect', '/login');

			} catch (ORM_Validation_Exception $e) {
				$this->template->errors = $e->errors('models');
			}
		}

		// Normal data to display
		$this->template->recaptcha = array(
			'server'=>RECAPTCHA_API_SERVER,
			'key'=>$Recaptcha->public_key(),
		);
	}

	public function action_validate()
	{

		if(Auth::instance()->logged_in() != 0){
			#redirect to the user account
			$this->request->redirect('profile/');
		}

		if($this->request->query('token')) {

			// Load the token and user
			$token = ORM::factory('user_token', array('token' => $this->request->query('token')));

			if ($token->loaded() AND $token->user->loaded())
			{
				$token->user->add('roles', ORM::factory('role', array('name' => 'active')))->save();

				Auth::instance()->force_login($token->user, true);

				# Send registrtion email
				$message = ORM::factory('message');
				$message->addTo($token->user->email);
				$message->message_from = 'noreply@colorfulstudio.com';
				$message->message_subject = "MedVoyager: Welcome";

				$email_template = View::factory('email/welcome');
				$email_template->user = $token->user;

				SimpleEmailService::factory()->sendEmail($message,$email_template);

				//remove token
				$token->delete();

				$this->request->redirect('profile/');
			}
		}
		$this->request->redirect('/');
	}

}
