<?php

declare(strict_types=1);

namespace App\UseCase\Authentication\Login;

use MarfaTech\Component\DtoResolver\Dto\DtoResolverInterface;
use MarfaTech\Component\DtoResolver\Dto\DtoResolverTrait;
use OpenApi\Annotations as OA;

/**
 * @OA\Schema(
 *     type="object",
 *     description="Result DTO for admin login endpoint",
 * )
 */
class LoginResultDto implements DtoResolverInterface
{
    use DtoResolverTrait;

    /**
     * @OA\Property(example="ytn5tyjdfhsty67jh6r75u8967584743yuiyolyiu")
     */
    private string $token;

    public function getToken(): string
    {
        return $this->token;
    }
}
