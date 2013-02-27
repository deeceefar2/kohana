<?php
/**
 * API class for Searches
 *
 * @package    MedVoyager
 * @author     David Farnan
 * @copyright  (c) 2011 Colorful Studio
 */
class Controller_API_Searches extends Controller_API
{

	protected $_model = false;

	protected $_object_name = 'search';

	public $oauth_actions = array(
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

		$this->_oauth_verify = false;

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
		$object = $this->_model->where($this->_model->object_name().'.'.$this->_model->primary_key(),'=',$this->request->param('id'))->find();

		if ( ! $object->loaded())
		{
			throw new HTTP_Exception_404(ucfirst(Inflector::camelize(Inflector::humanize($this->_model->object_name()))) . ' Not Found!');
		}

		$this->_response_payload = $object->as_array(true);

		$this->_model->save();
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
	 * GET /api/objects/:id/listings
	 *
	 * @return null
	 */
	public function get_listings()
	{
		$object = $this->_model->where($this->_model->object_name().'.'.$this->_model->primary_key(),'=',$this->request->param('id'))->find();

		if ( ! $object->loaded())
		{
			throw new HTTP_Exception_404(ucfirst(Inflector::camelize(Inflector::humanize($this->_model->object_name()))) . ' Not Found!');
		}

		$this->_response_payload = $this->_model->listings()->as_array();
	}

	/**
	 * GET /api/objects/:id/categories
	 *
	 * @return null
	 */
	public function get_categories()
	{
		$object = $this->_model->where($this->_model->object_name().'.'.$this->_model->primary_key(),'=',$this->request->param('id'))->find();

		if ( ! $object->loaded())
		{
			throw new HTTP_Exception_404(ucfirst(Inflector::camelize(Inflector::humanize($this->_model->object_name()))) . ' Not Found!');
		}

		$this->_response_payload = $this->_model->categories();
	}

	/**
	 * GET /api/objects/:id/device
	 *
	 * @return null
	 */
	public function get_device()
	{
		$this->_response_payload = $this->_model->where($this->_model->object_name().'.device_id','=',$this->request->param('id'))->and_where('search_query','!=','')->and_where('search_name','=','')->order_by('search_date_modified','desc')->find_all()->as_array();
	}

	/**
	 * POST /api/objects
	 *
	 * @return null
	 */
	public function post_collection()
	{
		$this->_model->values($this->_request_payload);

		$this->_model->user_id = $this->_oauth_user_id;

		$this->_model->save();

		$this->_response_payload = $this->_model->as_array(true);
	}

	/**
	 * PUT /api/objects/:id
	 *
	 * @return null
	 */
	public function put()
	{

		$object = $this->_model->where($this->_model->object_name().'.'.$this->_model->primary_key(),'=',$this->request->param('id'))->find();

		if ( ! $object->loaded())
		{
			throw new HTTP_Exception_404(ucfirst(Inflector::camelize(Inflector::humanize($this->_model->object_name()))) . ' Not Found!');
		}

		$object->values($this->_request_payload);

		$object->user_id = $this->_oauth_user_id;

		$object->save();

		$this->_response_payload = $object->as_array(true);
	}

	/**
	 * DELETE /api/objects/:id
	 *
	 * @return null
	 */
	public function delete()
	{
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

		$objects =& $this->_model->find_all();

		foreach ($objects as $object)
		{
			$object->delete();
		}
	}
}