<?php
/**
 * API class for Reviews
 *
 * @package    MedVoyager
 * @author     David Farnan
 * @copyright  (c) 2011 Colorful Studio
 */
class Controller_API_Reviews extends Controller_API
{

	protected $_model = false;

	protected $_object_name = 'review';

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

		$this->_response_payload = $object->with('reply')->as_array();
	}

	/**
	 * GET /api/objects
	 *
	 * @return null
	 */
	public function get_collection()
	{
		$this->_response_payload = $this->_model->with('reply')->find_all()->as_array();
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

		$this->_response_payload = $this->_model->as_array();

		$listing = ORM::factory('listing')->where('listing_id','=',$this->_request_payload['listing_id'])->find();

		if($listing->loaded() && floor($listing->listing_state / 2) % 2 == 1  && $this->_model->review_title !='' && $this->_model->review_body != '') {

			# Log new User Email
			$message = ORM::factory('message');
			$message->addTo('deeceefar2@gmail.com');
			$message->addReplyTo('admin@medvoyager.com');
			$message->message_from = 'noreply@colorfulstudio.com';
			$message->message_subject = "MedVoyager: Premium Listing Reviewed";

			$email_template = View::factory('email/review');
			$email_template->listing = $listing->as_array();
			$email_template->review = $this->_model->as_array();

			$response = SimpleEmailService::factory()->sendEmail($message,$email_template);
		}
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

		$this->_response_payload = $object->as_array();
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