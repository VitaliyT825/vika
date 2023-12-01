<?php

declare(strict_types=1);

namespace App\Guesser;

use MarfaTech\Bundle\ApiPlatformBundle\Guesser\ApiAreaGuesserInterface;
use Symfony\Component\HttpFoundation\Request;

use function end;
use function preg_match;

class ApiAreaGuesser implements ApiAreaGuesserInterface
{
    /**
     * {@inheritDoc}
     */
    public function getApiVersion(Request $request): ?int
    {
        $apiVersionMatch = [];
        preg_match('/^\/v([\d]+)\//i', $request->getPathInfo(), $apiVersionMatch);

        if (empty($apiVersionMatch)) {
            return null;
        }

        return (int) end($apiVersionMatch);
    }

    /**
     * {@inheritDoc}
     */
    public function isApiRequest(Request $request): bool
    {
        return preg_match('#^(/api/|/backofficeapi/)#', $request->getPathInfo()) === 1;
    }
}
