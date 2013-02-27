<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Base Model
 * @author davidf
 *
 */
class Model_Base extends ORM {


	/**
	 * Saves the current object.
	 *
	 * @return  ORM
	 */
	public function save(Validation $validation = NULL)
	{
		try{
			if($this->pk() === NULL) {
				$this->{$this->primary_key()} = $this->newId();
				$this->_primary_key_value = $this->{$this->primary_key()};
			}

			$this->{$this->object_name().'_date_modified'} = DB::expr('UNIX_TIMESTAMP()');

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
			die('uuid_create');
		return strtoupper(trim(uuid_create(UUID_TYPE_TIME)));
	}

	public function exists($table, $field, $value, Validation $validation = NULL)
	{
		if($value=='')
			return;
		$retval = (DB::select()
			->from($table)
			->where($field, '=', $value)
			->execute()->count()>0);

		if($validation === NULL)
			return $retval;
		elseif(!$retval)
			$validation->error($field, __function__, array($value));
	}
}