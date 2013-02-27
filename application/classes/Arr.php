<?php defined('SYSPATH') or die('No direct script access.');

class Arr extends Kohana_Arr {

	/**
	 * Rotates a 2D array clockwise.
	 * Example, turns a 2x3 array into a 3x2 array.
	 *
	 * @param   array    array to rotate
	 * @param   boolean  keep the keys in the final rotated array. the sub arrays of the source array need to have the same key values.
	 *                   if your subkeys might not match, you need to pass FALSE here!
	 * @return  array
	 */
	public static function rotate($source_array, $keep_keys = TRUE)
	{
		$new_array = array();
		foreach ($source_array as $key => $value)
		{
			$value = ($keep_keys === TRUE) ? $value : array_values($value);
			foreach ($value as $k => $v)
			{
				$new_array[$k][$key] = $v;
			}
		}

		return $new_array;
	}

}
