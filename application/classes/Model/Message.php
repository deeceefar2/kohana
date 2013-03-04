<?php defined('SYSPATH') or die('No direct access allowed.');
/**
 * Reply Model
 * @author davidf
 *
 */
class Model_Message extends Model_Base {

	protected $_table_name = 'messages';

	protected $_primary_key = 'message_id';

	protected $_belongs_to = array(
		'user'		 	=> array(),
		'parent'		=> array('model' => 'message', 'foreign_key' => 'parent_id'),
	);

	protected $_has_one = array(
		//'user'   	=> array(),
	);

	protected $_has_many = array(
		'attachments'	=> array('model'=>'File', 'foreign_key' => 'file_id', 'through' => 'message_files'),
		'users'			=> array('model'=>'User', 'foreign_key' => 'user_id', 'through' => 'message_users'),
		'replies'		=> array('model'=>'Message', 'foreign_key' => 'parent_id'),
		//'children'	=> array('model'=>'Category', 'foreign_key' => 'parent_id'),
	);

	protected $_serialize_columns = array(
		'message_to',
		'message_cc',
		'message_bcc',
		'message_reply_to',
	);

	public function labels()
	{
		return array(
			'message_id'				=> 'message id',
			'message_user_id'			=> 'user id',
			'parent_id'					=> 'parent id',
			'message_to'				=> 'to',
			'message_cc'				=> 'cc',
			'message_bcc'				=> 'bcc',
			'message_reply_to'			=> 'reply to',
			'message_from'				=> 'from',
			'message_return_path'		=> 'return path',
			'message_subject'			=> 'subject',
			'message_subject_charset'	=> 'subject character set',
			'message_text'				=> 'text',
			'message_text_charset'		=> 'text character set',
			'message_html'				=> 'html',
			'message_html_charset'		=> 'html character set',
			'message_date_modified'		=> 'date modified',
			'message_ip'				=> 'ip address',
		);
	}

	public function filters()
	{
		return array(
			'message_from' => array(
				array('trim'),
			),
			'message_return_path' => array(
				array('trim'),
			),
			'message_subject' => array(
				array('trim'),
			),
		);
	}

	public function rules()
	{
		return array(
			'user_id' => array(
				array(array($this,'exists'), array('users', ':field', ':value', ':validation')),
			),
			'parent_id' => array(
				array(array($this,'exists'), array('users', ':field', ':value', ':validation')),
			),
			'message_to' => array(
				array(array($this,'validAddresses'), array(':field', ':value', ':validation')),
			),
			'message_to' => array(
				array('not_empty'),
				array(array($this,'validAddresses'), array(':field', ':value', ':validation')),
			),
			'message_cc' => array(
				array(array($this,'validAddresses'), array(':field', ':value', ':validation')),
			),
			'message_bcc' => array(
				array(array($this,'validAddresses'), array(':field', ':value', ':validation')),
			),
			'message_reply_to' => array(
				array(array($this,'validAddresses'), array(':field', ':value', ':validation')),
			),
		);
	}

	public static function validAddresses($field, $value, $validation = NULL)
	{
		if($value=='')
			return;
		foreach(json_decode($value) as $email) {
			if(!Valid::email($email)) {
				if($validation === NULL)
					return false;
				else
					$validation->error($field, __function__, array($email));
			}
		}

		if($validation === NULL)
			return true;
	}

	public function addTo($to) {
		if(!is_array($to)) {
			$to = array($to);
		}
		if(is_array($this->message_to)) {
			$this->message_to = array_merge($to,$this->message_to);
		} else {
			$this->message_to = $to;
		}
		return $this;
	}

	public function addCC($cc) {
		if(!is_array($cc)) {
			$cc = array($cc);
		}
		if(is_array($this->message_cc)) {
			$this->message_cc = array_merge($cc,$this->message_cc);
		} else {
			$this->message_cc = $cc;
		}
		return $this;
	}

	public function addBCC($bcc) {
		if(!is_array($bcc)) {
			$bcc = array($bcc);
		}
		if(is_array($this->message_bcc)) {
			$this->message_bcc = array_merge($bcc,$this->message_bcc);
		} else {
			$this->message_bcc = $bcc;
		}
		return $this;
	}

	public function addReplyTo($reply_to) {
		if(!is_array($reply_to)) {
			$reply_to = array($reply_to);
		}
		if(is_array($this->message_bcc)) {
			$this->message_reply_to = array_merge($reply_to,$this->message_reply_to);
		} else {
			$this->message_reply_to = $reply_to;
		}
		return $this;
	}

	public function save(Validation $validation = NULL)
	{
		$this->message_ip = Request::$client_ip;
		return parent::save($validation);
	}
}