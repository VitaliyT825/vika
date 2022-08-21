<?php

declare(strict_types=1);

namespace App\Factory;

use App\Doctrine\Migrations\AbstractClickHouseMigration;
use App\Manager\ClickHouseManager;
use Doctrine\DBAL\Connection;
use Doctrine\Migrations\AbstractMigration;
use Doctrine\Migrations\Version\MigrationFactory;
use Psr\Log\LoggerInterface;

use function is_a;

class MigrationFactories implements MigrationFactory
{
    protected Connection $connection;
    protected LoggerInterface $logger;
    protected ClickHouseManager $clickHouseManager;

    public function __construct(
        Connection $connection,
        LoggerInterface $logger,
        ClickHouseManager $clickHouseManager,
    ) {
        $this->connection = $connection;
        $this->logger = $logger;
        $this->clickHouseManager = $clickHouseManager;
    }

    public function createVersion(string $migrationClassName): AbstractMigration
    {
        if (is_a($migrationClassName, AbstractClickHouseMigration::class, true)) {
            return new $migrationClassName($this->connection, $this->logger, $this->clickHouseManager);
        }

        return new $migrationClassName($this->connection, $this->logger);
    }
}
