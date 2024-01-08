<?php

declare(strict_types=1);

namespace App\UseCase\Authentication\Logout;

use App\UseCase\AbstractManager;
use DateTime;

class LogoutManager extends AbstractManager
{
    public function disableToken(string $token): void
    {
        $this->entityManager->getConnection()->update(
            'BackOfficeToken',
            [
                'expiredAt' => (new DateTime())->format('Y-m-d H:i:s')
            ],
            [
                'token' => $token
            ]
        );
    }
}
