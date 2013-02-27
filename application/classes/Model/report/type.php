<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Report Type Model
 * @author davidf
 *
 */
class Model_Report_Type extends Model_Base {

	protected $_table_name = 'report_types';

	protected $_primary_key = 'report_type_id';

	// Relationships
	protected $_belongs_to = array(
		//'parent'   	=> array('model'=>'category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_many = array(
		'reports'			=> array(),
		'report_categories'	=> array(),
		//'children'	=> array('model'=>'category', 'foreign_key' => 'parent_id'),
	);
}