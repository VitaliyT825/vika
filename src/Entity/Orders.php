<?php

declare(strict_types=1);

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use Gedmo\Timestampable\Traits\TimestampableEntity;
use MarfaTech\Component\OrmIdGenerator\Entity\IdAwareEntityTrait;

/**
 * @ORM\Table()
 * @ORM\Entity()
 */
class Orders
{
    use IdAwareEntityTrait;
    use TimestampableEntity;

    /**
     * @ORM\Column(type="string", nullable=false)
     */
    private string $clientId;

    /**
     * @ORM\Column(type="string", nullable=false, length=180)
     */
    private string $email;

    /**
     * @ORM\Column(type="string", nullable=true, length=180)
     */
    private string $address;

    /**
     * @ORM\Column(type="string", nullable=true, length=180)
     */
    private string $name;

    public function getClientId(): string
    {
        return $this->clientId;
    }

    public function setClientId(string $clientId): void
    {
        $this->clientId = $clientId;
    }

    public function getEmail(): string
    {
        return $this->email;
    }

    public function setEmail(string $email): void
    {
        $this->email = $email;
    }

    public function getAddress(): string
    {
        return $this->address;
    }

    public function setAddress(string $address): void
    {
        $this->address = $address;
    }

    public function getName(): string
    {
        return $this->name;
    }

    public function setName(string $name): void
    {
        $this->name = $name;
    }
}
