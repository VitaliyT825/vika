<?php

declare(strict_types=1);

namespace App\Controller;

use MarfaTech\Bundle\ApiPlatformBundle\HttpFoundation\ApiResponse;
use OpenApi\Annotations as OA;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @OA\Tag(name="Banner")
 *
 * @Route(name="backofficeapi_info", path="/banner", methods={"POST"})
 *
 * @OA\Response(
 *     response=ApiResponse::HTTP_CREATED,
 *     description="created",
 * )
 */
class HelloWorldController
{
    public function __invoke(): ApiResponse
    {
        return new ApiResponse();
    }
}
