<?php

declare(strict_types=1);

namespace App\Dto;

use Symfony\Component\Security\Core\User\UserInterface;

class BackofficeAdminDto implements UserInterface
{
    public function __construct(
        public readonly string $id,
        public readonly string $name,
        public readonly string $email,
        public readonly string $password,
        public readonly string $createdAt,
        public readonly string $updatedAt,
        private readonly ?string $roles = null,
        public readonly ?string $token = null,
    ) {
    }

    public function getRoles(): array
    {
        return $this->roles ? explode(',', $this->roles) : [];
    }

    public function eraseCredentials(): void
    {
    }

    public function getUserIdentifier(): string
    {
        return $this->email;
    }
}
