<?php
/**
 * Autogenerated by Thrift
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 */
include_once $GLOBALS['THRIFT_ROOT'].'/Thrift.php';


class VaeDbInternalError extends TException {
  static $_TSPEC;

  public $message = null;

  public function __construct($vals=null) {
    if (!isset(self::$_TSPEC)) {
      self::$_TSPEC = array(
        1 => array(
          'var' => 'message',
          'type' => TType::STRING,
          ),
        );
    }
    if (is_array($vals)) {
      if (isset($vals['message'])) {
        $this->message = $vals['message'];
      }
    }
  }

  public function getName() {
    return 'VaeDbInternalError';
  }

  public function read($input)
  {
    $xfer = 0;
    $fname = null;
    $ftype = 0;
    $fid = 0;
    $xfer += $input->readStructBegin($fname);
    while (true)
    {
      $xfer += $input->readFieldBegin($fname, $ftype, $fid);
      if ($ftype == TType::STOP) {
        break;
      }
      switch ($fid)
      {
        case 1:
          if ($ftype == TType::STRING) {
            $xfer += $input->readString($this->message);
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        default:
          $xfer += $input->skip($ftype);
          break;
      }
      $xfer += $input->readFieldEnd();
    }
    $xfer += $input->readStructEnd();
    return $xfer;
  }

  public function write($output) {
    $xfer = 0;
    $xfer += $output->writeStructBegin('VaeDbInternalError');
    if ($this->message !== null) {
      $xfer += $output->writeFieldBegin('message', TType::STRING, 1);
      $xfer += $output->writeString($this->message);
      $xfer += $output->writeFieldEnd();
    }
    $xfer += $output->writeFieldStop();
    $xfer += $output->writeStructEnd();
    return $xfer;
  }

}

class VaeDbQueryError extends TException {
  static $_TSPEC;

  public $message = null;

  public function __construct($vals=null) {
    if (!isset(self::$_TSPEC)) {
      self::$_TSPEC = array(
        1 => array(
          'var' => 'message',
          'type' => TType::STRING,
          ),
        );
    }
    if (is_array($vals)) {
      if (isset($vals['message'])) {
        $this->message = $vals['message'];
      }
    }
  }

  public function getName() {
    return 'VaeDbQueryError';
  }

  public function read($input)
  {
    $xfer = 0;
    $fname = null;
    $ftype = 0;
    $fid = 0;
    $xfer += $input->readStructBegin($fname);
    while (true)
    {
      $xfer += $input->readFieldBegin($fname, $ftype, $fid);
      if ($ftype == TType::STOP) {
        break;
      }
      switch ($fid)
      {
        case 1:
          if ($ftype == TType::STRING) {
            $xfer += $input->readString($this->message);
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        default:
          $xfer += $input->skip($ftype);
          break;
      }
      $xfer += $input->readFieldEnd();
    }
    $xfer += $input->readStructEnd();
    return $xfer;
  }

  public function write($output) {
    $xfer = 0;
    $xfer += $output->writeStructBegin('VaeDbQueryError');
    if ($this->message !== null) {
      $xfer += $output->writeFieldBegin('message', TType::STRING, 1);
      $xfer += $output->writeString($this->message);
      $xfer += $output->writeFieldEnd();
    }
    $xfer += $output->writeFieldStop();
    $xfer += $output->writeStructEnd();
    return $xfer;
  }

}

class VaeSyntaxError extends TException {
  static $_TSPEC;

  public $message = null;

  public function __construct($vals=null) {
    if (!isset(self::$_TSPEC)) {
      self::$_TSPEC = array(
        1 => array(
          'var' => 'message',
          'type' => TType::STRING,
          ),
        );
    }
    if (is_array($vals)) {
      if (isset($vals['message'])) {
        $this->message = $vals['message'];
      }
    }
  }

  public function getName() {
    return 'VaeSyntaxError';
  }

