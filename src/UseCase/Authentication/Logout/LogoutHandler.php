<?php

declare(strict_types=1);

namespace App\UseCase\Authentication\Logout;

use App\Dto\BackofficeAdminDto;
use App\UseCase\AbstractHandler;
use MarfaTech\Bundle\ApiPlatformBundle\Exception\ApiException;
use Symfony\Bundle\SecurityBundle\Security;
use Symfony\Contracts\Service\Attribute\Required;

class LogoutHandler extends AbstractHandler
{
    private LogoutManager $manager;
    private Security $security;

    #[Required]
    public function dependencyInjection(LogoutManager $manager, Security $security,): void
    {
        $this->manager = $manager;
        $this->security = $security;
    }

    public function handle(): void
    {
        /** @var BackofficeAdminDto $user */
        $user = $this->security->getUser();

        if ($user === null) {
            throw new ApiException(ApiException::HTTP_UNAUTHORIZED);
        }

        $this->manager->disableToken($user->token);
    }
}
