<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Profile_Bookmarks extends Controller_Base {

	public $auth_required = array('login','active');

	public function action_index()
	{
		// Set the name of the template to use
		$this->template->set_filename('profile_bookmarks');

		$this->template->bookmarks = $this->user->bookmarks->with('listing:default_image')->with('listing:default_category')->find_all();
	}

	public function action_delete()
	{
		// Set the name of the template to use
		$this->template->set_filename('bookmark_delete');

		// Normal data to display
		$bookmark = $this->user->bookmarks->where('bookmark_id','=',$this->request->param('id'))->find();

		// On form submission
		if( $this->request->method() == Request::POST){
			// Initialize the validation library and setup some rules
			$validation = Validation::factory(
			array
				(
					'bookmark_delete'	=> strtoupper($this->request->post('bookmarkDelete')),
					'csrf'				=> $this->request->post('csrf'),
				)
			);

			$validation
				->rules('bookmark_delete',array(
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

				$listing = $bookmark->listing;

				$bookmark->delete();

				// Redirect to report thank you
				$this->template->set_filename('message');
				$this->template->message_title = 'Bookmark Deleted';
				$this->template->message_text = 'Bookmark for "' . $listing->listing_name . '" successfully deleted.';
				$this->template->message_icon = 1;
				$this->template->set_global('redirect', '/profile/bookmarks');

				return;
			}

			$this->template->errors = $validation->errors('bookmark');
		}

		$this->template->bookmark = $bookmark;
		$this->template->listing = $bookmark->listing;
	}
}
