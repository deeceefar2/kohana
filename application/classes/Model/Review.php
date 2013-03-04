<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Review Model
 * @author davidf
 *
 */
class Model_Review extends Model_Base {

	protected $_table_name = 'reviews';

	protected $_primary_key = 'review_id';

	// Relationships
	protected $_belongs_to = array(
		'listing'   	=> array(),
		'user'			=> array(),
	);

	// Relationships
	protected $_has_one = array(
		'reply'   	=> array(),
	);

	protected $_has_many = array(
		//'children'	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);

	protected $_sort = array(
		'review_date_modified' => 'desc',
	);

	public function labels()
	{
		return array(
			'review_id'					=> 'review id',
			'listing_id'				=> 'listing id',
			'user_id'					=> 'user id',
			'review_rating'				=> 'rating',
			'review_title'				=> 'title',
			'review_body'				=> 'body',
			'reply_id'					=> 'reply id',
			'username'					=> 'username',
			'review_date_modified'		=> 'review date modified',
		);
	}

	public function rules()
	{
		return array(
			'listing_id' => array(
				array('not_empty'),
				array(array($this,'exists'), array('listings', ':field', ':value', ':validation')),
				array(array($this,'unique_listing'), array(':field', ':value', ':data', ':validation')),
			),
			'user_id' => array(
				array('not_empty'),
				array(array($this,'exists'), array('users', ':field', ':value', ':validation')),
			),
			'review_rating' => array(
				array('not_empty'),
				array('digit'),
			),
			'reply_id' => array(
				array(array($this,'exists'), array('replies', ':field', ':value', ':validation')),
			),
			'username' => array(
				array('not_empty'),
				array(array($this,'exists'), array('users', ':field', ':value', ':validation')),
			),
		);
	}

	public function save(Validation $validation = NULL)
	{
		try{
			if(!$this->review_date_modified) {
				$this->listing->listing_review_value = round(($this->listing->listing_review_value * $this->listing->listing_review_num + $this->review_rating) / ($this->listing->listing_review_num + 1),1);
				$this->listing->listing_review_num++;
				$this->listing->save();
				$this->listing->clear();
			}
			$this->username = $this->user->username;
			$this->user->clear();
			return parent::save($validation);

		} catch( Exception $e ) {
			throw $e;
		}
	}

	public function unique_listing($field, $value, $data, Validation $validation = NULL)
	{
		if($value=='')
			return;
		$retval = (DB::select()
			->from($this->_table_name)
			->where($field, '=', $value)
			->and_where('user_id', '=', $data['user_id'])
			->execute()->count()==0);

		if($validation === NULL)
			return $retval;
		elseif(!$retval)
			$validation->error($field, __function__, $data);
	}

	public function delete()
	{
		if ( ! $this->_loaded)
			throw new Kohana_Exception('Cannot delete :model model because it is not loaded.', array(':model' => $this->_object_name));

		if($this->listing->listing_review_num != 1)
			$this->listing->listing_review_value = round(($this->listing->listing_review_num * $this->listing->listing_review_value - $this->_original_values['review_rating']) / ($this->listing->listing_review_num - 1),1);
		else
			$this->listing->listing_review_value = 0;

		$this->listing->listing_review_num--;

		$this->listing->save();
		$this->listing->clear();

		return parent::delete();
	}
}