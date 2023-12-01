<?php

declare(strict_types=1);

namespace App\Services;

use Exception;

class TokenGeneratorService
{
    /**
     * @param int $bytesCount
     *
     * @return string
     *
     * @throws Exception
     */
    public function generateToken(int $bytesCount): string
    {
        return bin2hex(random_bytes($bytesCount));
    }
}
