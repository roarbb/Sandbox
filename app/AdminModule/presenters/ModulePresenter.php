<?php

namespace AdminModule;

use AdminModule\Forms\DefaultEditForm;
use AdminModule\Forms\EditModuleRowForm;
use AdminModule\Forms\InsertEditModuleForm;
use DependentSelectBox\DependentSelectBox;
use Grido\Components\Actions\Action;
use Grido\Components\Columns\Column;
use Grido\Components\Columns\Date;
use Grido\Components\Filters\Filter;
use Grido\Grid;
use Nette\Database\Connection;

final class ModulePresenter extends BasePresenter {

    /**
     * @var \Admin_moduleRepository
     */
    protected $admin_moduleRepository;

    /**
     * @var Connection
     */
    protected $connection;

    public function inject(\Admin_moduleRepository $admin_moduleRepository, Connection $connection){
        $this->admin_moduleRepository = $admin_moduleRepository;
        $this->connection = $connection;
    }


    public function startup() {
        parent::startup();
        DependentSelectBox::register('addDSelect');
    }

    function renderDefault() {
        $this->redirect(':admin:module:list', 1);
    }

    protected function createComponentGrid($name) {

        $moduleId = $this->params['id'];
//        dump($moduleId);
//        exit;

        $module = $this->admin_moduleRepository->getModule($moduleId);

        $table = $module->table;
        $fields = $this->admin_moduleRepository->getFields($table);
        $showFields = $module->related('admin_module_column')->order('admin_module_column.id')->where('viewable',"1");


        $grid = new Grid($this, $name);
        $grid->setModel($this->connection->table($table));

        foreach ($showFields as $columnRow) {
            $columnDbInfo = $this->search($fields, $columnRow->name);
            if($columnDbInfo['Comment'] != "") {
                $columnName = str_replace('[*]', '', $columnDbInfo['Comment']);
            } else {
                $columnName = $columnRow->name;
            }

            //najprv skontrolujem obdobu Joinovania
            if($columnRow->replacement_table) {
                $replacementArray = $this->admin_moduleRepository->getReplacementArray($columnRow);
                $grid->addColumn($columnRow->name, $columnName)->setReplacement($replacementArray);
                $grid->addFilter($columnRow->name, $columnName, Filter::TYPE_SELECT, $replacementArray);
                continue;
            }

            if($columnDbInfo['Type'] == 'text') { 
                $grid->addColumn($columnRow->name, $columnName)->setTruncate(80); 
                $grid->addFilter($columnRow->name, $columnName);
                continue; 
            }

            if( preg_match('/int\(.*?\)/', $columnDbInfo['Type'])) { 
                $grid->addColumn($columnRow->name, $columnName)->setSortable();
                $grid->addFilter($columnRow->name, $columnName, Filter::TYPE_NUMBER);
                continue; 
            }

            if( preg_match('/enum\((.*?)\)/', $columnDbInfo['Type'])) {

                //ziskam moznosti ktore su uvedene v zatvorke enum('1','0')
                preg_match('/\((.*?)\)/', $columnDbInfo['Type'], $matches);
                $options = explode(',', $matches[1]);
                $out = array(''=>'');

                //spavim si z moznosti pole pre selectbox
                foreach ($options as $option) {
                    $option = str_replace("'", '', $option);
                    $out[$option] = (string)$option;
                }

                $grid->addColumn($columnRow->name, $columnName)->setReplacement($out);
                $grid->addFilter($columnRow->name, $columnName, Filter::TYPE_SELECT, $out);
                continue; 
            }

            if( preg_match('/datetime/', $columnDbInfo['Type'])) { 
                //pripojim do grida bunku, datetime sa bude chovat ako date
                $grid->addColumn($columnRow->name, $columnName, Column::TYPE_DATE)->setSortable()->setDateFormat(Date::FORMAT_DATE);

                //meno bunky si zapisem, aby som ho mohol pouziv v callbacku
                $columnRowName = $columnRow->name;

                //custom podmienka pre filter
                $grid->addFilter($columnRow->name, $columnName, Filter::TYPE_DATE)
                    ->setCondition(Filter::CONDITION_CALLBACK, function($value) use($columnRowName) {

                        //custom podmienka pre datetime
                        $out = array();
                        $out[0] = '['.$columnRowName.'] =%s';
                        $out[1] = date('Y-m-d',strtotime($value));

                        return $out;
                });

                continue; 
            }

            $grid->addColumn($columnRow->name, $columnName);
            $grid->addFilter($columnRow->name, $columnName);
            
        }

        if ($moduleId == 1) {
            $grid->addAction('edit', 'Upraviť', Action::TYPE_HREF, ":admin:module:edit", array('moduleid' => $moduleId))
                ->setIcon('pencil');
            $grid->addAction('delete', 'Vymazať', Action::TYPE_HREF, ":admin:module:delete", array('moduleid' => $moduleId))
                ->setIcon('trash')
                ->setConfirm('Naozaj chcete vymazať tento modul?');
        } else {
            $grid->addAction('editrow', 'Upraviť', Action::TYPE_HREF, ":admin:module:rowedit", array('moduleid' => $moduleId))
                ->setIcon('pencil');
            $grid->addAction('deleterow', 'Vymazať', Action::TYPE_HREF, ":admin:module:rowdelete", array('moduleid' => $moduleId))
                ->setIcon('trash')
                ->setConfirm('Naozaj chcete vymazať tento záznam?');
        }
        
        $grid->setExporting($table);
    }

    private function search($fields, $fieldname) {
        foreach ($fields as $field) {
            if($field['Field'] == $fieldname) {
                return $field;
            }
        }
    }

    public function renderEdit($moduleid,$id) {}

    public function renderRowedit($moduleid,$id) {}

    public function renderList($id) {} //danger! grido filters don't work w/out this

    public function renderDelete($moduleid,$id) {
        $this->admin_moduleRepository->deleteModule($id);
        $this->presenter->flashMessage('Modul vymazaný', 'success');
        $this->presenter->redirect(':admin:module:list', 1);
    }

    public function renderRowDelete($moduleid,$id) {
        dump("Mazem riadok cislo " . $id . " z modulu cislo " . $moduleid);
        $this->flashMessage('Dáta úspešne zmazané', 'success');
        $this->redirect(':admin:module:list', $moduleid);
    }

    public function renderNew() {
        $this->template->tables = $this->admin_moduleRepository->getTables();
    }

    protected function createComponentDefaultEditForm($name) {
        return new DefaultEditForm($this, $name);
    }

    public function renderSet($id) {
        $this->template->fields = $this->admin_moduleRepository->getFields($id);
    }

    protected function createComponentInsertEditModuleForm($name) {
        return new InsertEditModuleForm($this, $name);
    }

    protected function createComponentEditModuleRowForm($name) {
        return new EditModuleRowForm($this, $name);
    }
}