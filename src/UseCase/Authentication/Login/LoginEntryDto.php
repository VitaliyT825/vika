<?php

declare(strict_types=1);

namespace App\UseCase\Authentication\Login;

use MarfaTech\Component\DtoResolver\Dto\DtoResolverInterface;
use MarfaTech\Component\DtoResolver\Dto\DtoResolverTrait;
use OpenApi\Annotations as OA;

/**
 * @OA\Schema(
 *     type="object",
 *     description="Entry dto for user login",
 *     required={"email", "password"},
 * )
 */
class LoginEntryDto implements DtoResolverInterface
{
    use DtoResolverTrait;

    /**
     * @OA\Property(example="mail@pochta.moya")
     */
    private string $email;

    /**
     * @OA\Property(example="not easy pass")
     */
    private string $password;

    public function getEmail(): string
    {
        return $this->email;
    }

    public function getPassword(): string
    {
        return $this->password;
    }
}
