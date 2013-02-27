<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Sitemap extends Controller {

	public $auth_required = array('login');

	public function action_index()
	{

		$this->response->headers('Content-Type','text/xml');
		$this->response->headers('Encoding',Kohana::$charset);

		// Sitemap instance.
		$sitemap = new Sitemap;

		// New basic sitemap.
		$url = new Sitemap_URL;

		// Set arguments.
		$url->set_loc('http://google.com')
			->set_last_mod(1276800492)
			->set_change_frequency('daily')
			->set_priority(1);

		// Add it to sitemap.
		$sitemap->add($url);

		// Render the output.
		$output = $sitemap->render();

		// __toString is also supported.
		echo $sitemap;
	}
}
