<?php defined('SYSPATH') or die('No direct script access.');

class ORM extends Kohana_ORM {

	/**
     * Join a has-many-through related object/model
     *
     * @param ORM $model Model of which the table has to be joined
     */
    public function with_many(ORM $joined_model)
    {
        // Check both models for the correct many-to-many relationship
        if (isset($this->_has_many[$joined_model->_table_name])
            && isset($this->_has_many[$joined_model->_table_name]['through'])
            && isset($joined_model->_has_many[$this->_table_name])
            && isset($joined_model->_has_many[$this->_table_name]['through'])
            && $this->_has_many[$joined_model->_table_name]['through'] == $joined_model->_has_many[$this->_table_name]['through'])
        {
            // Get the objects relationship arrays
            $this_relationship = $this->_has_many[$joined_model->_table_name];
            $join_relationship = $joined_model->_has_many[$this->_table_name];

            $through_table = $this_relationship['through'];

            // First, join the "through" table
            $this
                ->join($through_table)
                ->on($this->_table_name.'.'.$this->_primary_key, '=', $through_table.'.'.$this_relationship['foreign_key']);

            // Then join the related table using a pivot ("through") table
            $this
                ->join($joined_model->_table_name)
                ->on($joined_model->_table_name.'.'.$joined_model->_primary_key, '=', $through_table.'.'.$join_relationship['foreign_key']);

            // Chainable
            return $this;
        }
		else
        {
            throw new Kohana_Exception('The :joined_model that you\'re trying to join is not correctly related by has-many-through relationship wih the :current_model',
                array(':joined_model' => get_class($joined_model), ':current_model' => get_class($this)));
        }
    }

	protected function _unserialize_value($value) {
		return json_decode($value, TRUE);
	}
}
