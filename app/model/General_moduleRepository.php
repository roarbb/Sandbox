<?php

class General_moduleRepository extends Repository {

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

    /**
     * @param $table
     * @param $rowId
     * @return \Nette\Database\Table\ActiveRow
     */
    public function getModuleEditRow($table, $rowId) {
        return $this->connection->table($table)->get($rowId);
    }

    public function updateModuleEditRow($table, $rowId, $data) {
        return $this->connection->table($table)->get($rowId)->update($data);
    }

    public function createRow($table, $data)
    {
        return $this->connection->table($table)->insert($data);
    }

    public function deleteRowFromModule($id, $table)
    {
        $this->connection->table($table)->get($id)->delete();
    }
}