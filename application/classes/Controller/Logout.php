<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Logout extends Controller_Base {

	/**
	 * Logout ..
	 */
	public function action_index()
	{
		Auth::instance()->logout(TRUE);

		$post_logout_redirect_url = Session::instance()->get('post_logout_redirect_url');
		//die($post_logout_redirect_url . ' or ' . $this->request->referrer());
		if(isset($post_logout_redirect_url))
			$this->redirect($post_logout_redirect_url,303);
		else
			$this->redirect($this->request->referrer(),303);
	}
}