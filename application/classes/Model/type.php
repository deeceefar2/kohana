<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Category Model
 * @author davidf
 *
 */
class Model_Type extends Model_Base {

	protected $_table_name = 'types';

	protected $_primary_key = 'type_id';

	protected $_belongs_to = array(
		'user'			=> array(),
		//'parent'   	=> array('model'=>'category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_one = array(
		//'parent'   	=> array('model'=>'category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_many = array(
		'listings'	=> array(),
		'fields'	=> array(),
		//'children'	=> array('model'=>'category', 'foreign_key' => 'parent_id'),
	);

	public function labels()
	{
		return array(
			'type_id'				=> 'type id',
			'user_id'				=> 'user id',
			'type_name'				=> 'name',
			'type_description'		=> 'description',
			'type_date_modified'	=> 'date modified',
		);
	}

	public function filters()
	{
		return array(
			'type_name' => array(
				array('trim'),
			),
			'type_description' => array(
				array('trim'),
			)
		);
	}

	public function rules()
	{
		return array(
			'user_id' => array(
				array('not_empty'),
				array(array($this,'exists'), array('users', ':field', ':value', ':validation')),
			),
			'type_name' => array(
				array('not_empty'),
				array('max_length', array(':value', 32)),
			),
		);
	}

	public function as_array($children = false) {
		if(!$children)
			return parent::as_array();

		$array = parent::as_array();

		$fields = $this->fields->find_all()->as_array();
		if(sizeof($fields)>0)
			$array['fields'] = array('field'=>array_map( create_function( '$obj', 'return is_a($obj,"ORM") ? $obj->as_array(true) : $obj;'), $fields));
		return $array;
	}
}