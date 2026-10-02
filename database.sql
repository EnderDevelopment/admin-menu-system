CREATE TABLE IF NOT EXISTS `admin_menu` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `player_id` int(11) NOT NULL,
    `command` varchar(255) NOT NULL,
    `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
);

INSERT INTO `admin_menu` (`player_id`, `command`) VALUES
(1, 'adminmenu');