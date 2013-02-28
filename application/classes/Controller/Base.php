<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Base extends Controller_XSL {

	public $pagination = null;
	public $template = null;

	public $auth_required = array();
	public $secure_actions = array();
	public $ssl_actions = array();

	public $site_title = 'MedVoyager';
	public $controller_title = '';
	public $keywords = '';
	public $description = '';

	public function before() {

		parent::before();

		$this->response->headers('P3P', 'CP="CAO PSA OUR"');

       	$this->user = Auth::instance()->get_user();
		$action_name = $this->request->action();

		//roles required
		$required_roles = (array_key_exists($action_name, $this->secure_actions))?array_merge($this->secure_actions[$action_name],$this->auth_required):$this->auth_required;

		//if ssl required redirect to https; if not redirect http
		if (in_array($action_name, $this->ssl_actions) && !$this->request->secure())
		{
			$this->request->redirect(URL::site($this->request->uri(), 'https'), 301);
		} elseif (!in_array($action_name, $this->ssl_actions) && $this->request->secure()) {
			$this->request->redirect(URL::site($this->request->uri(), 'http'), 301);
		}

		if (sizeof($required_roles)>0)
		{
			if(!$this->user) {
				Session::instance()->set('post_login_redirect_url', $this->request->url());
				$this->redirect('/login',303);
			} elseif(!Auth::instance()->logged_in($required_roles)) {
				$this->redirect('/forbidden',303);
			}
		}

		if($this->auto_render) {
			$this->template->set_global('styles', array(
				'style' => array(
						array(
							'source'	=> '/assets/css/med_structure.css',
							'cdn'		=> 'static',
						),
						array(
							'source'	=> '/assets/css/med_theme.css',
							'cdn'		=> 'static',
						),
						array(
							'source'	=> '/assets/css/colorbox.css',
							'cdn'		=> 'static',
						),
						array(
							'source'	=> '/assets/css/jquery.ui.stars.css',
							'cdn'		=> 'static',
						),
					)
				)
			);
			$this->template->set_global('scripts', array(
				'script' => array(
						array(
							'source'	=> '/assets/js/jquery-1.5.1.min.js',
							'cdn'		=> 'static',
						),
						array(
							'source'	=> '/assets/js/jquery-ui-1.8.14.custom.min.js',
							'cdn'		=> 'static',
						),
						array(
							'source'	=> '/assets/js/jquery.colorbox-min.js',
							'cdn'		=> 'static',
						),
						array(
							'source'	=> '/assets/js/jquery.ui.stars.min.js',
							'cdn'		=> 'static',
						),
						array(
							'source'	=> '/assets/js/jquery.appear.min.js',
							'cdn'		=> 'static',
						),
						array(
							'source'	=> '/assets/js/main.js',
							'cdn'		=> 'static',
						),
					)
				)
			);
			//$this->pagination = Pagination::factory();
		}
	}

	public function after()
	{
		if($this->auto_render) {
			$this->template->set_global(array(
					'redirect_time' => 3,
					'protocol'		=> $this->request->protocol(),
					'referrer'		=> $this->request->referrer(),
					'domain'		=> $_SERVER['HTTP_HOST'],
					'server'		=> $_SERVER['SERVER_NAME'],
					'base'			=> URL::base(),
					'uri'			=> $this->request->uri(),
					'url'			=> $this->request->url(),
					'directory'		=> $this->request->directory(),
					'controller'	=> $this->request->controller(),
					'action'		=> $this->request->action(),
					'query'			=> $this->request->query(),
					'post'			=> $this->request->post(),
					'csrf'			=> Security::token(true),
					'ajax'			=> $this->request->is_ajax(),
					'server_time'	=> time(),
					'title'			=> $this->getTitle(),
					'user'			=> $this->user,
					'pagination'	=> $this->pagination,
					'environment'	=> Kohana::$environment,
					'auth_forced'	=> Session::instance()->get('auth_forced'),
					'location'		=> Session::instance()->get('location'),
				)
			);
			if(Kohana::$environment != Kohana::PRODUCTION) {
				$this->template->set_global(array(
						'benchmark'		=> Profiler::application(),
						'profile'		=> View::factory('profiler/stats'),
					)
				);
			}
		}


		parent::after();
	}

	public function getTitle() {
		$title = $this->site_title;
		if(isset($this->title))
			return $this->title;
		if(isset($this->controller_title) && $this->controller_title != '')
			$title = $this->controller_title . ' | ' . $title;
		if(isset($this->page_title) && $this->page_title != '')
			$title = $this->page_title . ' | ' . $title;
		return  $title;
	}

}
