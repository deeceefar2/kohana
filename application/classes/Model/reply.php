<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Reply Model
 * @author davidf
 *
 */
class Model_Reply extends Model_Base {

	protected $_table_name = 'replies';

	protected $_primary_key = 'reply_id';

	protected $_belongs_to = array(
		'review'   	=> array(),
	);

	protected $_has_many = array(
		//'children'	=> array('model'=>'category', 'foreign_key' => 'parent_id'),
	);

	public function save(Validation $validation = NULL)
	{
		try{
			$return = parent::save($validation);

			$this->review->reply_id = $this->reply_id;

			$this->review->save();

			return $return;

		} catch( Exception $e ) {
			throw $e;
		}
	}

	public function labels()
	{
		return array(
			'question_id'				=> 'question id',
			'user_id'					=> 'user id',
			'question_title'			=> 'question',
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
			'question_title' => array(
				array('not_empty'),
				array('max_length', array(':value', 255)),
			),
		);
	}
}