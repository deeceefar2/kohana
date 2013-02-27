<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Location extends Controller_Base {

	public function action_index()
	{
		if($this->request->query('latitude') && $this->request->query('longitude')) {
			Session::instance()->set('location', array('latitude'=>$this->request->query('latitude'),'longitude'=>$this->request->query('longitude')));

			$this->template->set_filename('message');
			$this->template->message_title = 'Location Shared';
			$this->template->message_text = 'Your location has been stored for this session.   You may clear this setting at any time by logging out or resetting your session cookies.';
			$this->template->message_icon = 1;
		} elseif($this->request->query('denied')) {
			Session::instance()->set('location', 'denied');

			$this->template->set_filename('message');
			$this->template->message_title = 'Location Sharing Denied';
			$this->template->message_text = 'We have stored your location tracking preferences.  You may clear this setting at any time by logging out or resetting your session cookies.';
			$this->template->message_icon = 3;
		} elseif($this->request->query('unavailable')) {
			Session::instance()->set('location', 'unavailable');

			$this->template->set_filename('message');
			$this->template->message_title = 'Location Sharing Unavailable';
			$this->template->message_text = 'We attempted to gather your location; however it was marked unavailable by your browser.  We will instead use your ipaddress You may clear this setting at any time by logging out or resetting your session cookies.';
			$this->template->message_icon = 3;
		}
	}

}
