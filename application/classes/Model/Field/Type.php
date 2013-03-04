<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Field Type Model
 * @author davidf
 *
 */
class Model_Field_Type extends Model_Base {

	protected $_table_name = 'field_types';

	protected $_primary_key = 'field_type_id';

	// Relationships
	protected $_belongs_to = array(
		//'parent'   	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_many = array(
		//'children'	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);
}