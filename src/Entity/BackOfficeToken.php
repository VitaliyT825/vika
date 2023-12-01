<?php

declare(strict_types=1);

namespace App\Entity;

use DateTime;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity()
 * @ORM\Table(uniqueConstraints={
 *    @ORM\UniqueConstraint(columns={"token"}, name="unxToken")
 * })
 */
class BackOfficeToken extends AbstractEntity
{
    /**
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private int $id;

    /**
     * @ORM\ManyToOne(targetEntity="BackOfficeAdmin")
     * @ORM\JoinColumn(name="backOfficeAdminId", referencedColumnName="id")
     */
    private BackOfficeAdmin $backOfficeAdmin;

    /**
     * @ORM\Column(type="string", nullable=false)
     */
    private string $token;

    /**
     * @ORM\Column(type="datetime", nullable=false)
     */
    private DateTime $expiredAt;

    public function getId(): int
    {
        return $this->id;
    }

    public function setId(int $id): void
    {
        $this->id = $id;
    }

    public function getBackOfficeAdmin(): BackOfficeAdmin
    {
        return $this->backOfficeAdmin;
    }

    public function setBackOfficeAdmin(BackOfficeAdmin $backOfficeAdmin): void
    {
        $this->backOfficeAdmin = $backOfficeAdmin;
    }

    public function getToken(): string
    {
        return $this->token;
    }

    public function setToken(string $token): void
    {
        $this->token = $token;
    }

    public function getExpiredAt(): DateTime
    {
        return $this->expiredAt;
    }

    public function setExpiredAt(DateTime $expiredAt): void
    {
        $this->expiredAt = $expiredAt;
    }
}
