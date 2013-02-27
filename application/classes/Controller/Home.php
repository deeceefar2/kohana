<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Home extends Controller_Base {

	public function action_index()
	{
		$this->template->set_filename('home');
		//$this->template->featured_listings = ORM::factory('listing')->where('listing_state','&','2')->limit(3)->find_all();
		//$this->template->local_listings = ORM::factory('listing')->order_by('listing_review_value','desc')->limit(3)->find_all();
	}

}
