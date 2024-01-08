<?php

declare(strict_types=1);

namespace App\UseCase\Authentication\Profile;

use App\Dto\BackofficeAdminDto;
use App\Exception\AdminNotFoundException;
use MarfaTech\Bundle\ApiPlatformBundle\Factory\ApiDtoResolverFactoryInterface;
use Symfony\Component\Security\Core\Security;
use Symfony\Contracts\Service\Attribute\Required;

class ProfileHandler
{
    private Security $security;
    private ApiDtoResolverFactoryInterface $apiDtoResolverFactory;

    #[Required]
    public function dependencyInjection(
        Security $security,
        ApiDtoResolverFactoryInterface $apiDtoResolverFactory,
    ): void {
        $this->security = $security;
        $this->apiDtoResolverFactory = $apiDtoResolverFactory;
    }

    /**
     * @throws AdminNotFoundException
     */
    public function handle(): GetProfileResultDto
    {
        /** @var BackofficeAdminDto $backOfficeAdminDto */
        $backOfficeAdminDto = $this->security->getUser();

        if (!$backOfficeAdminDto) {
            throw new AdminNotFoundException();
        }

        /** @var GetProfileResultDto $getProfileResultDto */
        $getProfileResultDto = $this->apiDtoResolverFactory->createApiDto(GetProfileResultDto::class, [
            'email' => $backOfficeAdminDto->email,
            'name' => $backOfficeAdminDto->name,
            'roleList' => $backOfficeAdminDto->getRoles(),
        ]);

        return $getProfileResultDto;
    }
}
