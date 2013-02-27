<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Medication Model
 * @author davidf
 *
 */
class Model_Medication extends Model_Base {

	protected $_table_name = 'medications';

	protected $_primary_key = 'medication_id';

	// Relationships
	protected $_belongs_to = array(
		'user'			=> array(),
		//'parent'   	=> array('model'=>'category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_one = array(
		//'parent'   	=> array('model'=>'category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_many = array(
		//'children'	=> array('model'=>'category', 'foreign_key' => 'parent_id'),
	);

	public function labels()
	{
		return array(
			'medication_id'				=> 'medication id',
			'user_id'					=> 'user id',
			'medication_name'			=> 'name',
			'medication_dose'			=> 'dose',
			'medication_start_date'		=> 'start date',
			'medication_condition'		=> 'condition',
			'medication_date_modified'	=> 'date modified',
		);
	}

	public function filters()
	{
		return array(
			'medication_name' => array(
				array('trim'),
			),
			'medication_dose' => array(
				array('trim'),
			),
			'medication_condition' => array(
				array('trim'),
			),
		);
	}

	public function rules()
	{
		return array(
			'user_id' => array(
				array(array($this,'exists'), array('users', ':field', ':value', ':validation')),
			),
			'medication_name' => array(
				array('not_empty'),
				array('max_length', array(':value', 32)),
			),
			'medication_dose' => array(
				array('not_empty'),
				array('max_length', array(':value', 32)),
			),
			'medication_condition' => array(
				array('max_length', array(':value', 32)),
			),
		);
	}
}