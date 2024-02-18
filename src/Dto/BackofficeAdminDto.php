<?php

declare(strict_types=1);

namespace App\Dto;

use DateTime;
use Symfony\Component\Security\Core\User\UserInterface;

class BackofficeAdminDto implements UserInterface
{
    public function __construct(
        public readonly string $id,
        public readonly string $name,
        public readonly string $email,
        public readonly string $password,
        public readonly DateTime $createdAt,
        public readonly DateTime $updatedAt,
        private readonly ?array $roles = [],
        public readonly ?string $token = null,
    ) {
    }

    public function getRoles(): array
    {
        return $this->roles;
    }

    public function eraseCredentials(): void
    {
    }

    public function getUserIdentifier(): string
    {
        return $this->email;
    }
}
