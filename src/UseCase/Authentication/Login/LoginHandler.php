<?php

declare(strict_types=1);

namespace App\UseCase\Authentication\Login;

use App\Entity\BackOfficeAdmin;
use App\Exception\AdminNotFoundException;
use App\Exception\InvalidPasswordException;
use App\UseCase\AbstractHandler;
use DateTime;
use Doctrine\DBAL\Exception;
use Symfony\Component\PasswordHasher\Hasher\PasswordHasherFactoryInterface;
use Symfony\Contracts\Service\Attribute\Required;

class LoginHandler extends AbstractHandler
{
    private const TOKEN_BYTES_COUNT = 64;

    private LoginManager $manager;
    private PasswordHasherFactoryInterface $passwordHasher;
    private string $backOfficeTokenExpireTime;

    #[Required]
    public function dependencyInjection(
        LoginManager $manager,
        PasswordHasherFactoryInterface $passwordHasher,
        string $backOfficeTokenExpireTime,
    ): void {
        $this->manager = $manager;
        $this->passwordHasher = $passwordHasher;
        $this->backOfficeTokenExpireTime = $backOfficeTokenExpireTime;
    }

    /**
     * @throws AdminNotFoundException
     * @throws Exception
     * @throws InvalidPasswordException
     */
    public function handle(LoginEntryDto $entryDto): LoginResultDto
    {
        $adminDto = $this->manager->findAdminByEmail($entryDto->getEmail());

        if ($adminDto === null) {
            throw new AdminNotFoundException();
        }

        if (!$this->isPasswordValid($adminDto->password, $entryDto->getPassword())) {
            throw new InvalidPasswordException();
        }

        $token = $this->createAdminToken($adminDto->id);

        /** @var LoginResultDto $loginResultDto */
        $loginResultDto = $this->getApiDtoFactory()->createApiDto(LoginResultDto::class, ['token' => $token]);

        return $loginResultDto;
    }

    private function isPasswordValid(string $encodedPassword, string $plainPassword): bool
    {
        $passwordHasher = $this->passwordHasher->getPasswordHasher(BackOfficeAdmin::class);

        return $passwordHasher->verify($encodedPassword, $plainPassword);
    }

    /**
     * @throws Exception
     * @throws \Exception
     */
    private function createAdminToken(?string $adminId): string
    {
        $token = $this->tokenGenerator->generateToken(self::TOKEN_BYTES_COUNT);
        $expireDate = (new DateTime())->modify(sprintf('+%d minutes', $this->backOfficeTokenExpireTime));

        $this->manager->createToken($adminId, $token, $expireDate);

        return $token;
    }
}
