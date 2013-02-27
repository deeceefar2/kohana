<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Login extends Controller_Base {

	public $invalid_login_attempts = 3;

	public function action_index()
	{
		if(Auth::instance()->logged_in() != 0) {
			if($this->request->is_ajax())
				$this->template->set_global('redirect', '/profile/');
			else
				$this->request->redirect('/profile/');
		}

		// Set the name of the template to use
		$this->template->set_filename('login');

		// Create new Recaptcha object from global keys
		$Recaptcha = new Recaptcha();

		if(Session::instance()->get('invalid_login_attempts') >= $this->invalid_login_attempts ) {

			// Add Recaptcha
			$this->template->recaptcha = array(
				'server'=>RECAPTCHA_API_SERVER,
				'key'=>$Recaptcha->public_key(),
			);

			if($this->request->is_ajax()) {
				$this->template->set_global('redirect', '/login');
				return;
			}

		}

		if( $this->request->method() == Request::POST ) {

			$validation = Validation::factory($this->request->post());

			$validation
				->rule('csrf',		'not_empty')
				->rule('csrf',		'Security::check')
			;

			if ($this->request->post('recaptcha') && !$this->request->is_ajax()) {

				$validation->rule('recaptcha_response_field', 'not_empty');
				$validation->rule('recaptcha_response_field', 'Recaptcha::validRecaptcha', array(':validation'));
			}

			if( $valid = $validation->check() ){


				$validation = Validation::factory($this->request->post());
				$validation->rule('username', 'not_empty');
				$validation->rule('username', 'Controller_Login::isLoginOrEmail');
				$validation->rule('password', 'not_empty');
				$validation->rule('password', 'Auth::validlogin', array(':data'));

				if( $valid = $validation->check() ){

					Session::instance()->delete('invalid_login_attempts');

					$post_login_redirect_url = Session::instance()->get('post_login_redirect_url');

					if($this->request->is_ajax()) {

						// Redirect to report thank you
						$this->template->set_filename('message');
						$this->template->message_title = 'Successfully Logged In';
						$this->template->message_text = "Welcome back to MedVoyager!";
						$this->template->message_icon = 1;
						if(isset($post_login_redirect_url))
							$this->template->set_global('redirect', $post_login_redirect_url);
						else
							$this->template->set_global('redirect', '/');

						return;
					} elseif(isset($post_login_redirect_url))
						$this->request->redirect($post_login_redirect_url);
					else
						$this->request->redirect('/');
				}

			}
			if(!$valid) {
				if($login_attempt = Session::instance()->get('invalid_login_attempts')) {
					Session::instance()->set('invalid_login_attempts',$login_attempt+1);
				} else {
					Session::instance()->set('invalid_login_attempts',1);
				}
			}

			$this->template->errors = $validation->errors('login');
		}
		if(isset($_REQUEST['redirect']))
			Session::instance()->set('post_login_redirect_url',$_REQUEST['redirect']);
	}

	public function action_api() {

		// Set the name of the template to use
		$this->template->set_filename('login_api');

		if ($this->request->method() == Request::POST)
		{
			if(!empty($_REQUEST['cancel'])) {
                $this->request->redirect('medvoyager://cancel');
			}

			$validation = Validation::factory($this->request->post());

			$validation
				->rule('csrf',						'not_empty')
				->rule('csrf',						'Security::check')
			;

			if( $validation->check() ){


				$validation = Validation::factory($this->request->post());
				$validation->rule('username', 'not_empty');
				$validation->rule('username', 'Controller_Login::isLoginOrEmail');
				$validation->rule('password', 'not_empty');
				$validation->rule('password', 'Auth::validlogin', array(':data'));

				if( $valid = $validation->check() ){

					if ($login = Auth::instance()->login($this->request->post('username'), $this->request->post('password')))
					{
						$post_login_redirect_url = Session::instance()->get('post_login_redirect_url');

						if(isset($post_login_redirect_url))
							$this->request->redirect($post_login_redirect_url);
						else
							$this->request->redirect('/');

						$successfulSubmission = true;
					}
				}
			}

			// Display data that was previously as well as any validation errors
			$this->template->errors = $validation->errors('login');
		}
		if(isset($_REQUEST['redirect']))
			Session::instance()->set('post_login_redirect_url',$_REQUEST['redirect']);

	}

	public function action_forgot()
	{
		if(Auth::instance()->logged_in() != 0) {
			if($this->request->is_ajax())
				$this->template->set_global('redirect', '/profile/');
			else
				$this->request->redirect('/profile/');
		}

		// Set the name of the template to use
		$this->template->set_filename('login_forgot');

		// Create new Recaptcha object from global keys
		$Recaptcha = new Recaptcha();

		// On form submission
		if ($this->request->method() == Request::POST)
		{

			$validation = Validation::factory($this->request->post());

			$validation
				->rule('csrf',						'not_empty')
				->rule('csrf',						'Security::check')
				->rule('login_or_email',			'not_empty')
			;

			if(!$this->request->is_ajax()) {
				$validation->rule('recaptcha_response_field',	'not_empty');
				$validation->rule('recaptcha_response_field',	'Recaptcha::validRecaptcha', array(':validation'));
			}

			if( $validation->check() ){


				$validation = Validation::factory($this->request->post());
				$validation->rule('login_or_email',			'Controller_Login::isLoginOrEmail');

				if( $validation->check() ){

					$user = ORM::factory('user')->where('username','=',$this->request->post('login_or_email'))->or_where('email','=',$this->request->post('login_or_email'))->find();

					// Create a new autologin token
					$token = ORM::factory('user_token');

					// Set token data
					$token->user_id = $user->pk();
					$token->expires = time() + 3600;
					$token->save();



					# Log new User Email
					$message = ORM::factory('message');
					$message->addTo($token->user->email);
					$message->message_from = 'noreply@colorfulstudio.com';
					$message->message_subject = 'MedVoyager: Forgot Password';

					$email_template = View::factory('email/forgot_password');
					$email_template->token = $token->token;
					$email_template->user = $token->user;

					$response = SimpleEmailService::factory()->sendEmail($message,$email_template);

					// Redirect to report thank you
					$this->template->set_filename('message');
					$this->template->message_title = 'Forgot Password Token Sent';
					$this->template->message_text = 'Your forgot password token has been sent.  Please click on the link in the email or click the link below to enter the token.';
					$this->template->message_icon = 1;
					$this->template->set_global('redirect', '/login/token');
				}
			}
			$this->template->errors = $validation->errors('login');
		}


		// Normal data to display
		$this->template->recaptcha = array(
			'server'=>RECAPTCHA_API_SERVER,
			'key'=>$Recaptcha->public_key(),
		);
	}

	public function action_token()
	{
		if(Auth::instance()->logged_in() != 0) {
			if($this->request->is_ajax())
				$this->template->set_global('redirect', '/profile/');
			else
				$this->request->redirect('/profile/');
		}

		if($this->request->query('token')) {

			// Load the token and user
			$token = ORM::factory('user_token', array('token' => $this->request->query('token')));

			if ($token->loaded() AND $token->user->loaded())
			{

				if($this->request->query('cancel')!=1)
					Auth::instance()->force_login($token->user, true);

				//remove token
				$token->delete();

				if($this->request->query('cancel')!=1)
					$this->request->redirect('/profile/account/');

			} else {
				$this->template->errors = array(
					'token' => "token is invalid"
				);
			}
		}
		$this->request->redirect('/');
	}

	public static function isLoginOrEmail($login_or_email) {
		return (boolean)(ORM::factory('user')->where('username','=',$login_or_email)->or_where('email','=',$login_or_email)->find()->loaded());
	}
}