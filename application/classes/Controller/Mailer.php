<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Mailer extends Controller_Base {

	public $auth_required = array('login','active');

	public function action_index()
	{
		// Set the name of the template to use
		$this->template->set_filename('mailer');
	}

}
