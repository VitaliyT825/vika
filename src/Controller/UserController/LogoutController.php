<?php

declare(strict_types=1);

namespace App\Controller\UserController;

use App\UseCase\Authentication\Logout\LogoutHandler;
use MarfaTech\Bundle\ApiPlatformBundle\HttpFoundation\ApiResponse;
use OpenApi\Annotations as OA;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;

class LogoutController extends AbstractController
{
    /**
     * @Route(name="user_logout", path="/logout", methods={"POST"})
     *
     * @OA\Response(
     *     response=ApiResponse::HTTP_OK,
     *     description="Ok",
     * )
     */
    public function index(LogoutHandler $handler): ApiResponse
    {
       $handler->handle();

       return new ApiResponse();
    }
}
