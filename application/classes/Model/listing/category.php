<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Listing Category Model
 * @author davidf
 *
 */
class Model_Listing_Category extends Model_Base {

	protected $_table_name = 'listing_categories';

	protected $_primary_key = 'listing_category_id';

	// Relationships
	protected $_belongs_to = array(
		'listing'		=> array(),
		'category'		=> array(),
	);

	protected $_has_many = array(
		//'children'	=> array('model'=>'category', 'foreign_key' => 'parent_id'),
	);
}