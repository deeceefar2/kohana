<?php
/**
 * API class for Users
 *
 * @package    MedVoyager
 * @author     David Farnan
 * @copyright  (c) 2011 Colorful Studio
 */
class Controller_API_Users extends Controller_API
{

	protected $_model = false;

	protected $_object_name = 'user';

	public $oauth_actions = array(
			'post_collection',
			'put',
			'delete',
			'delete_collection',
		);


	/**
	 * Creates a new controller instance. Each controller must be constructed with the request object that created it.
	 *
	 * @return	void
	 */
	public function __construct(Request $request, Response $response)
	{
		parent::__construct($request,$response);

		$this->_oauth_verify = true;

		$this->_model = ORM::factory($this->_object_name);
	}

	/**
	 * Gets an object
	 *
	 * GET /api/objects/:id
	 *
	 * @return null
	 */
	public function get()
	{
		$object = $this->_model->where($this->_model->object_name().'.'.$this->_model->primary_key(),'=',$this->_oauth_user_id)->find();

		if ( ! $object->loaded())
		{
			throw new HTTP_Exception_404(ucfirst(Inflector::camelize(Inflector::humanize($this->_model->object_name()))) . ' Not Found!');
		}

		$this->_response_payload = $object->as_array();
	}

	/**
	 * GET /api/objects
	 *
	 * @return null
	 */
	public function get_collection()
	{
		$this->_response_payload = $this->_model->find_all()->as_array();
	}

	/**
	 * GET /api/objects/:id/contacts
	 *
	 * @return null
	 */
	public function get_contacts()
	{
		$object = $this->_model->where($this->_model->object_name().'.'.$this->_model->primary_key(),'=',$this->_oauth_user_id)->find();

		if ( ! $object->loaded())
		{
			throw new HTTP_Exception_404(ucfirst(Inflector::camelize(Inflector::humanize($this->_model->object_name()))) . ' Not Found!');
		}

		$this->_response_payload = $this->_model->contacts->find_all()->as_array();
	}

	/**
	 * GET /api/objects/:id/allergies
	 *
	 * @return null
	 */
	public function get_allergies()
	{
		$object = $this->_model->where($this->_model->object_name().'.'.$this->_model->primary_key(),'=',$this->_oauth_user_id)->find();

		if ( ! $object->loaded())
		{
			throw new HTTP_Exception_404(ucfirst(Inflector::camelize(Inflector::humanize($this->_model->object_name()))) . ' Not Found!');
		}

		$this->_response_payload = $this->_model->allergies->find_all()->as_array();
	}

	/**
	 * GET /api/objects/:id/procedures
	 *
	 * @return null
	 */
	public function get_procedures()
	{
		$object = $this->_model->where($this->_model->object_name().'.'.$this->_model->primary_key(),'=',$this->_oauth_user_id)->find();

		if ( ! $object->loaded())
		{
			throw new HTTP_Exception_404(ucfirst(Inflector::camelize(Inflector::humanize($this->_model->object_name()))) . ' Not Found!');
		}

		$this->_response_payload = $this->_model->procedures->find_all()->as_array();
	}

	/**
	 * GET /api/objects/:id/medications
	 *
	 * @return null
	 */
	public function get_medications()
	{
		$object = $this->_model->where($this->_model->object_name().'.'.$this->_model->primary_key(),'=',$this->_oauth_user_id)->find();

		if ( ! $object->loaded())
		{
			throw new HTTP_Exception_404(ucfirst(Inflector::camelize(Inflector::humanize($this->_model->object_name()))) . ' Not Found!');
		}

		$this->_response_payload = $this->_model->medications->find_all()->as_array();
	}

	/**
	 * GET /api/objects/:id/bookmarks
	 *
	 * @return null
	 */
	public function get_bookmarks()
	{
		$object = $this->_model->where($this->_model->object_name().'.'.$this->_model->primary_key(),'=',$this->_oauth_user_id)->find();

		if ( ! $object->loaded())
		{
			throw new HTTP_Exception_404(ucfirst(Inflector::camelize(Inflector::humanize($this->_model->object_name()))) . ' Not Found!');
		}

		$this->_response_payload = $this->_model->bookmarks->with('listing:default_image')->with('listing:default_category')->find_all()->as_array();
	}

