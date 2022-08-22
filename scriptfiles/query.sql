CREATE TABLE IF NOT EXISTS `players`(
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(24) NOT NULL,
    `pass` VARCHAR(64) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    `ip` VARCHAR(16) NOT NULL,
    `admin` INT DEFAULT 0,
    `skin` INT DEFAULT 0,
    `interior` INT DEFAULT 0,
    `vw` INT DEFAULT 0,
    `health` FLOAT DEFAULT 0,
    `armour` FLOAT DEFAULT 0,
    `posx` DOUBLE DEFAULT 0,
    `posy` DOUBLE DEFAULT 0,
    `posz` DOUBLE DEFAULT 0,
    `angle` DOUBLE DEFAULT 0
);