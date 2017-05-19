ALTER TABLE `PREFIX_mishacomments_comment`
ADD `firstname` VARCHAR(255) NOT NULL AFTER `id_product`,
ADD `lastname` VARCHAR(255) NOT NULL AFTER `firstname`,
ADD `email` VARCHAR(255) NOT NULL AFTER `lastname`;