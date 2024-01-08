<?php

declare(strict_types=1);

namespace App\UseCase\Authentication\Login;

use App\Dto\BackofficeAdminDto;
use App\UseCase\AbstractManager;
use DateTime;
use Doctrine\DBAL\Exception as DbalException;
use Exception;

class LoginManager extends AbstractManager
{
    /**
     * @throws DbalException
     * @throws Exception
     */
    public function findAdminByEmail(string $email): ?BackofficeAdminDto
    {
        $queryBuilder = $this->entityManager->getConnection()->createQueryBuilder();

        $queryBuilder
            ->addSelect('boa.id')
            ->addSelect('boa.email')
            ->addSelect('boa.name')
            ->addSelect('boa.password')
            ->addSelect('boa.roles')
            ->addSelect('boa.createdAt')
            ->addSelect('boa.updatedAt')
            ->from('BackOfficeAdmin', 'boa')
            ->where('boa.email = :email')
            ->andWhere('boa.deletedAt IS NULL')
            ->setParameter('email', $email)
        ;

        $stmt = $queryBuilder->executeQuery();

        $backofficeAdminDto = null;

        while ($row = $stmt->fetchAssociative()) {
            $backofficeAdminDto = new BackofficeAdminDto(
                id: (string) $row['id'],
                name: $row['name'],
                email: $row['email'],
                password: $row['password'],
                createdAt: new DateTime($row['createdAt']),
                updatedAt: new DateTime($row['updatedAt']),
                roles: $row['roles'],
            );
        }

        return $backofficeAdminDto;
    }

    /**
     * @throws DbalException
     */
    public function createToken(string $adminId, string $token, DateTime $expireDate): void
    {
        $now = (new DateTime())->format('Y-m-d H:i:s');

        $this->entityManager->getConnection()->insert(
            'BackOfficeToken',
            [
                'token' => $token,
                'backOfficeAdminId' => $adminId,
                'expiredAt' => $expireDate->format('Y-m-d H:i:s'),
                'createdAt' => $now,
                'updatedAt' => $now,
            ],
        );
    }
}
