<?php

declare(strict_types=1);

namespace App\Enum;

use MarfaTech\Bundle\EnumerBundle\Enum\EnumInterface;

class DoctrineConnectionEnum implements EnumInterface
{
    public const DEFAULT = 'default';
    public const BIREPORT = 'bireport';
    public const ARAMUZ = 'aramuz';
    public const TEST = 'test';
}
