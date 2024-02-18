<?php

declare(strict_types=1);

namespace App\Controller\UserController;

use App\Exception\BackOfficeApiException;
use App\Exception\InvalidPasswordException;
use App\UseCase\Authentication\Login\LoginEntryDto;
use App\UseCase\Authentication\Login\LoginHandler;
use App\UseCase\Authentication\Login\LoginResultDto;
use MarfaTech\Bundle\ApiPlatformBundle\Exception\ApiException;
use MarfaTech\Bundle\ApiPlatformBundle\HttpFoundation\ApiResponse;
use Nelmio\ApiDocBundle\Annotation\Model;
use OpenApi\Annotations as OA;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use Throwable;

class LoginController extends AbstractController
{
    /**
     * @Route(name="user_login", path="/login", methods={"POST"})
     *
     * @OA\RequestBody(
     *     description="request body",
     *     required=true,
     *     @Model(type=LoginEntryDto::class)
     * )
     *
     * @OA\Response(
     *     response=ApiResponse::HTTP_OK,
     *     description="Ok",
     *     @Model(type=LoginResultDto::class)
     * )
     */
    public function index(LoginEntryDto $entryDto, LoginHandler $handler): ApiResponse
    {
        try {
            $resultDto = $handler->handle($entryDto);
        } catch (InvalidPasswordException) {
            throw new BackOfficeApiException(BackOfficeApiException::PASSWORD_INCORRECT);
        } catch (Throwable $exception) {
            throw new ApiException(ApiException::HTTP_BAD_REQUEST_DATA, $exception->getMessage());
        }

        return new ApiResponse($resultDto);
    }
}
