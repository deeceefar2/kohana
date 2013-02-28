<?php

return array(
    'contact_owner_email'		=> array(
		'Controller_Premium::notDefaultEmail'	=> '*Please enter an email address',
        'not_empty'								=> '*Email address is required',
        'email'									=> '*Email must be a valid email address',
    ),
    'contact_owner_question'	=> array(
		'Controller_Premium::notDefaultQuestion'	=> '*Please enter a question',
        'not_empty'									=> '*A question is required',
    ),
    'recaptcha'	=> array(
        'not_empty'								=> '*reCAPTCHA is required',
        'Controller_Premium::validRecaptcha'	=> '*reCAPTCHA not valid',
    ),
);