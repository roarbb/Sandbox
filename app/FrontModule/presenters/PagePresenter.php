<?php

namespace FrontModule;

class PagePresenter extends \BasePresenter
{
    /**
     * @var \General_moduleRepository
     */
    private $generalRepository;

    /**
     * @var \Nette\Database\Table\ActiveRow
     */
    private $page;

    public function injectDefault(\General_moduleRepository $generalRepository)
    {
        $this->generalRepository = $generalRepository;
    }

    public function actionDefault()
    {
        $this->page = $this->generalRepository->getModuleEditRow($this->params['tableName'], $this->params['pageId']);

        if($this->page === FALSE) {
            $this->setView('notFound');
        }
    }

    public function renderDefault()
    {
        $this->template->page = $this->page;
    }
}
