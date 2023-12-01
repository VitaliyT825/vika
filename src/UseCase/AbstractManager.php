<?php

declare(strict_types=1);

namespace App\UseCase;

use Doctrine\ORM\EntityManagerInterface;

abstract class AbstractManager
{
    public function __construct(protected readonly EntityManagerInterface $entityManager)
    {
    }
}
