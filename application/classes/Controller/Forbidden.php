<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Forbidden extends Controller_Base {

	public function action_index()
	{
		$this->template->set_filename('message');
		$this->template->message_title = 'Access Forbidden';
		$this->template->message_text = 'You do not have the required access level to view this webpage.';
		$this->template->message_icon = 3;
	}

}
