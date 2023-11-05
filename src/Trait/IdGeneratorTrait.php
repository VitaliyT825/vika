<?php

declare(strict_types=1);

namespace App\Trait;

use Cassandra\Uuid;
use Doctrine\ORM\Mapping as ORM;

trait IdGeneratorTrait
{
    /**
     * @ORM\Id
     * @ORM\Column(type="bigint", nullable=false, options={"unsigned"=true})
     * @ORM\GeneratedValue(strategy="CUSTOM")
     * @ORM\CustomIdGenerator(class: 'doctrine.uuid_generator')
     */
    protected $id = null;

    public function getId(): ?Uuid
    {
        return $this->id;
    }

    /**
     * @param Uuid $id
     * @return self
     */
    public function setId(Uuid $id): self
    {
        $this->id = $id;

        return $this;
    }

    public function __clone()
    {
        $this->id = null;
    }
}
