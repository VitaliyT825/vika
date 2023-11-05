<?php

namespace App\Skills\Infrastructure\Repository;

use App\Skills\Domain\Entity\Specialist\SkillConfirmation;
use App\Skills\Domain\Repository\SkillConfirmationRepositoryInterface;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

class SkillConfirmationRepository extends ServiceEntityRepository implements SkillConfirmationRepositoryInterface
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, SkillConfirmation::class);
    }

    public function findBySpecialist(string $skillId, string $specialistId): ?SkillConfirmation
    {
        return $this->findOneBy(['skillId' => $skillId, 'specialistId' => $specialistId]);
    }

    public function add(?SkillConfirmation $skillConfirmation): void
    {
        $this->getEntityManager()->persist($skillConfirmation);
        $this->getEntityManager()->flush();
    }
}
