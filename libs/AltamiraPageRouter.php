<?php
use Nette\Application\Request;
use Nette\Http\Url;

/**
 * User: Matej
 * Date: 19.8.2013
 * Time: 13:25
 */

class AltamiraPageRouter implements \Nette\Application\IRouter
{
    /**
     * @var Alt_google_linksRepository
     */
    private $googleLinksRepository;

    public function __construct(Alt_google_linksRepository $googleLinksRepository)
    {
        $this->googleLinksRepository = $googleLinksRepository;
    }

    /**
     * Ak najdem zaznam v Databaze podla SLUGu,
     * naplnim parametre do HTTPrequestu a ososlem.
     *
     * Ak nenajdem zaznam, vratim NULL a router pokracuje dalej v routovani podla bootstrapu
     *
     * @param \Nette\Http\IRequest $httpRequest
     * @return \Nette\Application\Request|NULL|void
     */
    function match(Nette\Http\IRequest $httpRequest)
    {
        $slug = $httpRequest->getUrl()->getPathInfo();
        $row = $this->googleLinksRepository->getBySlug($slug);

        if (!$row) return NULL;

        $presenter = 'Page';
        $params = $httpRequest->getQuery();
        $params['action'] = 'default';
        $params['slug'] = $slug;
        $params['pageId'] = $row->link_table_id;
        $params['tableName'] = $row->link_table_name;

        return new Request(
            $presenter,
            $httpRequest->getMethod(),
            $params,
            $httpRequest->getPost(),
            $httpRequest->getFiles(),
            array(Request::SECURED => $httpRequest->isSecured())
        );
    }

    /**
     * Constructs absolute URL from Request object.
     *
     * @param \Nette\Application\Request $appRequest
     * @param \Nette\Http\Url $refUrl
     * @return NULL|string|void
     */
    function constructUrl(\Nette\Application\Request $appRequest, Nette\Http\Url $refUrl)
    {
        $params = $appRequest->getParameters();
        $slug = isset($params['slug']) ? $params['slug'] : NULL;
        $action = isset($params['action']) ? $params['action'] : NULL;
        if ($action !== 'default' || !is_string($slug)) return NULL;

        $url = new Url($refUrl->getBaseUrl() . $slug);
//        $url->setQuery($params);
        return $url->getAbsoluteUrl();
    }
}