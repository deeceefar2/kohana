<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Report Type Model
 * @author davidf
 *
 */
class Model_Report_Category extends Model_Base {

	protected $_table_name = 'report_categories';

	protected $_primary_key = 'report_category_id';

	// Relationships
	protected $_belongs_to = array(
		'report_type'	=> array(),
		//'parent'   	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_many = array(
		'reports'		=> array(),
		//'children'	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);
}