<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Search Model
 * @author davidf
 *
 */
class Model_Search extends Model_Base {

	protected $_default_within = 50;

	protected $_table_name = 'searches';

	protected $_primary_key = 'search_id';

	protected $_sorting = array(
		'search_date_modified'=>'DESC',
	);

	protected $_serialize_columns = array(
		'search_parameters',
	);

	// Relationships
	protected $_belongs_to = array(
		//'parent'   	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);

	protected $_has_many = array(
		//'children'	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);

	public function filters()
	{
		return array(
			'search_name' => array(
				array('trim'),
			),
		);
	}

	public function parse_query() {
		$params = $this->search_parameters;
		$distance = false;
		if($params !== NULL) {
			if(array_key_exists('category_id',$params)) {
				$query = ORM::factory('category',$params['category_id'])->listings;
			} else {
				$query = ORM::factory('listing');
			}

			if(array_key_exists('type_id',$params)) {
				$query->where('type_id','=',$params['type_id']);
			}

			if(array_key_exists('location',$params)) {
				$distance = true;
				/*

				$within = array_key_exists('within',$params['location']) ? $params['location']['within'] : $this->_default_within;

				if( array_key_exists('city',$params['location']) && array_key_exists('state',$params['location']) ) {
					$query->;
					//$query = DB::select(array(DB::expr('degrees(acos(sin(radians('.$lat.')) * sin(radians(`latitude`)) + cos(radians('.$lat.')) * cos(radians(`latitude`)) * cos(radians(abs('.$lng.' - `longitude`))))) * 69.172'), 'distance'))->from('locations');
				} elseif( array_key_exists('zip',$params['location']) ) {
					$query->;
				} elseif( array_key_exists('latitude',$params['location']) && array_key_exists('longitude',$params['location']) ) {
					$query->;
				} else {
					$query->;
				}*/
			}

			if(array_key_exists('sort',$params)) {
				switch($params['sort']) {
					case 1:
						$distance = true;
						//$query->order_by('distance','ASC');
						break;
					case 2:
						$query->order_by('listing_review_value','DESC');
						break;
					case 3:
						$query->order_by('listing_review_value','ASC');
						break;
					case 4:
						$query->order_by('listing_name','ASC');
						break;
					case 5:
						$query->order_by('listing_name','DESC');
						break;
					default:
						$query->order_by('listing_review_value','DESC');
						break;
				}
			}
		} else {
			$query = ORM::factory('listing');
		}

		if($this->search_query) {
			$query->where_open();
			$query->where('listing.listing_name','LIKE',"%$this->search_query%");
			$query->or_where('listing.listing_information','LIKE',"%$this->search_query%");
			$query->or_where('listing.listing_address_street_1','LIKE',"%$this->search_query%");
			$query->or_where('listing.listing_address_street_2','LIKE',"%$this->search_query%");
			$query->or_where('listing.listing_address_city','LIKE',"%$this->search_query%");
			$query->or_where('listing.listing_address_state','LIKE',"%$this->search_query%");
			$query->where_close();
		}

		return $query;
	}

	public function listings() {
		return $this->parse_query()->find_all();
	}

	public function categories() {
		$return = array_map( create_function( '$obj', 'return $obj->default_category;'), $this->parse_query()->find_all()->as_array());
		return $return;
	}

	public function as_array($with_listings = false) {
		if($with_listings) {

			$object = parent::as_array();

			$object['listings'] = array_map( create_function( '$obj', 'return is_a($obj,"ORM") ? $obj->as_array() : $obj;'),$this->listings()->as_array());

			return $object;
		} else {
			return parent::as_array();
		}
	}
}