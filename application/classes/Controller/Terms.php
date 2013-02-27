<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Terms extends Controller_Base {

	public function action_index()
	{
		// Set the name of the template to use
		$this->template->set_filename('terms_of_use');
	}

}
