<?php

declare(strict_types=1);

namespace App\Command;

use MyBuilder\Bundle\CronosBundle\Annotation\Cron;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

/**
 * @Cron(minute="/2")
 */
class CircleCommand extends Command
{
    protected function configure(): void
    {
        $this
            ->setName('add:new:product')
            ->setDescription('fill my new table by cron')
        ;
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        return Command::SUCCESS;
    }
}
