<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Message extends Controller_Base {

	public function action_index()
	{
		// Set the name of the template to use
		$this->template->set_filename('message');

		$this->template->message_icon = $this->request->post('message_icon');
		$this->template->message_title = $this->request->post('message_title');
		$this->template->message_text = $this->request->post('message_text');
	}
}