  public function read($input)
  {
    $xfer = 0;
    $fname = null;
    $ftype = 0;
    $fid = 0;
    $xfer += $input->readStructBegin($fname);
    while (true)
    {
      $xfer += $input->readFieldBegin($fname, $ftype, $fid);
      if ($ftype == TType::STOP) {
        break;
      }
      switch ($fid)
      {
        case 1:
          if ($ftype == TType::STRING) {
            $xfer += $input->readString($this->message);
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        default:
          $xfer += $input->skip($ftype);
          break;
      }
      $xfer += $input->readFieldEnd();
    }
    $xfer += $input->readStructEnd();
    return $xfer;
  }

  public function write($output) {
    $xfer = 0;
    $xfer += $output->writeStructBegin('VaeSyntaxError');
    if ($this->message !== null) {
      $xfer += $output->writeFieldBegin('message', TType::STRING, 1);
      $xfer += $output->writeString($this->message);
      $xfer += $output->writeFieldEnd();
    }
    $xfer += $output->writeFieldStop();
    $xfer += $output->writeStructEnd();
    return $xfer;
  }

}

class VaeDbContext {
  static $_TSPEC;

  public $id = null;
  public $structure_id = null;
  public $type = null;
  public $permalink = null;
  public $data = null;
  public $dataMap = null;

  public function __construct($vals=null) {
    if (!isset(self::$_TSPEC)) {
      self::$_TSPEC = array(
        1 => array(
          'var' => 'id',
          'type' => TType::I32,
          ),
        2 => array(
          'var' => 'structure_id',
          'type' => TType::I32,
          ),
        3 => array(
          'var' => 'type',
          'type' => TType::STRING,
          ),
        4 => array(
          'var' => 'permalink',
          'type' => TType::STRING,
          ),
        5 => array(
          'var' => 'data',
          'type' => TType::STRING,
          ),
        6 => array(
          'var' => 'dataMap',
          'type' => TType::MAP,
          'ktype' => TType::STRING,
          'vtype' => TType::STRING,
          'key' => array(
            'type' => TType::STRING,
          ),
          'val' => array(
            'type' => TType::STRING,
            ),
          ),
        );
    }
    if (is_array($vals)) {
      if (isset($vals['id'])) {
        $this->id = $vals['id'];
      }
      if (isset($vals['structure_id'])) {
        $this->structure_id = $vals['structure_id'];
      }
      if (isset($vals['type'])) {
        $this->type = $vals['type'];
      }
      if (isset($vals['permalink'])) {
        $this->permalink = $vals['permalink'];
      }
      if (isset($vals['data'])) {
        $this->data = $vals['data'];
      }
      if (isset($vals['dataMap'])) {
        $this->dataMap = $vals['dataMap'];
      }
    }
  }

  public function getName() {
    return 'VaeDbContext';
  }

