<?php

declare(strict_types=1);

namespace App\Controller\AdminController;

use App\Exception\AdminAlreadyExistException;
use App\Exception\BackOfficeApiException;
use App\UseCase\Authentication\Register\RegisterAdminEntryDto;
use App\UseCase\Authentication\Register\RegisterAdminHandler;
use App\UseCase\Authentication\Register\RegisterAdminResultDto;
use Doctrine\DBAL\Exception;
use MarfaTech\Bundle\ApiPlatformBundle\HttpFoundation\ApiResponse;
use Nelmio\ApiDocBundle\Annotation\Model;
use OpenApi\Annotations as OA;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Throwable;

/**
 * @OA\Tag(name="Admin")
 *
 * @Route(name="create_admin", path="/register", methods={"POST"})
 *
 * @OA\RequestBody(
 *     description="body",
 *     required=true,
 *     @Model(type=RegisterAdminEntryDto::class)
 * )
 *
 * @OA\Response(
 *     response=Response::HTTP_OK,
 *     description="Ok",
 *     @Model(type=RegisterAdminResultDto::class)
 * )
 */
class CreateAdminController extends AbstractController
{
    /**
     * @throws AdminAlreadyExistException
     * @throws Exception
     */
    public function __invoke(RegisterAdminEntryDto $entryDto, RegisterAdminHandler $handler): Response
    {
        try {
            $resultDto = $handler->handle($entryDto);
        } catch (AdminAlreadyExistException) {
            throw new BackOfficeApiException(BackOfficeApiException::ADMIN_ALREADY_EXIST);
        } catch (Throwable $e) {
            throw $e;
        }

        return new ApiResponse($resultDto);
    }
}
