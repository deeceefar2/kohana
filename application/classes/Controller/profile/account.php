<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Profile_Account extends Controller_Base {

	public $auth_required = array('login','active');

	public function action_index()
	{
		// Set the name of the template to use
		$this->template->set_filename('profile_account');

		if($this->request->method() == Request::POST) {

			try{
				// Initialize the validation library and setup some rules
				$validation = Validation::factory($this->request->post());

				$validation
					->rule('csrf',							'not_empty')
					->rule('csrf',							'Security::check')
				;

				if($this->request->post('_password')) {
					if(Session::instance()->get('auth_forced') != 1) {
						$validation->rule('current_password', 'equals', array(Auth::instance()->hash($this->request->post('current_password')), $this->user->password));
					}

					$validation->rule('password_confirm',	'matches', array(':validation', 'password', ':field'));
					$validation->rule('password_confirm',	'not_empty');
				}


				$this->user->values($this->request->post());

				$this->user->save($validation);

			} catch (ORM_Validation_Exception $e) {
				$this->template->errors = $e->errors('models');
			}
		}
		$this->template->user = $this->user;
	}

}