  public function read($input)
  {
    $xfer = 0;
    $fname = null;
    $ftype = 0;
    $fid = 0;
    $xfer += $input->readStructBegin($fname);
    while (true)
    {
      $xfer += $input->readFieldBegin($fname, $ftype, $fid);
      if ($ftype == TType::STOP) {
        break;
      }
      switch ($fid)
      {
        case 1:
          if ($ftype == TType::I32) {
            $xfer += $input->readI32($this->id);
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        case 2:
          if ($ftype == TType::I32) {
            $xfer += $input->readI32($this->structure_id);
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        case 3:
          if ($ftype == TType::STRING) {
            $xfer += $input->readString($this->type);
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        case 4:
          if ($ftype == TType::STRING) {
            $xfer += $input->readString($this->permalink);
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        case 5:
          if ($ftype == TType::STRING) {
            $xfer += $input->readString($this->data);
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        case 6:
          if ($ftype == TType::MAP) {
            $this->dataMap = array();
            $_size0 = 0;
            $_ktype1 = 0;
            $_vtype2 = 0;
            $xfer += $input->readMapBegin($_ktype1, $_vtype2, $_size0);
            for ($_i4 = 0; $_i4 < $_size0; ++$_i4)
            {
              $key5 = '';
              $val6 = '';
              $xfer += $input->readString($key5);
              $xfer += $input->readString($val6);
              $this->dataMap[$key5] = $val6;
            }
            $xfer += $input->readMapEnd();
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        default:
          $xfer += $input->skip($ftype);
          break;
      }
      $xfer += $input->readFieldEnd();
    }
    $xfer += $input->readStructEnd();
    return $xfer;
  }

  public function write($output) {
    $xfer = 0;
    $xfer += $output->writeStructBegin('VaeDbContext');
    if ($this->id !== null) {
      $xfer += $output->writeFieldBegin('id', TType::I32, 1);
      $xfer += $output->writeI32($this->id);
      $xfer += $output->writeFieldEnd();
    }
    if ($this->structure_id !== null) {
      $xfer += $output->writeFieldBegin('structure_id', TType::I32, 2);
      $xfer += $output->writeI32($this->structure_id);
      $xfer += $output->writeFieldEnd();
    }
    if ($this->type !== null) {
      $xfer += $output->writeFieldBegin('type', TType::STRING, 3);
      $xfer += $output->writeString($this->type);
      $xfer += $output->writeFieldEnd();
    }
    if ($this->permalink !== null) {
      $xfer += $output->writeFieldBegin('permalink', TType::STRING, 4);
      $xfer += $output->writeString($this->permalink);
      $xfer += $output->writeFieldEnd();
    }
    if ($this->data !== null) {
      $xfer += $output->writeFieldBegin('data', TType::STRING, 5);
      $xfer += $output->writeString($this->data);
      $xfer += $output->writeFieldEnd();
    }
    if ($this->dataMap !== null) {
      if (!is_array($this->dataMap)) {
        throw new TProtocolException('Bad type in structure.', TProtocolException::INVALID_DATA);
      }
      $xfer += $output->writeFieldBegin('dataMap', TType::MAP, 6);
      {
        $output->writeMapBegin(TType::STRING, TType::STRING, count($this->dataMap));
        {
          foreach ($this->dataMap as $kiter7 => $viter8)
          {
            $xfer += $output->writeString($kiter7);
            $xfer += $output->writeString($viter8);
          }
        }
        $output->writeMapEnd();
      }
      $xfer += $output->writeFieldEnd();
    }
    $xfer += $output->writeFieldStop();
    $xfer += $output->writeStructEnd();
    return $xfer;
  }

}

class VaeDbCreateInfo {
  static $_TSPEC;

  public $structure_id = null;
  public $row_id = null;

  public function __construct($vals=null) {
    if (!isset(self::$_TSPEC)) {
      self::$_TSPEC = array(
        1 => array(
          'var' => 'structure_id',
          'type' => TType::I32,
          ),
        2 => array(
          'var' => 'row_id',
          'type' => TType::I32,
          ),
        );
    }
    if (is_array($vals)) {
      if (isset($vals['structure_id'])) {
        $this->structure_id = $vals['structure_id'];
      }
      if (isset($vals['row_id'])) {
        $this->row_id = $vals['row_id'];
      }
    }
  }

  public function getName() {
    return 'VaeDbCreateInfo';
  }

  public function read($input)
  {
    $xfer = 0;
    $fname = null;
    $ftype = 0;
    $fid = 0;
    $xfer += $input->readStructBegin($fname);
    while (true)
    {
      $xfer += $input->readFieldBegin($fname, $ftype, $fid);
      if ($ftype == TType::STOP) {
        break;
      }
      switch ($fid)
      {
        case 1:
          if ($ftype == TType::I32) {
            $xfer += $input->readI32($this->structure_id);
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        case 2:
          if ($ftype == TType::I32) {
            $xfer += $input->readI32($this->row_id);
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        default:
          $xfer += $input->skip($ftype);
          break;
      }
      $xfer += $input->readFieldEnd();
    }
    $xfer += $input->readStructEnd();
    return $xfer;
  }

  public function write($output) {
    $xfer = 0;
    $xfer += $output->writeStructBegin('VaeDbCreateInfo');
    if ($this->structure_id !== null) {
      $xfer += $output->writeFieldBegin('structure_id', TType::I32, 1);
      $xfer += $output->writeI32($this->structure_id);
      $xfer += $output->writeFieldEnd();
    }
    if ($this->row_id !== null) {
      $xfer += $output->writeFieldBegin('row_id', TType::I32, 2);
      $xfer += $output->writeI32($this->row_id);
      $xfer += $output->writeFieldEnd();
    }
    $xfer += $output->writeFieldStop();
    $xfer += $output->writeStructEnd();
    return $xfer;
  }

}

class VaeDbStructure {
  static $_TSPEC;

  public $id = null;
  public $name = null;
  public $type = null;
  public $permalink = null;

  public function __construct($vals=null) {
    if (!isset(self::$_TSPEC)) {
      self::$_TSPEC = array(
        1 => array(
          'var' => 'id',
          'type' => TType::I32,
          ),
        2 => array(
          'var' => 'name',
          'type' => TType::STRING,
          ),
        3 => array(
          'var' => 'type',
          'type' => TType::STRING,
          ),
        4 => array(
          'var' => 'permalink',
          'type' => TType::STRING,
          ),
        );
    }
    if (is_array($vals)) {
      if (isset($vals['id'])) {
        $this->id = $vals['id'];
      }
      if (isset($vals['name'])) {
        $this->name = $vals['name'];
      }
      if (isset($vals['type'])) {
        $this->type = $vals['type'];
      }
      if (isset($vals['permalink'])) {
        $this->permalink = $vals['permalink'];
      }
    }
  }

  public function getName() {
    return 'VaeDbStructure';
  }

  public function read($input)
  {
    $xfer = 0;
    $fname = null;
    $ftype = 0;
    $fid = 0;
    $xfer += $input->readStructBegin($fname);
    while (true)
    {
      $xfer += $input->readFieldBegin($fname, $ftype, $fid);
      if ($ftype == TType::STOP) {
        break;
      }
      switch ($fid)
      {
        case 1:
          if ($ftype == TType::I32) {
            $xfer += $input->readI32($this->id);
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        case 2:
          if ($ftype == TType::STRING) {
            $xfer += $input->readString($this->name);
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        case 3:
          if ($ftype == TType::STRING) {
            $xfer += $input->readString($this->type);
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        case 4:
          if ($ftype == TType::STRING) {
            $xfer += $input->readString($this->permalink);
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        default:
          $xfer += $input->skip($ftype);
          break;
      }
      $xfer += $input->readFieldEnd();
    }
    $xfer += $input->readStructEnd();
    return $xfer;
  }

  public function write($output) {
    $xfer = 0;
    $xfer += $output->writeStructBegin('VaeDbStructure');
    if ($this->id !== null) {
      $xfer += $output->writeFieldBegin('id', TType::I32, 1);
      $xfer += $output->writeI32($this->id);
      $xfer += $output->writeFieldEnd();
    }
    if ($this->name !== null) {
      $xfer += $output->writeFieldBegin('name', TType::STRING, 2);
      $xfer += $output->writeString($this->name);
      $xfer += $output->writeFieldEnd();
    }
    if ($this->type !== null) {
      $xfer += $output->writeFieldBegin('type', TType::STRING, 3);
      $xfer += $output->writeString($this->type);
      $xfer += $output->writeFieldEnd();
    }
    if ($this->permalink !== null) {
      $xfer += $output->writeFieldBegin('permalink', TType::STRING, 4);
      $xfer += $output->writeString($this->permalink);
      $xfer += $output->writeFieldEnd();
    }
    $xfer += $output->writeFieldStop();
    $xfer += $output->writeStructEnd();
    return $xfer;
  }

}

class VaeDbResponseForContext {
  static $_TSPEC;

  public $contexts = null;
  public $totalItems = null;

  public function __construct($vals=null) {
    if (!isset(self::$_TSPEC)) {
      self::$_TSPEC = array(
        1 => array(
          'var' => 'contexts',
          'type' => TType::LST,
          'etype' => TType::STRUCT,
          'elem' => array(
            'type' => TType::STRUCT,
            'class' => 'VaeDbContext',
            ),
          ),
        2 => array(
          'var' => 'totalItems',
          'type' => TType::I32,
          ),
        );
    }
    if (is_array($vals)) {
      if (isset($vals['contexts'])) {
        $this->contexts = $vals['contexts'];
      }
      if (isset($vals['totalItems'])) {
        $this->totalItems = $vals['totalItems'];
      }
    }
  }

  public function getName() {
    return 'VaeDbResponseForContext';
  }

  public function read($input)
  {
    $xfer = 0;
    $fname = null;
    $ftype = 0;
    $fid = 0;
    $xfer += $input->readStructBegin($fname);
    while (true)
    {
      $xfer += $input->readFieldBegin($fname, $ftype, $fid);
      if ($ftype == TType::STOP) {
        break;
      }
      switch ($fid)
      {
        case 1:
          if ($ftype == TType::LST) {
            $this->contexts = array();
            $_size9 = 0;
            $_etype12 = 0;
            $xfer += $input->readListBegin($_etype12, $_size9);
            for ($_i13 = 0; $_i13 < $_size9; ++$_i13)
            {
              $elem14 = null;
              $elem14 = new VaeDbContext();
              $xfer += $elem14->read($input);
              $this->contexts []= $elem14;
            }
            $xfer += $input->readListEnd();
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        case 2:
          if ($ftype == TType::I32) {
            $xfer += $input->readI32($this->totalItems);
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        default:
          $xfer += $input->skip($ftype);
          break;
      }
      $xfer += $input->readFieldEnd();
    }
    $xfer += $input->readStructEnd();
    return $xfer;
  }

  public function write($output) {
    $xfer = 0;
    $xfer += $output->writeStructBegin('VaeDbResponseForContext');
    if ($this->contexts !== null) {
      if (!is_array($this->contexts)) {
        throw new TProtocolException('Bad type in structure.', TProtocolException::INVALID_DATA);
      }
      $xfer += $output->writeFieldBegin('contexts', TType::LST, 1);
      {
        $output->writeListBegin(TType::STRUCT, count($this->contexts));
        {
          foreach ($this->contexts as $iter15)
          {
            $xfer += $iter15->write($output);
          }
        }
        $output->writeListEnd();
      }
      $xfer += $output->writeFieldEnd();
    }
    if ($this->totalItems !== null) {
      $xfer += $output->writeFieldBegin('totalItems', TType::I32, 2);
      $xfer += $output->writeI32($this->totalItems);
      $xfer += $output->writeFieldEnd();
    }
    $xfer += $output->writeFieldStop();
    $xfer += $output->writeStructEnd();
    return $xfer;
  }

}

class VaeDbResponse {
  static $_TSPEC;

  public $id = null;
  public $contexts = null;

  public function __construct($vals=null) {
    if (!isset(self::$_TSPEC)) {
      self::$_TSPEC = array(
        1 => array(
          'var' => 'id',
          'type' => TType::I32,
          ),
        2 => array(
          'var' => 'contexts',
          'type' => TType::LST,
          'etype' => TType::STRUCT,
          'elem' => array(
            'type' => TType::STRUCT,
            'class' => 'VaeDbResponseForContext',
            ),
          ),
        );
    }
    if (is_array($vals)) {
      if (isset($vals['id'])) {
        $this->id = $vals['id'];
      }
      if (isset($vals['contexts'])) {
        $this->contexts = $vals['contexts'];
      }
    }
  }

  public function getName() {
    return 'VaeDbResponse';
  }

  public function read($input)
  {
    $xfer = 0;
    $fname = null;
    $ftype = 0;
    $fid = 0;
    $xfer += $input->readStructBegin($fname);
    while (true)
    {
      $xfer += $input->readFieldBegin($fname, $ftype, $fid);
      if ($ftype == TType::STOP) {
        break;
      }
      switch ($fid)
      {
        case 1:
          if ($ftype == TType::I32) {
            $xfer += $input->readI32($this->id);
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        case 2:
          if ($ftype == TType::LST) {
            $this->contexts = array();
            $_size16 = 0;
            $_etype19 = 0;
            $xfer += $input->readListBegin($_etype19, $_size16);
            for ($_i20 = 0; $_i20 < $_size16; ++$_i20)
            {
              $elem21 = null;
              $elem21 = new VaeDbResponseForContext();
              $xfer += $elem21->read($input);
              $this->contexts []= $elem21;
            }
            $xfer += $input->readListEnd();
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        default:
          $xfer += $input->skip($ftype);
          break;
      }
      $xfer += $input->readFieldEnd();
    }
    $xfer += $input->readStructEnd();
    return $xfer;
  }

  public function write($output) {
    $xfer = 0;
    $xfer += $output->writeStructBegin('VaeDbResponse');
    if ($this->id !== null) {
      $xfer += $output->writeFieldBegin('id', TType::I32, 1);
      $xfer += $output->writeI32($this->id);
      $xfer += $output->writeFieldEnd();
    }
    if ($this->contexts !== null) {
      if (!is_array($this->contexts)) {
        throw new TProtocolException('Bad type in structure.', TProtocolException::INVALID_DATA);
      }
      $xfer += $output->writeFieldBegin('contexts', TType::LST, 2);
      {
        $output->writeListBegin(TType::STRUCT, count($this->contexts));
        {
          foreach ($this->contexts as $iter22)
          {
            $xfer += $iter22->write($output);
          }
        }
        $output->writeListEnd();
      }
      $xfer += $output->writeFieldEnd();
    }
    $xfer += $output->writeFieldStop();
    $xfer += $output->writeStructEnd();
    return $xfer;
  }

}

class VaeDbCreateInfoResponse {
  static $_TSPEC;

  public $contexts = null;

  public function __construct($vals=null) {
    if (!isset(self::$_TSPEC)) {
      self::$_TSPEC = array(
        1 => array(
          'var' => 'contexts',
          'type' => TType::LST,
          'etype' => TType::STRUCT,
          'elem' => array(
            'type' => TType::STRUCT,
            'class' => 'VaeDbCreateInfo',
            ),
          ),
        );
    }
    if (is_array($vals)) {
      if (isset($vals['contexts'])) {
        $this->contexts = $vals['contexts'];
      }
    }
  }

  public function getName() {
    return 'VaeDbCreateInfoResponse';
  }

  public function read($input)
  {
    $xfer = 0;
    $fname = null;
    $ftype = 0;
    $fid = 0;
    $xfer += $input->readStructBegin($fname);
    while (true)
    {
      $xfer += $input->readFieldBegin($fname, $ftype, $fid);
      if ($ftype == TType::STOP) {
        break;
      }
      switch ($fid)
      {
        case 1:
          if ($ftype == TType::LST) {
            $this->contexts = array();
            $_size23 = 0;
            $_etype26 = 0;
            $xfer += $input->readListBegin($_etype26, $_size23);
            for ($_i27 = 0; $_i27 < $_size23; ++$_i27)
            {
              $elem28 = null;
              $elem28 = new VaeDbCreateInfo();
              $xfer += $elem28->read($input);
              $this->contexts []= $elem28;
            }
            $xfer += $input->readListEnd();
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        default:
          $xfer += $input->skip($ftype);
          break;
      }
      $xfer += $input->readFieldEnd();
    }
    $xfer += $input->readStructEnd();
    return $xfer;
  }

  public function write($output) {
    $xfer = 0;
    $xfer += $output->writeStructBegin('VaeDbCreateInfoResponse');
    if ($this->contexts !== null) {
      if (!is_array($this->contexts)) {
        throw new TProtocolException('Bad type in structure.', TProtocolException::INVALID_DATA);
      }
      $xfer += $output->writeFieldBegin('contexts', TType::LST, 1);
      {
        $output->writeListBegin(TType::STRUCT, count($this->contexts));
        {
          foreach ($this->contexts as $iter29)
          {
            $xfer += $iter29->write($output);
          }
        }
        $output->writeListEnd();
      }
      $xfer += $output->writeFieldEnd();
    }
    $xfer += $output->writeFieldStop();
    $xfer += $output->writeStructEnd();
    return $xfer;
  }

}

class VaeDbDataForContext {
  static $_TSPEC;

  public $data = null;

  public function __construct($vals=null) {
    if (!isset(self::$_TSPEC)) {
      self::$_TSPEC = array(
        1 => array(
          'var' => 'data',
          'type' => TType::MAP,
          'ktype' => TType::STRING,
          'vtype' => TType::STRING,
          'key' => array(
            'type' => TType::STRING,
          ),
          'val' => array(
            'type' => TType::STRING,
            ),
          ),
        );
    }
    if (is_array($vals)) {
      if (isset($vals['data'])) {
        $this->data = $vals['data'];
      }
    }
  }

  public function getName() {
    return 'VaeDbDataForContext';
  }

  public function read($input)
  {
    $xfer = 0;
    $fname = null;
    $ftype = 0;
    $fid = 0;
    $xfer += $input->readStructBegin($fname);
    while (true)
    {
      $xfer += $input->readFieldBegin($fname, $ftype, $fid);
      if ($ftype == TType::STOP) {
        break;
      }
      switch ($fid)
      {
        case 1:
          if ($ftype == TType::MAP) {
            $this->data = array();
            $_size30 = 0;
            $_ktype31 = 0;
            $_vtype32 = 0;
            $xfer += $input->readMapBegin($_ktype31, $_vtype32, $_size30);
            for ($_i34 = 0; $_i34 < $_size30; ++$_i34)
            {
              $key35 = '';
              $val36 = '';
              $xfer += $input->readString($key35);
              $xfer += $input->readString($val36);
              $this->data[$key35] = $val36;
            }
            $xfer += $input->readMapEnd();
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        default:
          $xfer += $input->skip($ftype);
          break;
      }
      $xfer += $input->readFieldEnd();
    }
    $xfer += $input->readStructEnd();
    return $xfer;
  }

  public function write($output) {
    $xfer = 0;
    $xfer += $output->writeStructBegin('VaeDbDataForContext');
    if ($this->data !== null) {
      if (!is_array($this->data)) {
        throw new TProtocolException('Bad type in structure.', TProtocolException::INVALID_DATA);
      }
      $xfer += $output->writeFieldBegin('data', TType::MAP, 1);
      {
        $output->writeMapBegin(TType::STRING, TType::STRING, count($this->data));
        {
          foreach ($this->data as $kiter37 => $viter38)
          {
            $xfer += $output->writeString($kiter37);
            $xfer += $output->writeString($viter38);
          }
        }
        $output->writeMapEnd();
      }
      $xfer += $output->writeFieldEnd();
    }
    $xfer += $output->writeFieldStop();
    $xfer += $output->writeStructEnd();
    return $xfer;
  }

}

class VaeDbDataResponse {
  static $_TSPEC;

  public $contexts = null;

  public function __construct($vals=null) {
    if (!isset(self::$_TSPEC)) {
      self::$_TSPEC = array(
        1 => array(
          'var' => 'contexts',
          'type' => TType::LST,
          'etype' => TType::STRUCT,
          'elem' => array(
            'type' => TType::STRUCT,
            'class' => 'VaeDbDataForContext',
            ),
          ),
        );
    }
    if (is_array($vals)) {
      if (isset($vals['contexts'])) {
        $this->contexts = $vals['contexts'];
      }
    }
  }

  public function getName() {
    return 'VaeDbDataResponse';
  }

  public function read($input)
  {
    $xfer = 0;
    $fname = null;
    $ftype = 0;
    $fid = 0;
    $xfer += $input->readStructBegin($fname);
    while (true)
    {
      $xfer += $input->readFieldBegin($fname, $ftype, $fid);
      if ($ftype == TType::STOP) {
        break;
      }
      switch ($fid)
      {
        case 1:
          if ($ftype == TType::LST) {
            $this->contexts = array();
            $_size39 = 0;
            $_etype42 = 0;
            $xfer += $input->readListBegin($_etype42, $_size39);
            for ($_i43 = 0; $_i43 < $_size39; ++$_i43)
            {
              $elem44 = null;
              $elem44 = new VaeDbDataForContext();
              $xfer += $elem44->read($input);
              $this->contexts []= $elem44;
            }
            $xfer += $input->readListEnd();
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        default:
          $xfer += $input->skip($ftype);
          break;
      }
      $xfer += $input->readFieldEnd();
    }
    $xfer += $input->readStructEnd();
    return $xfer;
  }

  public function write($output) {
    $xfer = 0;
    $xfer += $output->writeStructBegin('VaeDbDataResponse');
    if ($this->contexts !== null) {
      if (!is_array($this->contexts)) {
        throw new TProtocolException('Bad type in structure.', TProtocolException::INVALID_DATA);
      }
      $xfer += $output->writeFieldBegin('contexts', TType::LST, 1);
      {
        $output->writeListBegin(TType::STRUCT, count($this->contexts));
        {
          foreach ($this->contexts as $iter45)
          {
            $xfer += $iter45->write($output);
          }
        }
        $output->writeListEnd();
      }
      $xfer += $output->writeFieldEnd();
    }
    $xfer += $output->writeFieldStop();
    $xfer += $output->writeStructEnd();
    return $xfer;
  }

}

class VaeDbStructureResponse {
  static $_TSPEC;

  public $contexts = null;

  public function __construct($vals=null) {
    if (!isset(self::$_TSPEC)) {
      self::$_TSPEC = array(
        1 => array(
          'var' => 'contexts',
          'type' => TType::LST,
          'etype' => TType::STRUCT,
          'elem' => array(
            'type' => TType::STRUCT,
            'class' => 'VaeDbStructure',
            ),
          ),
        );
    }
    if (is_array($vals)) {
      if (isset($vals['contexts'])) {
        $this->contexts = $vals['contexts'];
      }
    }
  }

  public function getName() {
    return 'VaeDbStructureResponse';
  }

  public function read($input)
  {
    $xfer = 0;
    $fname = null;
    $ftype = 0;
    $fid = 0;
    $xfer += $input->readStructBegin($fname);
    while (true)
    {
      $xfer += $input->readFieldBegin($fname, $ftype, $fid);
      if ($ftype == TType::STOP) {
        break;
      }
      switch ($fid)
      {
        case 1:
          if ($ftype == TType::LST) {
            $this->contexts = array();
            $_size46 = 0;
            $_etype49 = 0;
            $xfer += $input->readListBegin($_etype49, $_size46);
            for ($_i50 = 0; $_i50 < $_size46; ++$_i50)
            {
              $elem51 = null;
              $elem51 = new VaeDbStructure();
              $xfer += $elem51->read($input);
              $this->contexts []= $elem51;
            }
            $xfer += $input->readListEnd();
          } else {
            $xfer += $input->skip($ftype);
          }
          break;
        default:
          $xfer += $input->skip($ftype);
          break;
      }
      $xfer += $input->readFieldEnd();
    }
    $xfer += $input->readStructEnd();
    return $xfer;
  }

  public function write($output) {
    $xfer = 0;
    $xfer += $output->writeStructBegin('VaeDbStructureResponse');
    if ($this->contexts !== null) {
      if (!is_array($this->contexts)) {
        throw new TProtocolException('Bad type in structure.', TProtocolException::INVALID_DATA);
      }
      $xfer += $output->writeFieldBegin('contexts', TType::LST, 1);
      {
        $output->writeListBegin(TType::STRUCT, count($this->contexts));
        {
          foreach ($this->contexts as $iter52)
          {
            $xfer += $iter52->write($output);
          }
        }
        $output->writeListEnd();
      }
      $xfer += $output->writeFieldEnd();
    }
    $xfer += $output->writeFieldStop();
    $xfer += $output->writeStructEnd();
    return $xfer;
  }

}

?>
