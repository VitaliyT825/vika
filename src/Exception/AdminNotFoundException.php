<?php

declare(strict_types=1);

namespace App\Exception;

use Exception;
use Throwable;

class AdminNotFoundException extends Exception
{
    private const MESSAGE = 'Admin not found';

    public function __construct($message = '', $code = 0, ?Throwable $previous = null)
    {
        parent::__construct(
            $message === '' ? self::MESSAGE : sprintf('%s: %s', self::MESSAGE, $message),
            $code,
            $previous
        );
    }
}
