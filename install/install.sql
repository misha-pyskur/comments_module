CREATE TABLE IF NOT EXISTS `PREFIX_mishacomments_comment` (
    `id_mishacomments_comment` int(11) NOT NULL AUTO_INCREMENT,
    `id_product` int(11) NOT NULL,
    `grade` tinyint(1) NOT NULL,
    `comment` text NOT NULL,
    `date_add` datetime NOT NULL,
    PRIMARY KEY (`id_mishacomments_comment`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;