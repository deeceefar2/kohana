<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_About extends Controller_Base {

	public function action_index()
	{
		$this->template->set_filename('about');
	}

}
