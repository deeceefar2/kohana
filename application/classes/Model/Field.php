<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Field Model
 * @author davidf
 *
 */
class Model_Field extends Model_Base {

	protected $_table_name = 'fields';

	protected $_primary_key = 'field_id';

	protected $_belongs_to = array(
		'user'					=> array(),
		'type'					=> array(),
		'Field_type'			=> array(),
		'default_field_value'	=> array('model'=>'Field_Value', 'foreign_key' => 'default_field_value_id'),
		//'parent'				=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_many = array(
		'listing_fields'	=> array(),
		'field_values'		=> array(),
	);

	protected $_load_with = array(
		'field_type',
		'default_field_value',
	);

	public function as_array($children = false) {
		if(!$children)
			return parent::as_array();

		$array = parent::as_array();

		$field_values = $this->field_values->find_all()->as_array();
		if(sizeof($field_values)>0)
			$array['field_values'] = $field_values;
		return $array;
	}
/*
	public function labels()
	{
		return array(
			'allergy_id'			=> 'allergy id',
			'user_id'				=> 'user id',
			'allergy_name'			=> 'name',
			'allergy_medication'	=> 'medication',
			'allergy_date_modified'	=> 'date modified',
		);
	}

	public function filters()
	{
		return array(
			'allergy_name' => array(
				array('trim'),
			),
			'allergy_medication' => array(
				array('trim'),
			)
		);
	}

	public function rules()
	{
		return array(
			'allergy_name' => array(
				array('not_empty'),
				array('max_length', array(':value', 32)),
			),
			'user_id' => array(
				array(array($this,'exists'), array('users', ':field', ':value', ':validation')),
			),
		);
	}
	*/
}