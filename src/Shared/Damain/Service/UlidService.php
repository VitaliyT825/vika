<?php

declare(strict_types=1);

namespace App\Shared\Damain\Service;

use Symfony\Component\Uid\Ulid;

/**
 * Universally Unique Lexicographically Sortable Identifier
 *
 * @link https://github.com/ulid/spec
 */
class UlidService
{
    public static function generate(): string{
        return Ulid::generate();
    }
}