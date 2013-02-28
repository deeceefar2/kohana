<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Profile_Profile extends Controller_Base {

	public $auth_required = array('login','active');

	public function action_index()
	{
		// Set the name of the template to use
		$this->template->set_filename('profile_profile');

		if($this->request->method() == Request::POST) {

			try{
				// Initialize the validation library and setup some rules
				$validation = Validation::factory($this->request->post());

				$validation
					->rule('csrf',							'not_empty')
					->rule('csrf',							'Security::check')
				;

				$object = ORM::factory($this->request->post('_object'));
				if($this->request->post('_object_id')) {
					 $object = $object->where($object->primary_key(),'=',$this->request->post('_object_id'))->and_where('user_id','=',$this->user->user_id)->find();
				}
				$object->values($this->request->post());
				$object->user_id = $this->user->user_id;

				$object->save($validation);

			} catch (ORM_Validation_Exception $e) {
				$this->template->errors = $e->errors();
				$this->template->{$this->request->post('_object')} = $object;
			}
		} elseif($this->request->query('_object')) {
			$object = ORM::factory($this->request->query('_object'));
			if($this->request->query('_object_id')) {
				$this->template->{$this->request->query('_object')} = $object->where($object->primary_key(),'=',$this->request->query('_object_id'))->and_where('user_id','=',$this->user->user_id)->find()->as_array();
			}
			if($this->request->query('_delete') == 1) {
				$object->delete();
			}
		}


		$this->template->contacts = $this->user->contacts->find_all();

		$this->template->allergies = $this->user->allergies->find_all();

		$this->template->procedures = $this->user->procedures->find_all();

		$this->template->medications = $this->user->medications->find_all();
	}

}
