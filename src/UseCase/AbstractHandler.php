<?php

declare(strict_types=1);

namespace App\UseCase;

use App\Services\TokenGeneratorService;
use MarfaTech\Bundle\ApiPlatformBundle\Factory\ApiDtoResolverFactory;
use Symfony\Component\PasswordHasher\Hasher\PasswordHasherFactoryInterface;

abstract class AbstractHandler
{
    public function __construct(
        private readonly ApiDtoResolverFactory $apiDtoFactory,
        protected readonly PasswordHasherFactoryInterface $encoder,
        protected TokenGeneratorService $tokenGenerator,
    ) {
    }

    protected function getApiDtoFactory(): ApiDtoResolverFactory
    {
        return $this->apiDtoFactory;
    }
}
