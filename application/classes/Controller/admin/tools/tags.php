<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Admin_Tools_Tags extends Controller_Admin {

	public function action_index()
	{
		$this->template->set_filename('tools_tags');
	}
	
	public function action_add()
	{
		$this->template->set_filename('tools_tags_form');
	}
	
	public function action_edit()
	{
		$this->request->param('id');
		
		$this->template->set_filename('tools_tags');
	}
	
	public function action_delete()
	{
		$this->template->set_filename('tools_tags');
	}

}