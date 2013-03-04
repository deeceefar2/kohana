<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * File Type Model
 * @author davidf
 *
 */
class Model_File_Type extends Model_Base {

	protected $_table_name = 'file_types';

	protected $_primary_key = 'file_type_id';

	protected $_has_many = array(
//		'listings'	=> array(),
	);
}