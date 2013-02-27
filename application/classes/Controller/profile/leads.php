<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Profile_Leads extends Controller_Base {

	public $auth_required = array('login','active');

	public function action_index()
	{
		// Set the name of the template to use
		$this->template->set_filename('profile_leads');

		if ($_FILES) {
			$validation = Validation::factory(array('file'=>$_FILES['file']))
				->rule('file', 'not_empty')
				->rule('file', 'Upload::type', array(':value', array('png', 'jpeg', 'jpg', 'pdf', 'bmp')))
				->rule('file', 'Upload::size', array(':value', '25.0MiB'))
			;
			if ($validation->check()) {
				Upload::save($validation['file'], NULL, 'uploads/');
			} else {
			   echo Debug::vars($array->errors('files'));
			}
		}

		$this->template->listings = $this->user->listings->order_by('listing_date_modified','desc')->find_all();
	}

	public function action_edit()
	{
		// Set the name of the template to use
		$this->template->set_filename('profile_listings');

		$this->template->listings = $this->user->listings->with('listing:default_image')->with('listing:default_category')->find_all();
	}

	public function action_delete()
	{
		// Set the name of the template to use
		$this->template->set_filename('profile_listings');

		$this->template->listings = $this->user->listings->with('listing:default_image')->with('listing:default_category')->find_all();
	}

}
