<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20231129021311 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE BackOfficeToken (
            id INT AUTO_INCREMENT NOT NULL,
            token VARCHAR(255) NOT NULL,
            expiredAt DATETIME NOT NULL,
            createdAt DATETIME NOT NULL,
            updatedAt DATETIME NOT NULL,
            backOfficeAdminId INT DEFAULT NULL,
            INDEX IDX_8DA2B2D123E5D3E6 (backOfficeAdminId),
            UNIQUE INDEX unxToken (token),
            PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('ALTER TABLE BackOfficeToken ADD CONSTRAINT FK_8DA2B2D123E5D3E6 FOREIGN KEY (backOfficeAdminId) REFERENCES BackOfficeAdmin (id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE BackOfficeToken DROP FOREIGN KEY FK_8DA2B2D123E5D3E6');
        $this->addSql('DROP TABLE BackOfficeToken');
    }
}
