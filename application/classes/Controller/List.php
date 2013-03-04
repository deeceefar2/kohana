<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_List extends Controller_Base {

	public function action_index()
	{
		// Set the name of the template to use
		$this->template->set_filename('list_with_us');

		$this->template->premium_listing = ORM::factory('Listing')->where('listing_state','&','2')->order_by('listing_review_value','desc')->limit(1)->find_all();
		$this->template->free_listing = ORM::factory('Listing')->order_by('listing_review_value','desc')->limit(1)->find_all();
	}

}
