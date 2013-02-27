<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Test extends Controller_Base {

	public function action_index()
	{
		$query = Places::factory();
		$query->SetLocation("43.612631,-116.211076");
		$query->SetRadius(50000);
		$query->SetTypes("bank");
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
						}


						$listing->save();
						if(sizeof($place['types'])>0) {
							foreach($place['types'] as $type) {
								$category = ORM::factory('category')->where('google_type','=',$type)->find();
								if($category->loaded()) {

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
	}
}