<?php

declare(strict_types=1);

namespace App\Manager;

use ClickHouseDB\Client;

class ClickHouseManager
{
    private Client $clickHouseClient;

    public function __construct(Client $clickHouseClient)
    {
        $this->clickHouseClient = $clickHouseClient;
    }

    public function getConnection(): Client
    {
        return $this->clickHouseClient;
    }
}
