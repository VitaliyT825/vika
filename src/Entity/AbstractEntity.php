<?php

declare(strict_types=1);

namespace App\Entity;

use App\Trait\IdGeneratorTrait;
use Gedmo\Timestampable\Traits\TimestampableEntity;

abstract class AbstractEntity
{
//    use IdGeneratorTrait;
    use TimestampableEntity;
}
