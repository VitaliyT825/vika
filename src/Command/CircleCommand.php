<?php

declare(strict_types=1);

namespace App\Command;

use App\Entity\Product;
use DateTime;
use Doctrine\ORM\EntityManagerInterface;
use Exception;
use MyBuilder\Bundle\CronosBundle\Annotation\Cron;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Contracts\Service\Attribute\Required;

/**
 * @Cron(minute="/30")
 */
class CircleCommand extends Command
{
    private EntityManagerInterface $entityManager;

    protected function configure(): void
    {
        $this
            ->setName('add:new:product')
            ->setDescription('fill my new table by cron')
        ;
    }

    #[Required]
    public function dependencyInjection(
        EntityManagerInterface $entityManager,
    ): void {
        $this->entityManager = $entityManager;
    }


    /**
     * @throws Exception
     */
    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $product = new Product();
        $now = new DateTime();

        $product->setProductName('new field: ' . random_int(2, 100));
        $product->setInfo('now is: ' . $now->format('H:i:s'));
        $product->setCreatedAt($now);
        $product->setUpdatedAt($now);

        $this->entityManager->persist($product);
        $this->entityManager->flush();

        return Command::SUCCESS;
    }
}
