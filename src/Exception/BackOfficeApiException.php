<?php

declare(strict_types=1);

namespace App\Exception;

use MarfaTech\Bundle\ApiPlatformBundle\Exception\ApiException;

class BackOfficeApiException extends ApiException
{
    public const ADMIN_ALREADY_EXIST = 1001;
    public const PASSWORD_INCORRECT = 1002;
}
