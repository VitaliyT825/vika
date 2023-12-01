<?php

declare(strict_types=1);

namespace App\UseCase\Authentication\Register;

use App\Entity\BackOfficeAdmin;
use App\Exception\AdminAlreadyExistException;
use App\UseCase\AbstractHandler;
use DateTime;
use Doctrine\DBAL\Exception as DbalException;
use Exception;
use Symfony\Contracts\Service\Attribute\Required;

class RegisterAdminHandler extends AbstractHandler
{
    private const TOKEN_BYTES_COUNT = 64;

    private RegisterAdminManager $manager;
    private string $backOfficeTokenExpireTime;

    #[Required]
    public function dependencyInjection(
        RegisterAdminManager $manager,
        string $backOfficeTokenExpireTime,
    ): void {
        $this->manager = $manager;
        $this->backOfficeTokenExpireTime = $backOfficeTokenExpireTime;
    }

    /**
     * @throws DbalException
     * @throws AdminAlreadyExistException
     * @throws Exception
     */
    public function handle(RegisterAdminEntryDto $entryDto): RegisterAdminResultDto
    {
        $adminId = $this->manager->findAdminByEmail($entryDto->getEmail());

        if ($adminId !== null) {
            throw new AdminAlreadyExistException();
        }

        $adminId = $this->createAdmin($entryDto);
        $token = $this->createAdminToken($adminId);

        return $this->getApiDtoFactory()->createApiDto(RegisterAdminResultDto::class, [
            'token' => $token
        ]);
    }

    /**
     * @throws DbalException
     */
    private function createAdmin(RegisterAdminEntryDto $entryDto): ?string
    {
        $hashedPassword = $this->makeEncodedPassword($entryDto->getPassword());

        return $this->manager->createAdmin($entryDto, $hashedPassword);
    }

    private function makeEncodedPassword(string $plainPassword): string
    {
        $backOfficeAdmin = new BackOfficeAdmin();

        return $this->encoder->getPasswordHasher($backOfficeAdmin)->hash($plainPassword);
    }

    /**
     * @throws Exception
     */
    private function createAdminToken(?string $adminId): string
    {
        $token = $this->tokenGenerator->generateToken(self::TOKEN_BYTES_COUNT);
        $expireDate = (new DateTime())->modify(sprintf('+%d minutes', $this->backOfficeTokenExpireTime));

        $this->manager->createToken($adminId, $token, $expireDate);

        return $token;
    }
}
