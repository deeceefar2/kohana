<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Listing Model
 * @author davidf
 *
 */
class Model_Listing extends Model_Base {

	protected $_table_name = 'listings';

	protected $_primary_key = 'listing_id';

	protected $_bookmark = NULL;

	protected $_review = NULL;

	protected $_belongs_to = array(
		'user'				=> array(),
		'type'				=> array(),
		'default_image'		=> array('model'=>'file', 'foreign_key' => 'listing_default_image_id'),
		'default_category'	=> array('model'=>'category', 'foreign_key' => 'listing_default_category_id'),
		//'parent'			=> array('model'=>'category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_one = array(
		//'parent'   	=> array('model'=>'category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_many = array(
		'categories'		=> array('model'=> 'category', 'through' => 'listing_categories', 'foreign_key' => 'listing_id'),
		'reviews'			=> array('model'=> 'review', 'foreign_key' => 'listing_id'),
		'files'				=> array('model'=> 'file', 'through' => 'listing_files'),
		'bookmarks'			=> array('model'=> 'bookmark', 'foreign_key' => 'listing_id'),
		'listing_fields'	=> array(),
	);

	protected $_load_with = array(
		'default_image',
		'default_category',
	);

	public function labels()
	{
		return array(
			'listing_id'					=> 'listing id',
			'user_id'						=> 'user id',
			'type_id'						=> 'type id',
			'listing_state'					=> 'listing state',
			'listing_name'					=> 'name',
			'listing_information_small'		=> 'information small',
			'listing_information'			=> 'information',
			'listing_email'					=> 'email',
			'listing_website'				=> 'website',
			'listing_phone'					=> 'phone',
			'listing_fax'					=> 'fax',
			'listing_address_street_1'		=> 'street line 1',
			'listing_address_street_2'		=> 'street line 2',
			'listing_address_city'			=> 'city',
			'listing_address_state'			=> 'state',
			'listing_address_zip'			=> 'zip',
			'listing_address_lat'			=> 'latitude',
			'listing_address_long'			=> 'longitude',
			'listing_default_image_id'		=> 'default image id',
			'listing_default_category_id'	=> 'default category id',
			'listing_date_modified'			=> 'date modified',
			'listing_review_value'			=> 'rating',
			'listing_review_num'			=> 'number of reviews',
		);
	}

	public function filters()
	{
		return array(
			'listing_name' => array(
				array('trim'),
			),
			'listing_information' => array(
				array('trim'),
			),
			'listing_email' => array(
				array('trim'),
			),
			'listing_website' => array(
				array('trim'),
			),
			'listing_phone' => array(
				array('trim'),
			),
			'listing_fax' => array(
				array('trim'),
			),
			'listing_address_street_1' => array(
				array('trim'),
			),
			'listing_address_street_2' => array(
				array('trim'),
			),
			'listing_address_city' => array(
				array('trim'),
			),
			'listing_address_state' => array(
				array('trim'),
			),
			'listing_address_zip' => array(
				array('trim'),
			),
			'listing_address_lat' => array(
				array('trim'),
			),
			'listing_address_long' => array(
				array('trim'),
			),
		);
	}

	public function rules()
	{
		return array(
			'type_id' => array(
				array('not_empty'),
				array('regex', array(':value', '/^(?!default)/')),
				array(array($this,'exists'), array('types', ':field', ':value', ':validation')),
			),
			'user_id' => array(
				array('not_empty'),
				array(array($this,'exists'), array('users', ':field', ':value', ':validation')),
			),
			'listing_name' => array(
				array('not_empty'),
				array('min_length', array(':value', 2)),
				array('max_length', array(':value', 255)),
			),
			'listing_information' => array(
			),
			'listing_email' => array(
				array('email'),
				array('email_domain'),
			),
			'listing_website' => array(
				array('url'),
			),
			'listing_phone' => array(
				array('phone'),
			),
			'listing_fax' => array(
				array('phone'),
			),
			'listing_address_street_1' => array(
				array('not_empty'),
				array('max_length', array(':value', 255)),
			),
			'listing_address_street_2' => array(
				array('trim'),
				array('max_length', array(':value', 255)),
			),
			'listing_address_city' => array(
				array('not_empty'),
				array('max_length', array(':value', 255)),
			),
			'listing_address_state' => array(
				array('not_empty'),
				array('regex', array(':value', '/^(?!default)/')),
				array('max_length', array(':value', 255)),
			),
			'listing_address_zip' => array(
				array('not_empty'),
				array('max_length', array(':value', 255)),
			),
			'listing_address_lat' => array(
				array('max_length', array(':value', 12)),
			),
			'listing_address_long' => array(
				array('max_length', array(':value', 12)),
			),
			'listing_default_image_id' => array(
				array(array($this,'exists'), array('files', ':file_id', ':value', ':validation')),
			),
			'listing_default_category_id' => array(
				array('not_empty'),
				array('regex', array(':value', '/^(?!default)/')),
				array(array($this,'exists'), array('categories', 'category_id', ':value', ':validation')),
			),
		);
	}

	public function as_array($user_id = NULL) {
		$array = parent::as_array();
		if($user_id === NULL)
			return $array;

		$bookmark = $this->bookmarks->where('bookmark.user_id','=',$user_id)->find();
		$review = $this->reviews->where('review.user_id','=',$user_id)->find();
		if($bookmark->loaded())
			$array['bookmark'] = $bookmark;
		if($review->loaded()) {
			$array['review'] = $review;
		}
		return $array;
	}

	/**
	 * Saves the current object.
	 *
	 * @return  ORM
	 */
	public function save(Validation $validation = NULL)
	{
		$this->listing_slug = URL::title($this->listing_name);
		if($validation == null) {

		}
		return parent::save($validation);
	}
}