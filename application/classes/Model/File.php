<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * File Model
 * @author davidf
 *
 */
class Model_File extends Model_Base {

	protected $_table_name = 'files';

	protected $_primary_key = 'file_id';

	// Relationships
	protected $_belongs_to = array(
		//'parent'   	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_many = array(
		//'children'	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);
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