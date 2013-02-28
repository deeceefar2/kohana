<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Profile_Listings extends Controller_Base {

	public $auth_required = array('login','active');

	public function action_index()
	{
		// Set the name of the template to use
		$this->template->set_filename('profile_listings');

		$this->template->listings = $this->user->listings->with('listing:default_image')->with('listing:default_category')->find_all();
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
