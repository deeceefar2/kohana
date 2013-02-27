<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Admin extends Controller_Base {

	public $auth_required = array('login','active','admin');

	public $site_title = 'MedVoyager:Admin';

	public function before() {

		parent::before();

		$this->template->view_path = 'assets/admin/xsl';
	}

	public function action_index()
	{
		// Set the name of the template to use
		$this->template->set_filename('home');
	}

}
