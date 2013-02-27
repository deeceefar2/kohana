<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Error extends Controller_Base {

	public function before()
	{
		if (Request::$initial !== Request::$current)
		{
			if(Request::$initial->response() !== NULL)
				foreach(Request::$initial->response()->headers() as $key=>$value)
					$this->response->headers($key,$value);
		}
	}

	public function after()
	{

	}

	public function action_index() {

		$section = 'section_'.$this->request->param('section');

		if(method_exists($this,$section))
			$this->{$section}();
		else
			$this->section_default();

	}

	public function section_default() {
		parent::before();

		$e = $this->request->post('exception');
		$this->template->set_filename('error');

		$this->template->set(array(
				'message'	=> $e->getMessage(),
				'code'		=> $e->getCode(),
				'page'		=> Request::$initial->uri(),
			)
		);

		$this->response->status((int) $e->getCode());

		parent::after();
	}

	public function section_api() {

		$e = $this->request->post('exception');
		$view = View::factory('error',NULL,'json');

		$view->set_global_tag('metadata');
		$view->set_data_tag('payload');
		$this->response->headers('Content-Type', 'application/json');

		switch(get_class($e)) {

			case 'HTTP_Exception':

				Response::current()->status($e->getCode());

				$view->set_global(array(
					'error' => TRUE,
					'type' => 'http',
				));
				$view->set(array(
					'message'	=> $e->getMessage(),
					'code'		=> $e->getCode(),
					'page'		=> Request::$initial->uri(),
				));

				break;

			case 'ORM_Validation_Exception':

				$this->response->status(500);

				$view->set_global(array(
					'error'	=> TRUE,
					'type'	=> 'validation',
				));
				$view->set(array(
					'errors'	=> $e->errors(),
					'code'		=> $e->getCode(),
					'page'		=> Request::$initial->uri(),
					'messages'	=> $e->errors(),
				));

				break;

			default:

				$this->response->status(500);

				$view->set_global(array(
					'error'	=> TRUE,
					'type'	=> 'exception',
				));
				$view->set(array(
					'message'	=> $e->getMessage(),
					'code'		=> $e->getCode(),
					'page'		=> Request::$initial->uri(),
				));

				break;
		}

		$this->response->body($view->render());
	}

}