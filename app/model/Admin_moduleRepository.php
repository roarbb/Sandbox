<?php

use \Nette\Utils\Strings;

class Admin_moduleRepository extends Repository {

    public function getModule($id) {
        return $this->getTable()->get($id);
    }

    public function getFields($table) {

        if(empty($table) || is_null($table)) { return false; }

        $fields = $this->connection->query('SHOW FULL FIELDS FROM ' . $table)->fetchAll();

        return $fields;
    }

    public function getReplacementArray($row) {
        $data = $this->connection->table($row->replacement_table)->select($row->replacement_id_column . ',' . $row->replacement_name_column)->order($row->replacement_name_column);
        $replaceArray = array('' => '');

        foreach ($data as $item) {
            $replaceArray[$item[$row->replacement_id_column]] = $item[$row->replacement_name_column];
        }

        return $replaceArray;
    }

    public function getTables() {
        return $this->connection->query('SHOW FULL TABLES')->fetchAll();
    }

    public function getModuleId($tableName) {
        return $this->connection->table('admin_module')->where('table', $tableName)->fetch();
    }

    public function insertNewModule($tableName) {
        $data = array(
            'name' => $tableName,
            'table' => $tableName,
        );

        $row = $this->connection->table("admin_module")->insert($data);
        return $row["id"];
    }

    public function insertModuleField($data) {
        try {
            $this->connection->table('admin_module_column')->insert($data);
        } catch(PDOException $e) {
            $this->connection->table("admin_module_column")
                ->where("admin_module_id", $data['admin_module_id'])
                ->where("name", $data['name'])
                ->fetch()->update($data);
        }
    }

    public function getModuleFields($moduleId) {
        return $this->connection->table('admin_module_column')->where('admin_module_id', $moduleId)->fetchPairs('name');
    }

    public function getModuleEditRow($table, $rowId) {
        return $this->connection->table($table)->get($rowId);
    }

    public function updateModuleEditRow($table, $rowId, $data) {
        return $this->connection->table($table)->get($rowId)->update($data);
    }

    public function deleteModule($moduleId) {
        $this->connection->table("admin_module")->get($moduleId)->delete();
    }

    public function deleteModuleRow($moduleId, $rowId) {

    }
}