<?php

declare(strict_types=1);

namespace App\Exception;

use Exception;
use Throwable;

class AdminAlreadyExistException extends Exception
{
    private const MESSAGE = 'Admin email already exist';

    public function __construct($message = '', $code = 0, ?Throwable $previous = null)
    {
        parent::__construct(
            $message === '' ? self::MESSAGE : sprintf('%s: %s', self::MESSAGE, $message),
            $code,
            $previous
        );
    }
}
