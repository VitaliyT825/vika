<?php

declare(strict_types=1);

namespace App\UseCase\Authentication\Register;

use MarfaTech\Component\DtoResolver\Dto\DtoResolverInterface;
use MarfaTech\Component\DtoResolver\Dto\DtoResolverTrait;
use OpenApi\Annotations as OA;

/**
 * @OA\Schema(
 *     description="Entry dto for registry admin",
 *     required={"email", "password", "name"}
 * )
 */
class RegisterAdminEntryDto implements DtoResolverInterface
{
    use DtoResolverTrait;

    /**
     * @OA\Property(example="Pavel")
     */
    private string $name;

    /**
     * @OA\Property(example="pechkin@mail.ru")
     */
    private string $email;

    /**
     * @OA\Property(example="password")
     */
    private string $password;

    /**
     * @OA\Property(
     *     type="array",
     *     uniqueItems=true,
     *     @OA\Items(type="string"),
     *     example={
     *          ROLE_ADMIN,
     *     },
     * )
     */
    private ?array $roles = null;

    public function getName(): string
    {
        return $this->name;
    }

    public function getEmail(): string
    {
        return $this->email;
    }

    public function getPassword(): string
    {
        return $this->password;
    }

    public function getRoles(): ?array
    {
        return $this->roles;
    }
}
