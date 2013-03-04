<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Listing Field Model
 * @author davidf
 *
 */
class Model_Listing_Field extends Model_Base {

	protected $_table_name = 'listing_fields';

	protected $_primary_key = 'listing_field_id';

	// Relationships
	protected $_belongs_to = array(
		'field_type'	=> array(),
		'field'			=> array(),
		//'parent'   	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_one = array(
		//'parent'   	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_many = array(
		//'children'	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);

	protected $_load_with = array(
		'field',
		'field:field_type',
	);
}