<?php
/**
 * API class for Categories
 *
 * @package    MedVoyager
 * @author     David Farnan
 * @copyright  (c) 2011 Colorful Studio
 */
class Controller_API_Categories extends Controller_API
{

	protected $_model = false;

	protected $_object_name = 'category';

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

		$output = array();
		foreach ($object->categories->find_all() as $category)
		{
			$output[] = $category->as_array();
		}

		$this->_response_payload = $output;
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

		$output = array();
		foreach ($object->listings->find_all() as $listing)
		{
			$output[] = $listing->as_array();
		}

		$this->_response_payload = $output;
	}

	/**
	 * POST /api/objects
	 *
	 * @return null
	 */
	public function post_collection()
	{
		throw new HTTP_Exception_404(ucfirst(Inflector::camelize(Inflector::humanize($this->_model->object_name()))) . ' Not Found!');

		$this->_model->values($this->_request_payload);

		$this->_model->user_id = $this->_oauth_user_id;

		$this->_model->save();

		$this->_response_payload = $this->_model->as_array();
	}

	/**
	 * PUT /api/objects/:id
	 *
	 * @return null
	 */
	public function put()
	{
		throw new HTTP_Exception_404(ucfirst(Inflector::camelize(Inflector::humanize($this->_model->object_name()))) . ' Not Found!');

		$object = $this->_model->where($this->_model->object_name().'.'.$this->_model->primary_key(),'=',$this->request->param('id'))->find();

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

		$objects =& $this->_model->find_all();

		foreach ($objects as $object)
		{
			$object->delete();
		}
	}
}