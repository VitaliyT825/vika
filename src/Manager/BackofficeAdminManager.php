<?php

declare(strict_types=1);

namespace App\Manager;

use App\Dto\BackofficeAdminDto;
use App\Entity\BackOfficeAdmin;
use App\Entity\BackOfficeToken;
use DateTime;
use Doctrine\ORM\EntityManagerInterface;
use Doctrine\ORM\NonUniqueResultException;
use Doctrine\ORM\Query\Expr\Join;

class BackofficeAdminManager
{
    public function __construct(
        private readonly EntityManagerInterface $entityManager
    ) {
    }

    /**
     * @throws NonUniqueResultException
     */
    public function findBackOfficeAdminByEmail(string $email): ?BackofficeAdminDto
    {
        $queryBuilder = $this->entityManager->createQueryBuilder();

        $queryBuilder
            ->select(
                sprintf(
                    'NEW %s(
                                boa.id,
                                boa.name,
                                boa.email,
                                boa.password,
                                boa.createdAt,
                                boa.updatedAt,
                                boa.roles,
                                bot.token
                            )',
                    BackofficeAdminDto::class
                )
            )
            ->from(BackOfficeAdmin::class, 'boa')
            ->join(BackOfficeToken::class, 'bot', Join::WITH, 'boa.id = bot.backOfficeAdmin')
            ->where('boa.email = :email')
            ->andWhere('bot.expiredAt > :now')
            ->andWhere('boa.deletedAt IS NULL')
            ->setParameter('email', $email)
            ->setParameter('now', (new DateTime())->format('Y-m-d H:i:s'))
            ->setMaxResults(1);
        ;

        return $queryBuilder->getQuery()->getOneOrNullResult();
    }

    /**
     * @throws NonUniqueResultException
     */
    public function findBackOfficeAdminByActiveToken(string $token): ?BackofficeAdminDto
    {
        $queryBuilder = $this->entityManager->createQueryBuilder();

        $queryBuilder
            ->select(
                sprintf(
                    'NEW %s(
                                boa.id,
                                boa.name,
                                boa.email,
                                boa.password,
                                boa.createdAt,
                                boa.updatedAt,
                                boa.roles,
                                bot.token
                            )',
                    BackofficeAdminDto::class
                )
            )
            ->from(BackOfficeAdmin::class, 'boa')
            ->join(BackOfficeToken::class, 'bot', Join::WITH, 'boa.id = bot.backOfficeAdmin')
            ->where('bot.token = :token')
            ->andWhere('bot.expiredAt > :now')
            ->andWhere('boa.deletedAt IS NULL')
            ->setParameter('token', $token)
            ->setParameter('now', (new DateTime())->format('Y-m-d H:i:s'))
        ;

        return $queryBuilder->getQuery()->getOneOrNullResult();
    }

    public function updateTokenExpiration(string $token, DateTime $newExpirationDate): void
    {
        $queryBuilder = $this->entityManager->createQueryBuilder();

        $queryBuilder
            ->update(BackOfficeToken::class, 'bot')
            ->set('bot.expiredAt', ':expiredAt')
            ->set('bot.updatedAt', ':now')
            ->where('bot.token = :token')
            ->setParameters([
                'expiredAt' => $newExpirationDate->format('Y-m-d H:i:s'),
                'token' => $token,
                'now' => (new DateTime())->format('Y-m-d H:i:s')
            ])
        ;

        $queryBuilder->getQuery()->execute();
    }
}