	/**
	 * GET /api/objects/:id/searches
	 *
	 * @return null
	 */
	public function get_searches()
	{
		$object = $this->_model->where($this->_model->object_name().'.'.$this->_model->primary_key(),'=',$this->_oauth_user_id)->find();

		if ( ! $object->loaded())
		{
			throw new HTTP_Exception_404(ucfirst(Inflector::camelize(Inflector::humanize($this->_model->object_name()))) . ' Not Found!');
		}

		$this->_response_payload = $this->_model->searches->and_where('search_query','!=','')->and_where('search_name','=','')->order_by('search_date_modified','desc')->find_all()->as_array();
	}

	/**
	 * GET /api/objects/:id/quick_help
	 *
	 * @return null
	 */
	public function get_quick_help()
	{
		$object = $this->_model->where($this->_model->object_name().'.'.$this->_model->primary_key(),'=',$this->_oauth_user_id)->find();

		if ( ! $object->loaded())
		{
			throw new HTTP_Exception_404(ucfirst(Inflector::camelize(Inflector::humanize($this->_model->object_name()))) . ' Not Found!');
		}

		$this->_response_payload = $this->_model->searches->where('search_name','!=','')->order_by('search_date_modified','desc')->find_all()->as_array();
	}

	/**
	 * GET /api/objects/:id/listings
	 *
	 * @return null
	 */
	public function get_listings()
	{
		$object = $this->_model->where($this->_model->object_name().'.'.$this->_model->primary_key(),'=',$this->_oauth_user_id)->find();

		if ( ! $object->loaded())
		{
			throw new HTTP_Exception_404(ucfirst(Inflector::camelize(Inflector::humanize($this->_model->object_name()))) . ' Not Found!');
		}

		$this->_response_payload = $this->_model->listings->find_all()->as_array();
	}

	/**
	 * GET /api/objects/:id/reviews
	 *
	 * @return null
	 */
	public function get_reviews()
	{
		$object = $this->_model->where($this->_model->object_name().'.'.$this->_model->primary_key(),'=',$this->_oauth_user_id)->find();

		if ( ! $object->loaded())
		{
			throw new HTTP_Exception_404(ucfirst(Inflector::camelize(Inflector::humanize($this->_model->object_name()))) . ' Not Found!');
		}

		$this->_response_payload = $this->_model->reviews->find_all()->as_array();
	}

	/**
	 * POST /api/objects
	 *
	 * @return null
	 */
	public function post_collection()
	{
		throw new HTTP_Exception_404(ucfirst(Inflector::camelize(Inflector::humanize($this->_model->object_name()))) . ' Not Found!');
/*
		$this->_model->values($this->_request_payload);
		try{
			$this->_model->save();
		} catch( Exception $e ) {
			die('register not allowed');
			throw new HTTP_Exception_404(ucfirst(Inflector::camelize(Inflector::humanize($this->_model->object_name()))) . ' Not Found!');

		}
*/
		$this->_response_payload = $this->_model->as_array();
	}

	/**
	 * PUT /api/objects/:id
	 *
	 * @return null
	 */
	public function put()
	{

		$object = $this->_model->where($this->_model->object_name().'.'.$this->_model->primary_key(),'=',$this->_oauth_user_id)->find();

		if ( ! $object->loaded())
		{
			throw new HTTP_Exception_404(ucfirst(Inflector::camelize(Inflector::humanize($this->_model->object_name()))) . ' Not Found!');
		}

		$object->values($this->_request_payload);

		$object->user_id = $this->_oauth_user_id;

		$object->save();

		$this->_response_payload = $object->as_array();
	}

	/**
	 * DELETE /api/objects/:id
	 *
	 * @return null
	 */
	public function delete()
	{
		throw new HTTP_Exception_404(ucfirst(Inflector::camelize(Inflector::humanize($this->_model->object_name()))) . ' Not Found!');
		$object = $this->_model->where($this->_model->object_name().'.'.$this->_model->primary_key(),'=',$this->request->param('id'))->find();

		if ( ! $object->loaded())
		{
			throw new HTTP_Exception_404(ucfirst(Inflector::camelize(Inflector::humanize($this->_model->object_name()))) . ' Not Found!');
		}

		$object->delete();
	}

	/**
	 * DELETE /api/objects
	 *
	 * @return null
	 */
	public function delete_collection()
	{
		throw new HTTP_Exception_404(ucfirst(Inflector::camelize(Inflector::humanize($this->_model->object_name()))) . ' Not Found!');

		$objects = $this->_model->find_all();

		foreach ($objects as $object)
		{
			$object->delete();
		}
	}
}