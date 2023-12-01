<?php

declare(strict_types=1);

namespace App\UseCase\Authentication\Register;

use MarfaTech\Component\DtoResolver\Dto\DtoResolverInterface;
use MarfaTech\Component\DtoResolver\Dto\DtoResolverTrait;
use OpenApi\Annotations as OA;

/**
 * @OA\Schema(
 *     type="object",
 *     description="Result DTO for register admin endpoint",
 * )
 */
class RegisterAdminResultDto implements DtoResolverInterface
{
    use DtoResolverTrait;

    /**
     * @OA\Property(example="bb396a09ef17b24573325bd5a3ba5a93480771551fcb9fa2f74113c4517254c7")
     */
    private string $token;

    public function getToken(): string
    {
        return $this->token;
    }
}
