<?php defined('SYSPATH') or die('No direct script access.');

// -- Environment setup --------------------------------------------------------

// Load the core Kohana class
require SYSPATH.'classes/Kohana/Core'.EXT;

if (is_file(APPPATH.'classes/Kohana'.EXT))
{
	// Application extends the core
	require APPPATH.'classes/Kohana'.EXT;
}
else
{
	// Load empty core extension
	require SYSPATH.'classes/Kohana'.EXT;
}

/**
 * Set the default time zone.
 *
 * @link http://kohanaframework.org/guide/using.configuration
 * @link http://www.php.net/manual/timezones
 */
date_default_timezone_set('America/Chicago');

/**
 * Set the default locale.
 *
 * @link http://kohanaframework.org/guide/using.configuration
 * @link http://www.php.net/manual/function.setlocale
 */
setlocale(LC_ALL, 'en_US.utf-8');

/**
 * Enable the Kohana auto-loader.
 *
 * @link http://kohanaframework.org/guide/using.autoloading
 * @link http://www.php.net/manual/function.spl-autoload-register
 */
spl_autoload_register(array('Kohana', 'auto_load'));

/**
 * Optionally, you can enable a compatibility auto-loader for use with
 * older modules that have not been updated for PSR-0.
 *
 * It is recommended to not enable this unless absolutely necessary.
 */
//spl_autoload_register(array('Kohana', 'auto_load_lowercase'));

/**
 * Enable the Kohana auto-loader for unserialization.
 *
 * @link http://www.php.net/manual/function.spl-autoload-call
 * @link http://www.php.net/manual/var.configuration#unserialize-callback-func
 */
ini_set('unserialize_callback_func', 'spl_autoload_call');

// -- Configuration and initialization -----------------------------------------

/**
 * Set the default language
 */
I18n::lang('en-us');



/**
 * Set error handler
 */
//set_exception_handler(array('Kohana_Exception', 'handler'));

/**
 * Set Kohana::$environment if a 'KOHANA_ENV' environment variable has been supplied.
 *
 * Note: If you supply an invalid environment name, a PHP warning will be thrown
 * saying "Couldn't find constant Kohana::<INVALID_ENV_NAME>"
 */
if (isset($_SERVER['KOHANA_ENV']))
{
	Kohana::$environment = constant('Kohana::'.strtoupper($_SERVER['KOHANA_ENV']));
}

/**
 * Initialize Kohana, setting the default options.
 *
 * The following options are available:
 *
 * - string   base_url    path, and optionally domain, of your application   NULL
 * - string   index_file  name of your index file, usually "index.php"       index.php
 * - string   charset     internal character set used for input and output   utf-8
 * - string   cache_dir   set the internal cache directory                   APPPATH/cache
 * - integer  cache_life  lifetime, in seconds, of items cached              60
 * - boolean  errors      enable or disable error handling                   TRUE
 * - boolean  profile     enable or disable internal profiling               TRUE
 * - boolean  caching     enable or disable internal caching                 FALSE
 * - boolean  expose      set the X-Powered-By header                        FALSE
 */
Kohana::init(array(
	'index_file'	=> '/',
	'caching'		=> TRUE,
));

/**
 * Attach the file write to logging. Multiple writers are supported.
 */
Kohana::$log->attach(new Log_File(APPPATH.'logs'));

/**
 * Attach a file reader to config. Multiple readers are supported.
 */
Kohana::$config->attach(new Config_File);

/**
 * Enable modules. Modules are referenced by a relative or absolute path.
 */


$modules = array(
	'database'					=> MODPATH . 'database',				// Database access
	'cache'						=> MODPATH . 'cache',					// Caching with multiple backends
	'auth'						=> MODPATH . 'auth',					// Basic authentication
	'orm'						=> MODPATH . 'orm',						// Object Relationship Mapping
	'logdb'						=> MODPATH . 'logdb',					// Amazon Simple Email Service
//	'oauth2'					=> MODPATH . 'oauth2',					// OAuth2
//	'api'						=> MODPATH . 'api',						// API
	'image'						=> MODPATH . 'image',					// Image manipulation
//	'pagination'				=> MODPATH . 'pagination',				// Pagination
	'xsl'						=> MODPATH . 'xsl',						// Template xsl
	'minion'					=> MODPATH . 'minion',					// Minion CLI Framework
	'uid'						=> MODPATH . 'uuid',					// UUID Generation
	'colorfulcms'				=> MODPATH . 'cms',						// Colorful CMS
	'recaptcha'					=> MODPATH . 'recaptcha',				// Recaptcha Human Check
	'amazonses'					=> MODPATH . 'amazonses',				// Amazon Simple Email Service
);

if(Kohana::$environment > Kohana::PRODUCTION) {
	error_reporting(E_ALL & ~E_NOTICE);
	$modules = array(
//		'profilertoolbar'			=> MODPATH . 'profilertoolbar',			// Profiler Toolbar
//		'userguide'					=> MODPATH . 'userguide',				// User guide and API documentation
//		'unittest'					=> MODPATH . 'unittest',				// Unit testing
//		'codebench'					=> MODPATH . 'codebench',				// Benchmarking tool
//		'logviewer'					=> MODPATH . 'logviewer',				// Kohana Log Viewer
//		'debugtoolbar'				=> MODPATH . 'debugtoolbar',			// Debug Toolbar
	) + $modules;
}


/**
 * Enable modules. Modules are referenced by a relative or absolute path.
 */
$modules = Kohana::modules($modules);


// Set the magic salt to add to a cookie
Cookie::$salt = 'saltpeanutssaltpeanuts';

if(isset($_SERVER["HTTP_X_FORWARDED_FOR"])) {

	$long = ip2long($_SERVER["REMOTE_ADDR"]);

	if (($long >= 167772160 AND $long <= 184549375) OR ($long >= -1408237568 AND $long <= -1407188993) OR ($long >= -1062731776 AND $long <= -1062666241) OR ($long >= 2130706432 AND $long <= 2147483647) OR $long == -1) {

		array_push(Request::$trusted_proxies, $_SERVER["REMOTE_ADDR"]);

	}
}

/**
 * Set the routes. Each route must have a minimum of a name, a URI and a set of
 * defaults for the URI.
 */


// Error routing
Route::set('error', 'error(/<section>)'
)->defaults(array(
	'controller'	=> 'Error',
	'action'		=> 'index',
	'section'		=> FALSE,
));


// Profile routing
Route::set('profile', 'profile(/<controller>(/<id>(/<action>)))',
		array(
				'id'=>'[\w]{8}-[\w]{4}-[\w]{4}-[\w]{4}-[\w]{12}',
		)
)->defaults(array(
		'directory'		=> 'profile',
		'controller'	=> 'profile',
		'action'		=> 'index',
		'id'			=> FALSE,
));

// Index routing
Route::set('default', '(<controller>(/<action>(/<id>)(/<crumbs>)))',
	array(
		'id'=>'[\w]{8}-[\w]{4}-[\w]{4}-[\w]{4}-[\w]{12}|[0-9]*',
		'crumbs' => '.*',
	)
)->defaults(array(
	'controller'	=> 'Home',
	'action'		=> 'index',
));