<?php

declare(strict_types=1);

namespace App\Dto;

use MarfaTech\Bundle\ApiPlatformBundle\Dto\ApiResultDto;
use MarfaTech\Component\DtoResolver\Dto\DtoResolverInterface;
use stdClass;
use Swagger\Annotations as SWG;

/**
 * @SWG\Schema(
 *     type="object",
 *     description="Common API response object template",
 *     required={"code", "message"},
 * )
 */
class ApiDocResultDto extends ApiResultDto
{
    /**
     * @var int
     *
     * @SWG\Property(description="Response api code", example=0, default=0)
     */
    protected $code = 0;

    /**
     * @var string
     *
     * @SWG\Property(description="Localized human readable text", example="Successfully")
     */
    protected $message;

    /**
     * @var DtoResolverInterface|null
     *
     * @SWG\Property(type="object", description="Some specific response data or null")
     */
    protected $data = null;

    /**
     * {@inheritDoc}
     */
    public function toArray(bool $onlyDefinedData = true): array
    {
        $result = parent::toArray($onlyDefinedData);

        if (empty($result['data'])) {
            $result['data'] = new stdClass();
        }

        return $result;
    }
}
