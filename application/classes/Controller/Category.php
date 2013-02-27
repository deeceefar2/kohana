<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Category extends Controller_Base {

	public function action_index()
	{
		// Set the name of the template to use
		$this->template->set_filename('category');

		if($this->request->method() == Request::POST) {
			try{
				// Initialize the validation library and setup some rules
				$validation = Validation::factory($this->request->post());

				$validation
					->rule('csrf',					'not_empty')
					->rule('csrf',					'Security::check')
				;

				$category = ORM::factory('category');

				$category->values($this->request->post());

				$parent = ORM::factory('category')->where('category_id','=',$category->parent_id)->order_by('category_name','DESC')->find();

				$category->category_depth = $parent->category_depth + 1;

				$category->save($validation);

			} catch (ORM_Validation_Exception $e) {
				$this->template->errors = $e->errors('models');
			}
		}

		$this->template->categories = ORM::factory('category')->find_all();
	}

}
