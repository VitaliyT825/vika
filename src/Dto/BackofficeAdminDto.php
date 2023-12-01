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
        private readonly array $roles,
        public readonly DateTime $createdAt,
        public readonly DateTime $updatedAt,
        public readonly ?string $token = null,
    ) {
    }
//
//    public function getId(): string
//    {
//        return $this->id;
//    }
//
//    public function getName(): string
//    {
//        return $this->name;
//    }
//
//    public function getEmail(): string
//    {
//        return $this->email;
//    }
//
//    public function getPassword(): string
//    {
//        return $this->password;
//    }
//
//    public function getCreatedAt(): string
//    {
//        return $this->createdAt;
//    }
//
//    public function getUpdatedAt(): string
//    {
//        return $this->updatedAt;
//    }
//
//    public function getToken(): string
//    {
//        return $this->token;
//    }

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
