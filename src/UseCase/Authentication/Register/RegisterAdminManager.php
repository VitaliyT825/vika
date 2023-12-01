<?php

declare(strict_types=1);

namespace App\UseCase\Authentication\Register;

use App\UseCase\AbstractManager;
use DateTime;
use Doctrine\DBAL\Exception;

class RegisterAdminManager extends AbstractManager
{
    /**
     * @throws Exception
     */
    public function findAdminByEmail(string $email): ?string
    {
        $queryBuilder = $this->entityManager->getConnection()->createQueryBuilder();

        $queryBuilder
            ->select('boa.id')
            ->from('BackOfficeAdmin', 'boa')
            ->where('boa.email = :email')
            ->setParameter('email', $email)
        ;

        return $queryBuilder->executeQuery()->fetchOne()?: null;
    }

    /**
     * @throws Exception
     */
    public function createAdmin(RegisterAdminEntryDto $entryDto, string $hashedPassword): ?string
    {
        $conn = $this->entityManager->getConnection();
        $now = (new DateTime())->format('Y-m-d H:i:s');

        $conn->insert(
            'BackOfficeAdmin',
            [
                'name' => $entryDto->getName(),
                'email' => $entryDto->getEmail(),
                'password' => $hashedPassword,
                'createdAt' => $now,
                'updatedAt' => $now,
            ],
        );

        return $conn->lastInsertId('BackOfficeAdmin');
    }

    public function createToken(string $adminId, string $token, DateTime $expireDate)
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
