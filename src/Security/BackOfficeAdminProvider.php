<?php

declare(strict_types=1);

namespace App\Security;

use App\Dto\BackofficeAdminDto;
use App\Manager\BackofficeAdminManager;
use DateTime;
use Doctrine\ORM\NonUniqueResultException;
use Symfony\Component\Security\Core\Exception\UserNotFoundException;
use Symfony\Component\Security\Core\User\UserInterface;
use Symfony\Component\Security\Core\User\UserProviderInterface;

class BackOfficeAdminProvider implements UserProviderInterface
{
    public function __construct(
        private readonly BackofficeAdminManager $manager,
    ) {
    }

    /**
     * {@inheritDoc}
     */
    public function refreshUser(UserInterface $user): UserInterface
    {
        return $user;
    }

    /**
     * {@inheritDoc}
     */
    public function supportsClass(string $class): bool
    {
        return $class === BackofficeAdminDto::class;
    }

    /**
     * {@inheritDoc}
     */
    public function loadUserByIdentifier(string $identifier): UserInterface
    {
        return $this->loadUserByUsername($identifier);
    }

    /**
     * @throws NonUniqueResultException
     */
    public function findBackOfficeAdminByActiveToken(string $credentials): ?BackofficeAdminDto
    {
        return $this->manager->findBackOfficeAdminByActiveToken($credentials);
    }

    /**
     * @throws NonUniqueResultException
     */
    public function loadUserByUsername(string $username): BackofficeAdminDto
    {
        $backOfficeAdminDto = $this->manager->findBackOfficeAdminByEmail($username);

        if ($backOfficeAdminDto === null) {
            throw new UserNotFoundException();
        }

        return $backOfficeAdminDto;
    }

    public function updateTokenExpirationDate(string $token, int $backOfficeTokenExpireTime): void
    {
        $modifyPeriod = sprintf('+%d minute', $backOfficeTokenExpireTime);
        $newExpirationDate = (new DateTime())->modify($modifyPeriod);

        $this->manager->updateTokenExpiration($token, $newExpirationDate);
    }
}
