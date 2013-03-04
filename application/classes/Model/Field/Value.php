<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Field Type Model
 * @author davidf
 *
 */
class Model_Field_Value extends Model_Base {

	protected $_table_name = 'field_values';

	protected $_primary_key = 'field_value_id';

	// Relationships
	protected $_belongs_to = array(
		//'parent'   	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_many = array(
		//'children'	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);
}