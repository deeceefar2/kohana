<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Profile_Reviews extends Controller_Base {

	public $auth_required = array('login','active');

	public function action_index()
	{
		// Set the name of the template to use
		$this->template->set_filename('profile_reviews');

		$this->template->reviews = $this->user->reviews->with('listing:default_image')->with('listing:default_category')->order_by('review_date_modified','desc')->find_all();
	}

	public function action_delete()
	{
		// Set the name of the template to use
		$this->template->set_filename('review_delete');

		// Normal data to display
		$review = $this->user->reviews->where('review_id','=',$this->request->param('id'))->find();

		// On form submission
		if( $this->request->method() == Request::POST){
			// Initialize the validation library and setup some rules
			$validation = Validation::factory(
			array
				(
					'review_delete'	=> strtoupper($this->request->post('reviewDelete')),
					'csrf'				=> $this->request->post('csrf'),
				)
			);

			$validation
				->rules('review_delete',array(
						array('not_empty'),
						array('equals', array(':value', 'DELETE')),
					)
				)
				->rules('csrf',array(
						array('not_empty'),
						array('Security::check'),
					)
				);

			if( $validation->check() ){

				$listing = $review->listing;

				$review->delete();

				// Redirect to report thank you
				$this->template->set_filename('message');
				$this->template->message_title = 'Review Deleted';
				$this->template->message_text = 'Review for "' . $listing->listing_name . '" successfully deleted.';
				$this->template->message_icon = 1;
				$this->template->set_global('redirect', '/profile/reviews');

				return;
			}

			$this->template->errors = $validation->errors('review');
		}

		$this->template->review = $review;
		$this->template->listing = $review->listing;
	}
}
