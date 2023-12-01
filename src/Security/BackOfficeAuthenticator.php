<?php

declare(strict_types=1);

namespace App\Security;

use Doctrine\ORM\NonUniqueResultException;
use MarfaTech\Bundle\ApiPlatformBundle\Exception\ApiException;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Security\Core\Authentication\Token\TokenInterface;
use Symfony\Component\Security\Core\Exception\AuthenticationException;
use Symfony\Component\Security\Http\Authenticator\AbstractAuthenticator;
use Symfony\Component\Security\Http\Authenticator\Passport\Badge\UserBadge;
use Symfony\Component\Security\Http\Authenticator\Passport\Passport;
use Symfony\Component\Security\Http\Authenticator\Passport\SelfValidatingPassport;
use Symfony\Contracts\Service\Attribute\Required;

class BackOfficeAuthenticator extends AbstractAuthenticator
{
    private int $backOfficeTokenExpireTime;
    private BackOfficeAdminProvider $userProvider;

    #[Required]
    public function dependencyInjection(
        int $backOfficeTokenExpireTime,
        BackOfficeAdminProvider $userProvider
    ): void {
        $this->backOfficeTokenExpireTime = $backOfficeTokenExpireTime;
        $this->userProvider = $userProvider;
    }

    public function supports(Request $request): bool
    {;
        return true;
    }

    /**
     * @throws NonUniqueResultException
     */
    public function authenticate(Request $request): Passport
    {
        $token = $request->headers->get('X-Auth-Token') ?: '';

        $backOfficeAdminDto = $this->userProvider->findBackOfficeAdminByActiveToken($token);

        if ($backOfficeAdminDto === null) {
            throw new AuthenticationException();
        }

        $this->userProvider->updateTokenExpirationDate($token, $this->backOfficeTokenExpireTime);

        return new SelfValidatingPassport(
            new UserBadge($backOfficeAdminDto->email)
        );
    }

    public function onAuthenticationSuccess(Request $request, TokenInterface $token, string $firewallName): ?Response
    {
        return null;
    }

    public function onAuthenticationFailure(Request $request, AuthenticationException $exception): ?Response
    {
        throw new ApiException(ApiException::HTTP_UNAUTHORIZED);
    }
}
