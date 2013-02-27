<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Advertise extends Controller_Base {

	public function action_index()
	{
		// Set the name of the template to use
		$this->template->set_filename('advertise');
	}

}
