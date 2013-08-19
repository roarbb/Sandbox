<?php

class Alt_google_linksRepository extends Repository
{

    public function getBySlug($slug)
    {
        $where = array('link_google_uri' => $slug);
        return $this->findBy($where)->fetch();
    }
}