<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Listing File Model
 * @author davidf
 *
 */
class Model_Listing_File extends Model_Base {

	protected $_table_name = 'listing_files';

	protected $_primary_key = 'listing_file_id';

	// Relationships
	protected $_belongs_to = array(
		//'parent'   	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_many = array(
		//'children'	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);
}