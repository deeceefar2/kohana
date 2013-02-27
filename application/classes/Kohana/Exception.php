<?php defined('SYSPATH') or die('No direct script access.');

class Kohana_Exception extends Kohana_Kohana_Exception
{

	public static function handler(Exception $e)
	{
		try
		{
			if (Kohana::DEVELOPMENT === Kohana::$environment)
			{
				parent::handler($e);
			}
			else
			{
				Kohana::$log->add(Log::ERROR, parent::text($e));

				$attributes = array();
				$attributes['section'] = Request::current()->directory();
				// Error sub-request.
				$request = Request::factory(Route::get('error')->uri($attributes));
				$request->post('exception', $e);
				echo $request->execute()
					->send_headers()
					->body();
			}
		}
		catch (Exception $e)
		{
			// Clean the output buffer if one exists
			ob_get_level() and ob_clean();

			// Display the exception text
			echo parent::text($e);

			//parent::handler($e);

			// Exit with an error status
			exit(1);
		}
    }
}
?>