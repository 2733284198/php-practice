<?php
/**
 * Created by PhpStorm.
 * User: Tinywan
 * Date: 2017/1/5
 * Time: 15:29
 * Mail: Overcome.wan@Gmail.com
 */
namespace Org\Util;

use Monolog\Handler\AbstractProcessingHandler;
use Monolog\Logger;

require 'vendor/autoload.php';

class PDOHandler extends AbstractProcessingHandler
{
    private $initialized = false;
    private $pdo;
    private $statement;

    public function __construct($pdo, $level = Logger::DEBUG, $bubble = false)
    {
        $this->pdo = $pdo;
        parent::__construct($level, $bubble);
    }

    protected function write(array $record)
    {
        if (!$this->initialized) {
            $this->initialize();
        }
        $this->statement->execute(array(
            'channel' => $record['channel'],
            'level' => $record['level'],
            'message' => $record['formatted'],
            'time' => $record['datetime']->format('U'),
        ));
    }

    private function initialize()
    {
        $this->pdo->exec(
            'CREATE TABLE IF NOT EXISTS tour_monolog ' .'(channel VARCHAR(255), level INTEGER, message LONGTEXT, time INTEGER UNSIGNED) ENGINE=MyISAM DEFAULT CHARSET=utf8'
        );
        $this->statement = $this->pdo->prepare(
            'INSERT INTO tour_monolog (channel, level, message, time) VALUES (:channel, :level, :message, :time)'
        );

        $this->initialized = true;
    }

}