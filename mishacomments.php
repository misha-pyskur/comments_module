<?php

class MishaComments extends ModuleCore
{
    public function __construct()
    {
        $this->name = 'mishacomments';
        $this->tab = 'front_office_features';
        $this->version = '0.1';
        $this->author = 'Misha Pyskur';
        $this->ps_versions_compliancy = array('min' => '1.6', 'max' => _PS_VERSION_);
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = 'Misha Comments Module';
        $this->description = 'Best comments module ever made';
    }

    public function install()
    {
        $sql_file = dirname(__FILE__).'/install/install.sql';

        if (!parent::install() ||
            !$this->registerHook('displayProductTabContent') ||
            !$this->registerHook('displayBackOfficeHeader') ||
            !$this->registerHook('ModuleRoutes') ||
            !$this->loadSQLFile($sql_file)
        ) {
            return false;
        }

        Configuration::updateValue('MISHACOMMENTS_GRADES', '1');
        Configuration::updateValue('MISHACOMMENTS_COMMENTS', '1');

        return true;
    }

    public function uninstall()
    {
        $sql_file = dirname(__FILE__).'/install/uninstall.sql';

        if (!parent::uninstall() ||
            !$this->loadSQLFile($sql_file)
        ) {
            return false;
        }

        Configuration::deleteByName('MISHACOMMENTS_GRADES');
        Configuration::deleteByName('MISHACOMMENTS_COMMENTS');

        return true;
    }

    public function loadSQLFile($sql_file)
    {
        $sql_content = file_get_contents($sql_file);
        $sql_content = str_replace('PREFIX_', _DB_PREFIX_, $sql_content);
        $sql_requests = preg_split('/;\s*[\r\n]+/', $sql_content);

        $result = true;
        foreach ($sql_requests as $request) {
            if (!empty($request)) {
                $result &= Db::getInstance()->execute(trim($request));
            }
        }

        return $result;
    }

    public function processConfiguration()
    {
        if (Tools::isSubmit('mishacomments_conf_form')) {
            $enable_grades = Tools::getValue('enable_grades');
            $enable_comments = Tools::getValue('enable_comments');
            Configuration::updateValue('MISHACOMMENTS_GRADES', $enable_grades);
            Configuration::updateValue('MISHACOMMENTS_COMMENTS', $enable_comments);
            $this->context->smarty->assign('confirmation', 'ok');
        }
    }

    public function assignConfiguration()
    {
        $enable_grades = Configuration::get('MISHACOMMENTS_GRADES');
        $enable_comments = Configuration::get('MISHACOMMENTS_COMMENTS');
        $this->context->smarty->assign('enable_grades', $enable_grades);
        $this->context->smarty->assign('enable_comments', $enable_comments);
    }

    public function getContent()
    {
        $this->processConfiguration();
        $this->assignConfiguration();
        return $this->display(__FILE__, 'getContent.tpl');
    }

    public function processProductTabContent()
    {
        if (Tools::isSubmit('mishacomments_comment_submit')) {
            $id_product = Tools::getValue('id_product');
            $firstname = Tools::getValue('firstname');
            $lastname = Tools::getValue('lastname');
            $email = Tools::getValue('email');
            $grade = Tools::getValue('grade');
            $comment = Tools::getValue('comment');
            $comments_to_insert = array(
                'id_product' => (int)$id_product,
                'firstname' => pSQL($firstname),
                'lastname' => pSQL($lastname),
                'email' => pSQL($email),
                'grade' => (int)$grade,
                'comment' => pSQL($comment),
                'date_add' => date('Y-m-d H:i:s'),
            );

            Db::getInstance()->insert('mishacomments_comment', $comments_to_insert);
            $this->context->smarty->assign('new_comment_posted', 'true');
        }
    }

    public function assignProductTabContent()
    {
        $enable_grades = Configuration::get('MISHACOMMENTS_GRADES');
        $enable_comments = Configuration::get('MISHACOMMENTS_COMMENTS');

        $id_product = Tools::getValue('id_product');
        $product = new Product((int)$id_product, false, $this->context->cookie->id_lang);

        $retrieve_comments_query = 'SELECT * FROM ' . _DB_PREFIX_ . 'mishacomments_comment 
                                    WHERE `id_product`=' . (int)$id_product
                                    . ' ORDER BY `date_add` DESC LIMIT 3';
        $comments = Db::getInstance()->executeS($retrieve_comments_query);

        $this->context->controller->addCSS($this->_path.'views/css/bootstrap.min.css', 'all');
        $this->context->controller->addCSS($this->_path.'views/css/mishacomments.css', 'all');
        $this->context->controller->addCSS($this->_path.'views/css/star-rating.css', 'all');
        $this->context->controller->addJS($this->_path.'views/js/star-rating.js');
        $this->context->controller->addJS($this->_path.'views/js/mishacomments.js');

        $this->context->smarty->assign(array(
           'enable_grades' => $enable_grades,
            'enable_comments' => $enable_comments,
            'comments' => $comments,
            'product' => $product
        ));
    }

    public function hookDisplayProductTabContent($params)
    {
        $this->processProductTabContent();
        $this->assignProductTabContent();
        return $this->display(__FILE__, 'displayProductTabContent.tpl');
    }

    public function hookDisplayBackOfficeHeader($params)
    {
        if (Tools::getValue('controller') !== 'AdminModules') {
            return '';
        }

        return $this->display(__FILE__, 'displayBackOfficeHeader.tpl');
    }

    public function hookModuleRoutes()
    {
        return array(
            'module-mishacomments-comments' => array(
                'controller' => 'comments',
                'rule' => 'product-comments{/:module_action}{/:product_rewrite}{/:id_product}/page{/:page}',
                'keywords' => array(
                    'id_product' => array('regexp' => '[\d]+', 'param' => 'id_product'),
                    'product_rewrite' => array('regexp' => '[\w-_]+', 'param' => 'product_rewrite'),
                    'page' => array('regexp' => '[\d]+', 'param' => 'page'),
                    'module_action' => array('regexp' => '[\w]+', 'param' => 'module_action'),
                ),
                'params' => array(
                    'fc' => 'module',
                    'module' => 'mishacomments'
                )
            ),
        );
    }
}