<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Question Section Model
 * @author davidf
 *
 */
class Model_Question_Section extends Model_Base {

	protected $_table_name = 'question_sections';

	protected $_primary_key = 'question_section_id';

	protected $_belongs_to = array(
		'user'				=> array(),
		//'parent'			=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_many = array(
		'questions'		=> array(),
		//'children'	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);

	public function labels()
	{
		return array(
			'question_section_id'				=> 'id',
			'user_id'							=> 'user id',
			'question_section_title'			=> 'title',
			'question_section_date_modified'	=> 'date modified',
		);
	}

	public function filters()
	{
		return array(
			'question_section_title' => array(
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
			'question_section_title' => array(
				array('not_empty'),
				array('max_length', array(':value', 255)),
			),
		);
	}
}