<?php defined('SYSPATH') or die('No direct script access.');

abstract class Auth extends Kohana_Auth
{

	public static function validlogin($data)
	{
		if(array_key_exists('username',$data) && array_key_exists('password',$data)) {
			return Auth::instance()->login($data['username'], $data['password'], (array_key_exists('remember_me',$data) && $data['remember_me']==1) ?true:false);
		}
		return false;
    }
}
?>