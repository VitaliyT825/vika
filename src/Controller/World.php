<?php

declare(strict_types=1);

namespace App\Controller;

use Doctrine\DBAL\Connection;
use OpenApi\Annotations as OA;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @OA\Tag(name="World")
 *
 * @Route(name="backofficeapi_banner_info", path="/banner", methods={"GET"})
 *
 * @OA\Response(
 *     response=Response::HTTP_OK,
 *     description="Ok",
 * )
 */
class World extends AbstractController
{
    public function __invoke(): Response
    {
        $number = random_int(2, 100);

        return new Response('<html><body>Lucky number: ' . $number . '</body></html>');
    }
}
