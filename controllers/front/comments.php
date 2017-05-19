<?php

class MishaCommentsCommentsModuleFrontController extends ModuleFrontController
{
    public $product;

    public function initContent()
    {
        parent::initContent();

        $id_product = (int)Tools::getValue('id_product');
        $this->product = new Product((int)$id_product, false, $this->context->cookie->id_lang);
        $module_action = Tools::getValue('module_action');
        $actions_list = array('list' => $this->initList());

        if ($id_product > 0 && isset($actions_list[$module_action])) {
            $actions_list[$module_action];
        }
    }

    public function initList()
    {
        $num_of_comments = Db::getInstance()->getValue('
            SELECT COUNT(`id_product`)
            FROM `' . _DB_PREFIX_ . 'mishacomments_comment`
            WHERE `id_product` = ' . (int)$this->product->id);

        $comments_per_page = 10;
        $num_of_pages = ceil($num_of_comments / $comments_per_page);
        $page = 1;
        if (Tools::getValue('page') >    1) {
            $page = Tools::getValue('page');
        }

        $limit_start = ($page - 1) * $comments_per_page;

        $comments = Db::getInstance()->executeS('
            SELECT * FROM `' . _DB_PREFIX_ . 'mishacomments_comment`
            WHERE `id_product` = ' . (int)$this->product->id . '
            ORDER BY `date_add` DESC
            LIMIT ' . (int)$limit_start . ',' . (int)$comments_per_page);

        $this->context->smarty->assign(array(
            'comments' => $comments,
            'product' => $this->product,
            'page' => $page,
            'num_of_pages' => $num_of_pages
        ));

        $this->setTemplate('list.tpl');
    }

    public function setMedia()
    {
        parent::setMedia();

        $this->path = dirname(__FILE__) . '/../../';

        $this->context->controller->addCSS($this->path . 'views/css/bootstrap.min.css', 'all');
        $this->context->controller->addCSS($this->path . 'views/css/mishacomments.css', 'all');
        $this->context->controller->addCSS($this->path . 'views/css/star-rating.css', 'all');
        $this->context->controller->addJS($this->path . 'views/js/star-rating.js');
        $this->context->controller->addJS($this->path . 'views/js/mishacomments.js');
    }
}