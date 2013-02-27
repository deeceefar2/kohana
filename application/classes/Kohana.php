<?php
/**
 * Contains the most low-level helpers methods in Kohana:
 *
 * - Environment initialization
 * - Locating files within the cascading filesystem
 * - Auto-loading and transparent extension of classes
 * - Variable and path debugging
 *
 * @package    Kohana
 * @category   Base
 * @author     Kohana Team
 * @copyright  (c) 2008-2011 Kohana Team
 * @license    http://kohanaframework.org/license
 */

class Kohana extends Kohana_Core {

	/**
	 * Catches errors that are not caught by the error handler, such as E_PARSE.
	 *
	 * @uses    Kohana_Exception::handler
	 * @return  void
	 */
	public static function shutdown_handler()
	{
		Kohana_Core::shutdown_handler();

		if (Kohana::$errors AND $error = error_get_last() AND $error['type'] == E_COMPILE_ERROR)
			print_r($error);
	}

} // End Kohana
