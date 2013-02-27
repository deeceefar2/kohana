<?php
/**
 * API class for Users
 *
 * @package    MedVoyager
 * @author     David Farnan
 * @copyright  (c) 2011 Colorful Studio
 */
class Controller_API_Logout extends Controller_API
{


	/**
	 * Creates a new controller instance. Each controller must be constructed with the request object that created it.
	 *
	 * @return	void
	 */
	public function __construct(Request $request, Response $response)
	{
		parent::__construct($request,$response);

		$this->_oauth_verify = true;
	}

	/**
	 * Gets an object
	 *
	 * GET /api/objects/:id
	 *
	 * @return null
	 */
	public function get_collection()
	{
		Auth::instance()->logout(TRUE);

		$this->_response_payload = array(
			'logout'	=> true,
		);
	}
}