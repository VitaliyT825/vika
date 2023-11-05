<?php

declare(strict_types=1);

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity()
 * @ORM\Table()
 */
//#[ORM\Entity, ORM\Table()]
class Product extends AbstractEntity
{
    /**
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    protected $id;

    /**
     * @ORM\Column(type="string", nullable=false)
     */
    private string $productName;

    /**
     * @ORM\Column(type="string", nullable=false)
     */
    private string $info;

    public function getId()
    {
        return $this->id;
    }

    public function setId($id): void
    {
        $this->id = $id;
    }

    public function getName(): string
    {
        return $this->name;
    }

    public function setName(string $name): void
    {
        $this->name = $name;
    }

    public function getInfo(): string
    {
        return $this->info;
    }

    public function setInfo(string $info): void
    {
        $this->info = $info;
    }

//    public static function loadMetadata(ClassMetadata $metadata)
//    {
//        $builder = new ClassMetadataBuilder($metadata);
//        $builder->createField('id', 'integer')->isPrimaryKey()->generatedValue()->build();
//        $builder->addField('username', 'string');
//    }
}
