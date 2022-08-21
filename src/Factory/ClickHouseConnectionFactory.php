<?php

declare(strict_types=1);

namespace App\Factory;

use ClickHouseDB\Client;

class ClickHouseConnectionFactory
{
    public static function create(string $database, string $username, string $password, string $host, int $port): Client
    {
        $clickHouseClient = new Client(
            [
                'database' => $database,
                'username' => $username,
                'password' => $password,
                'host' => $host,
                'port' => $port,
            ]
        );

        $clickHouseClient->setTimeout(60);
        $clickHouseClient->setConnectTimeOut(5);
        $clickHouseClient->database($database);

        return $clickHouseClient;
    }
}
