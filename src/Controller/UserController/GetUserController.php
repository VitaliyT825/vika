<?php

declare(strict_types=1);

namespace App\Controller\UserController;

use App\UseCase\Authentication\Profile\GetProfileResultDto;
use App\UseCase\Authentication\Profile\ProfileHandler;
use MarfaTech\Bundle\ApiPlatformBundle\HttpFoundation\ApiResponse;
use Nelmio\ApiDocBundle\Annotation\Model;
use OpenApi\Annotations as OA;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;

class GetUserController extends AbstractController
{
    /**
     * @Route(name="profile_info", path="/profile", methods={"GET"})
     *
     * @OA\Response(
     *     response=ApiResponse::HTTP_OK,
     *     description="Ok",
     *     @Model(type=GetProfileResultDto::class),
     * )
     */
    public function index(ProfileHandler $handler): ApiResponse
    {
        $resultDto = $handler->handle();

        return new ApiResponse($resultDto);
    }
}
