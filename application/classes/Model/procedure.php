<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Medical Procedure
 * @author davidf
 *
 */
class Model_Procedure extends Model_Base {

	protected $_table_name = 'procedures';

	protected $_primary_key = 'procedure_id';

	// Relationships
	protected $_belongs_to = array(
		'user'			=> array(),
		//'parent'   	=> array('model'=>'category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_many = array(
		//'children'	=> array('model'=>'category', 'foreign_key' => 'parent_id'),
	);

	public function labels()
	{
		return array(
			'procedure_id'				=> 'procedure id',
			'user_id'					=> 'user id',
			'procedure_name'			=> 'name',
			'procedure_hospital'		=> 'hospital',
			'procedure_date'			=> 'date',
			'procedure_physician'		=> 'physician',
			'procedure_date_modified'	=> 'date modified',
		);
	}

	public function filters()
	{
		return array(
			'procedure_name' => array(
				array('trim'),
			),
			'procedure_hospital' => array(
				array('trim'),
			),
			'procedure_date' => array(
				array('trim'),
			),
			'procedure_physician' => array(
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
			'procedure_name' => array(
				array('not_empty'),
				array('max_length', array(':value', 32)),
			),
			'procedure_hospital' => array(
				array('not_empty'),
				array('max_length', array(':value', 100)),
			),
			'procedure_date' => array(
				array('not_empty'),
			),
			'procedure_physician' => array(
				array('max_length', array(':value', 32)),
			),
		);
	}
}