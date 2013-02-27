<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Listings extends Controller_Base {

	public $auth_required = array('login','active');

	public function action_index()
	{
		// Set the name of the template to use
		$this->template->set_filename('listings');

		$this->template->categories = ORM::factory('category')->find_all();
		$listings = ORM::factory('listing');

		$this->pagination->total_items =  $listings->count_all();
		$listings->offset($this->pagination->offset)->limit($this->pagination->items_per_page);

		$this->template->listings = $listings->find_all();
	}

	public function action_category()
	{
		// Set the name of the template to use
		$this->template->set_filename('listings');

		$crumbs = $this->request->param('crumbs');
		$crumbs = explode("/",$crumbs);

		$categories = array();

		foreach($crumbs as $category_slug) {
			$last_category = ORM::factory('category')->where('category_slug','=',$category_slug)->find();
			array_push($categories, $last_category);
		}

		$this->template->crumbs = $categories;
		$this->template->categories = ORM::factory('category')->find_all()->as_array();

		$listings = $last_category->listings;



		$count =  $listings->count_all();

		if($count == 0) {
			$listings = ORM::factory('listing');
			$count =  $listings->count_all();
			$listings = ORM::factory('listing');
		} else {
			$listings = $last_category->listings;
		}
		$this->pagination->total_items =  $count;

		$listings->offset($this->pagination->offset)->limit($this->pagination->items_per_page);

		$this->template->listings = $listings->find_all();
	}

	public function action_search()
	{
		// Set the name of the template to use
		$this->template->set_filename('listings');
		$query = Places::factory();
		try{
			$location = Session::instance()->get('location');
			if(!is_array($location))
				$location = Geoip3::instance()->record(Request::$client_ip);
			else {
				$location = (object)$location;
				$query->SetSensor('true');
			}
		} catch (Exception $e) {
			$location = (object)array('latitude'=>'35.4675','longitude'=>'-97.5161111');
		}
		$query->SetLocation($location->latitude.','.$location->longitude);
		$query->SetKeyword(urlencode($this->request->query('search_query')));
		$query->SetRadius(50000);
		$response = $query->Search();
		$places = $response['results'];
		if(sizeof($places)>0) {
			foreach($places as $place) {
				try{

					$listing = ORM::factory('listing');

					$listing->where('google_id','=',$place['id'])->find();

					if($listing->loaded()) {
					} else {

						$listing->listing_name = $place['name'];
						$listing->listing_address_lat = $place['geometry']['location']['lat'];
						$listing->listing_address_long = $place['geometry']['location']['lng'];

						$listing->user_id = '000000000-0000-0000-0000-00000000000';
						$listing->listing_state = 1;
						$listing->type_id = '1';
						$listing->listing_default_category_id = '2';
						$listing->google_id = $place['id'];

						$query->setReference($place['reference']);
						$place_response = $query->Details();
						$details = $place_response['result'];

						if(array_key_exists('international_phone_number', $details))
							$listing->listing_phone = $details['international_phone_number'];

						if(array_key_exists('formatted_phone_number', $details))
							$listing->listing_phone = $details['formatted_phone_number'];

						if(array_key_exists('website', $details))
							$listing->listing_website = $details['website'];

						if(array_key_exists('state', $details['address_fixed']))
							$listing->listing_address_state = $details['address_fixed']['state'];

						if(array_key_exists('city', $details['address_fixed']))
							$listing->listing_address_city = $details['address_fixed']['city'];

						if(array_key_exists('zip', $details['address_fixed']))
							$listing->listing_address_zip = $details['address_fixed']['zip'];

						if(array_key_exists('street_name', $details['address_fixed']) && array_key_exists('street_number', $details['address_fixed']))
							$listing->listing_address_street_1 = $details['address_fixed']['street_number'] . ' ' . $details['address_fixed']['street_name'];
						else {
							$pattern = '/, ' . $listing->listing_address_city . '.*/';
							$listing->listing_address_street_1 = preg_replace($pattern, '', $details['formatted_address']);
							//echo $details['formatted_address'];
						}

						if(strpos($listing->listing_address_street_1,',') !== false) {
							list($listing->listing_address_street_1,$listing->listing_address_street_2) = explode(',',$listing->listing_address_street_1,2);
						} elseif(strpos($listing->listing_address_street_1,'#') !== false) {
							list($listing->listing_address_street_1,$listing->listing_address_street_2) = explode(',',$listing->listing_address_street_1,2);
							$listing->listing_address_street_2 = '#'.$listing->listing_address_street_2;
						}


						$listing->save();
						if(sizeof($place['types'])>0) {
							foreach($place['types'] as $type) {
								$categories = ORM::factory('category')->where('google_type','LIKE','%'.$type.'%')->find_all()->as_array();
								foreach($categories as $category) {
									try{
										ORM::factory('listing_category')->values(
											array(
												'listing_id' => $listing->listing_id,
												'category_id' => $category->category_id,
											)
										)->save();
										if($listing->listing_default_category_id == '2') {
											$listing->listing_default_category_id = $category->category_id;
											$listing->save();
										}
									} catch (Exception $e) {
									}
								}
							}
						}
					}

				} catch (ORM_Validation_Exception $e) {

					Kohana::$log->add(Log::ERROR, 'Search Listing Save Validation Error :errors', array(
						':errors' => print_r($e->errors(),true),
					));

				} catch (Exception $e) {

					Kohana::$log->add(Log::ERROR, 'Searc Listing Error :errors', array(
						':errors' => print_r($e,true),
					));

				}
			}
		}

		$search = ORM::factory('search');
		if($this->request->query('search_query'))
			$search->search_query = $this->request->query('search_query');
		elseif($this->request->method() == Request::POST)
			$search->values($this->request->post());

		if($this->user) {
			$search->user_id = $this->user->user_id;
		} else {
			$search->user_id = '000000000-0000-0000-0000-00000000000';
		}

		$search->save();

		$this->pagination->total_items =  $search->parse_query()->count_all();

		$listings = $search->parse_query();
		$listings->offset($this->pagination->offset)->limit($this->pagination->items_per_page);

		$this->template->listings = $listings->find_all();
/*
->with('default_category:parent:parent:parent')
		$categories = array();

		foreach($this->template->listings as $listing) {
			$category = $listing->default_category;
			while($category->loaded()) {
				$categories[$category->category_id] = $category;
				$category = $category->parent;
			}
		}

		$this->template->categories =  array_values($categories);
*/
		$this->template->categories = ORM::factory('category')->find_all()->as_array();
	}

	public function action_advanced_search()
	{
		// Set the name of the template to use
		$this->template->set_filename('search_advanced');

		// On form submission
		if( $_GET ){
			// Initialize the validation library and setup some rules
			$validation = Validation::factory(
			array
				(
					'exact_phrase'	=> $_GET['wordsExactPhrase'],
					'all'			=> $_GET['wordsAll'],
					'exclude'		=> $_GET['wordsExclude'],
					'any'			=> $_GET['wordsAny'],
					'city'			=> $_GET['locationCity'],
					'zipcode'		=> $_GET['locationZipcode'],
					'within'		=> $_GET['locationWithin'],
					'type'			=> $_GET['selectType'],
				)
			);

			$validation
// 				->rule('search',	'Controller_Search::notDefaultSearch')
// 				->rule('search',	'not_empty')
			;

			if( $validation->check() ){

				// Create a search api object
				$request = Request::factory('/api/searches');

				// Set the method of the search
				$request->method('POST');

				// Tell the search to accept xml
				$request->headers('Accept', 'text/xml');

				// Set the request's body to be the json representation of the GET variables
				$request->body(json_encode($_GET));

				// Execute the request and save the response
				$response = $request->execute();

				// Create a SimpleXMLElement object from the response's body
				$xml = new SimpleXMLElement($response->body());

				// Save the payload tag as a variable from the xml array
				list($payload) = $xml->xpath('/root/payload');

				// Set children to an empty string
				$children = '';

				foreach($payload->children() as $key => $value)
				$children .= $value->asXML();	// Add each child of payload to the string

				$this->template->listings = $children;
			}
		}
	}

	public function action_new()
	{
		// Set the name of the template to use
		$this->template->set_filename('listing_new');

		$type = ORM::factory('type')->where('type_name','=','test')->find();

		if($this->request->method() == Request::POST) {
			try{
				// Initialize the validation library and setup some rules
				$validation = Validation::factory($this->request->post());

				$validation
					->rule('csrf',					'not_empty')
					->rule('csrf',					'Security::check')
					->rule('listing_phone',			'not_empty')
				;

				throw new ORM_Validation_Exception('Just a test.', $validation);

				$listing = ORM::factory('listing');

				$listing->values($this->request->post());

				$listing->user_id = $this->user->user_id;

				$listing->listing_state = 2;

				$listing->save($validation);

				if($this->request->post('categories')) {
					foreach($this->request->post('categories') as $key=>$value) {
						ORM::factory('listing_category')->values(
							array(
								'listing_id' => $listing->listing_id,
								'category_id' => $value,
							)
						)->save();
					}
				}

				foreach($type->fields->find_all()->as_array() as $field) {
					if($this->request->post($field->field_type->field_type_slug . '_' . $field->field_id)) {
						ORM::factory('listing_field')->values(
							array(
								'user_id'				=> $this->user->user_id,
								'listing_id'			=> $listing->listing_id,
								'field_id'				=> $field->field_id,
								'listing_field_value'	=> $this->request->post($field->field_type->field_type_slug . '_' . $field->field_id),
							)
						)->save();
					}
				}

				$this->request->redirect("/listing/$listing->listing_slug/$listing->listing_id");
			} catch (ORM_Validation_Exception $e) {
				$this->template->errors = $e->errors('models');
			}
		}

		$this->template->categories = ORM::factory('category')->order_by('category_name','ASC')->find_all();

		$this->template->types = ORM::factory('type')->find_all();

		$this->template->type = $type->as_array(true);
	}

	public function action_address()
	{
		// Set the name of the template to use
		$this->template->set_filename('create_listing_address_search');

		// Create new Recaptcha object from global keys
		$Recaptcha = new Recaptcha();

		$this->template->recaptcha = array(
			'server'=>RECAPTCHA_API_SERVER,
			'key'=>$Recaptcha->public_key(),
		);
	}
}