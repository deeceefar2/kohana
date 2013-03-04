<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Report Model
 * @author davidf
 *
 */
class Model_Report extends Model_Base {

	protected $_table_name = 'reports';

	protected $_primary_key = 'report_id';

	// Relationships
	protected $_belongs_to = array(
		'user'				=> array(),
		'report_type'		=> array(),
		'report_category'	=> array(),
		'listing'			=> array(),
		'object_user'		=> array('model'=>'User', 'foreign_key' => 'object_user_id'),
	);

	protected $_has_one = array(
//		'categories'	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),

	);

	protected $_has_many = array(
//		'categories'	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),

	);

	protected $_sorting = array(
		'report_date_modified'=>'DESC',
	);

	public function labels()
	{
		return array(
			'report_id'				=> 'id',
			'report_type_id'		=> 'type id',
			'report_category_id'	=> 'category id',
			'report_title'			=> 'title',
			'report_text'			=> 'text',
			'report_date_modified'	=> 'date modified',
			'object_id'				=> 'object id',
			'object_user_id'		=> 'object user id',
		);
	}

	public function filters()
	{
		return array(
			'report_title' => array(
				array('trim'),
			),
		);
	}

	public function rules()
	{
		return array(
			'report_type_id' => array(
				array('not_empty'),
				array(array($this,'exists'), array('report_types', ':field', ':value', ':validation')),
			),
			'report_category_id' => array(
				array('not_empty'),
				array(array($this,'exists'), array('report_categories', ':field', ':value', ':validation')),
			),
			'report_title' => array(
				array('not_empty'),
			),
			'report_text' => array(
				array('not_empty'),
			),
			'object_user_id' => array(
				array('not_empty'),
				array(array($this,'exists'), array('users', 'user_id', ':value', ':validation')),
			),
		);
	}
}