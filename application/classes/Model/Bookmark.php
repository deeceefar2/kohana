<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Bookmark Model
 * @author davidf
 *
 */
class Model_Bookmark extends Model_Base {

	protected $_table_name = 'bookmarks';

	protected $_primary_key = 'bookmark_id';

	protected $_belongs_to = array(
		'user'			=> array(),
		'listing'   	=> array(),
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
			'bookmark_id'				=> 'bookmark id',
			'user_id'					=> 'user id',
			'listing_id'				=> 'listing id',
			'bookmark_date_modified'	=> 'bookmark date modified',
		);
	}

	public function rules()
	{
		return array(
			'user_id' => array(
				array('not_empty'),
				array(array($this,'exists'), array('users', ':field', ':value', ':validation')),
			),
			'listing_id' => array(
				array('not_empty'),
				array(array($this,'exists'), array('listings', ':field', ':value', ':validation')),
				array(array($this,'unique_listing'), array(':field', ':value', ':data', ':validation')),
			),
		);
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
}