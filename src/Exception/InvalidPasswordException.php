<?php

declare(strict_types=1);

namespace App\Exception;

use Exception;
use Throwable;

class InvalidPasswordException extends Exception
{
    private const MESSAGE = 'invalid password';

    public function __construct($message = '', $code = 0, ?Throwable $previous = null)
    {
        parent::__construct(
            $message === '' ? self::MESSAGE : sprintf('%s: %s', self::MESSAGE, $message),
            $code,
            $previous
        );
    }
}
