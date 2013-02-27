<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Category Model
 * @author davidf
 *
 */
class Model_Category extends Model_Base {

	protected $_table_name = 'categories';

	protected $_primary_key = 'category_id';

	protected $_sorting = array(
		'category_name'=>'ASC',
	);

	protected $_belongs_to = array(
		'parent'   	=> array('model'=>'category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_many = array(
		'categories'	=> array('model'=>'category', 'foreign_key' => 'parent_id'),
		'listings'	=> array('model'=>'listing', 'through'=>'listing_categories'),

	);

	public function labels()
	{
		return array(
			'category_id'				=> 'category id',
			'parent_id'					=> 'parent category id',
			'category_name'				=> 'name',
			'category_slug'				=> 'slug',
			'category_date_modified'	=> 'date modified',
		);
	}

	public function filters()
	{
		return array(
			'category_name' => array(
				array('trim'),
			),
			'category_slug' => array(
				array('trim'),
				array('URL::title'),
			)
		);
	}

	public function rules()
	{
		return array(
			'parent_id' => array(
				array('not_empty'),
				array(array($this,'exists'), array('categories', 'category_id', ':value', ':validation')),
			),
			'category_name' => array(
				array('not_empty'),
				array('min_length', array(':value', 3)),
				array('max_length', array(':value', 50)),
			),
			'category_slug' => array(
				array('not_empty'),
				array('alpha_dash'),
				array('min_length', array(':value', 3)),
				array('max_length', array(':value', 50)),
			),
		);
	}

	/**
	 * Saves the current object.
	 *
	 * @return  ORM
	 */
	public function save(Validation $validation = NULL)
	{
		$this->category_slug = $this->category_name;
		return parent::save($validation);
	}
}