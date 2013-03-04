<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Allergy Model
 * @author davidf
 *
 */
class Model_Allergy extends Model_Base {

	protected $_table_name = 'allergies';

	protected $_primary_key = 'allergy_id';

	protected $_belongs_to = array(
		'user'			=> array(),
		//'parent'   	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_one = array(
		//'parent'   	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_many = array(
		//'children'	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);

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
			'user_id' => array(
				array('not_empty'),
				array(array($this,'exists'), array('users', ':field', ':value', ':validation')),
			),
			'allergy_name' => array(
				array('not_empty'),
				array('max_length', array(':value', 32)),
			),
		);
	}
}