<?php

declare(strict_types=1);

namespace App\UseCase\Authentication\Profile;

use MarfaTech\Component\DtoResolver\Dto\DtoResolverInterface;
use MarfaTech\Component\DtoResolver\Dto\DtoResolverTrait;
use OpenApi\Annotations as OA;

/**
 * @OA\Schema(
 *     type="object",
 *     description="Result DTO for current user info endpoint",
 *     required={
 *         "email",
 *         "name",
 *         "roleList",
 *     },
 * )
 */
class GetProfileResultDto implements DtoResolverInterface
{
    use DtoResolverTrait;

    /**
     * @OA\Property(example="foo@acme.com")
     */
    private string $email;

    /**
     * @OA\Property(example="Ivan")
     */
    private string $name;

    /**
     * @OA\Property(
     *     type="array",
     *     @OA\Items(
     *         type="string",
     *     ),
     *     example={"ROLE_ADMIN", "ROLE_SUPER_ADMIN"},
     * )
     */
    private array $roleList;

    public function getEmail(): string
    {
        return $this->email;
    }

    public function getName(): string
    {
        return $this->name;
    }

    public function getRoleList(): array
    {
        return $this->roleList;
    }
}
