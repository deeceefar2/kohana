<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Contact Model
 * @author davidf
 *
 */
class Model_Contact extends Model_Base {

	protected $_table_name = 'contacts';

	protected $_primary_key = 'contact_id';

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
			'contact_id'			=> 'contact id',
			'user_id'				=> 'user id',
			'contact_first_name'	=> 'first name',
			'contact_last_name'		=> 'last name',
			'contact_phone_1'		=> 'phone number primary',
			'contact_phone_2'		=> 'phone number secondary',
			'contact_email'			=> 'email',
			'contact_relationship'	=> 'relationship',
			'contact_date_modified'	=> 'date modified',

		);
	}

	public function filters()
	{
		return array(
			'contact_first_name' => array(
				array('trim'),
			),
			'contact_last_name' => array(
				array('trim'),
			),
			'contact_phone_1' => array(
				array('trim'),
			),
			'contact_phone_2' => array(
				array('trim'),
			),
			'contact_email' => array(
				array('trim'),
			),
			'contact_relationship' => array(
				array('trim'),
			),
		);
	}

	public function rules()
	{
		return array(
			'user_id' => array(
				array('not_empty'),
				array(array($this,'exists'), array('users', ':field', ':value', ':validation')),
			),
			'contact_first_name' => array(
				array('not_empty'),
				array('max_length', array(':value', 50)),
			),
			'contact_last_name' => array(
				array('not_empty'),
				array('max_length', array(':value', 50)),
			),
			'contact_phone_1' => array(
				array('phone'),
			),
			'contact_phone_2' => array(
				array('phone'),
			),
			'contact_email' => array(
				array('email'),
			),
			'contact_relationship' => array(
				array('not_empty'),
				array('max_length', array(':value', 50)),
			),
		);
	}
}