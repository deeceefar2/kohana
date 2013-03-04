<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Question Model
 * @author davidf
 *
 */
class Model_Question extends Model_Base {

	protected $_table_name = 'questions';

	protected $_primary_key = 'question';

	protected $_belongs_to = array(
		'question_section'	=> array(),
		'user'				=> array(),
		//'parent'   	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_many = array(
		//'children'	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);

	public function labels()
	{
		return array(
			'question_id'				=> 'id',
			'question_section_id'		=> 'question section id',
			'user_id'					=> 'user id',
			'question_title'			=> 'title',
			'question_slug'				=> 'slug',
			'question_answer'			=> 'answer',
			'question_date_modified'	=> 'date modified',
		);
	}

	public function filters()
	{
		return array(
			'question_title' => array(
				array('trim'),
			),
			'question_answer' => array(
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
			'question_section_id' => array(
				array(array($this,'exists'), array('users', ':field', ':value', ':validation')),
			),
			'question_title' => array(
				array('not_empty'),
				array('max_length', array(':value', 255)),
			),
		);
	}
}