<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * User Model
 * @author davidf
 *
 */
class Model_User extends Model_Auth_User {

	protected $_table_name = 'users';

	protected $_primary_key = 'user_id';

	// Relationships
	protected $_belongs_to = array(
		//'parent'   	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_many = array(
		'contacts'		=> array(),
		'allergies'		=> array(),
		'procedures'	=> array(),
		'medications'	=> array(),
		'bookmarks'		=> array(),
		'searches'		=> array(),
		'listings'		=> array(),
		'reviews'		=> array(),
		'user_tokens'	=> array('model' => 'user_token'),
		'roles'			=> array('model' => 'role', 'through' => 'roles_users'),
	);

	/**
	 * Rules for the user model. Because the password is _always_ a hash
	 * when it's set,you need to run an additional not_empty rule in your controller
	 * to make sure you didn't hash an empty string. The password rules
	 * should be enforced outside the model or with a model helper method.
	 *
	 * @return array Rules
	 */
	public function rules()
	{
		return array(
			'username' => array(
				array('not_empty'),
                array('min_length', array(':value', 4)),
				array('max_length', array(':value', 32)),
				array(array($this, 'unique'), array('username', ':value')),
			),
			'password' => array(
				array('not_empty'),
			),
			'email' => array(
				array('not_empty'),
				array('email'),
				array(array($this, 'unique'), array('email', ':value')),
			),
		);
	}

	/**
	 * Filters to run when data is set in this model. The password filter
	 * automatically hashes the password when it's set in the model.
	 *
	 * @return array Filters
	 */
	public function filters()
	{
		return array(
			'password' => array(
				array(array(Auth::instance(), 'hash'))
			),
		);
	}

	/**
	 * Labels for fields in this model
	 *
	 * @return array Labels
	 */
	public function labels()
	{
		return array(
			'username'         => 'username',
			'email'            => 'email address',
			'password'         => 'password',
		);
	}

	/**
	 * Labels for fields in this model
	 *
	 * @return array Labels
	 */
	public function hidden()
	{
		return array(
			'password',
		);
	}

	/**
	* Saves the current object.
	*
	* @return  ORM
	*/
	public function save(Validation $validation = NULL)
	{
		try{
			$this->user_ip = Request::$client_ip;

			if($this->pk() === NULL) {
				$this->user_date_register = time();
				$this->{$this->primary_key()} = $this->newId();
				$this->_primary_key_value = $this->{$this->primary_key()};
			}
			return parent::save($validation);
		} catch( Database_Exception $e ) {
			if($e->getCode() == '1062') { // if is primary key not unqiue
				$this->{$this->primary_key()} = $this->newId();
				$this->_primary_key_value = $this->{$this->primary_key()};
				return parent::save($validation);
			} else {
				throw $e;
			}
		}
	}

	/**
	 * Generates new primary key UUID using mac addr and time
	 *
	 * @return  id
	 */
	public function newId()
	{
		if (!function_exists('uuid_create'))
			die('uuid_create function does not exist');
		return strtoupper(trim(uuid_create(UUID_TYPE_TIME)));
	}

	public function as_array()
	{
		$return = parent::as_array();
		foreach($this->hidden() as $hidden)
			unset($return[$hidden]);
		return $return;
	}
}