-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema todo_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema todo_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `todo_db` DEFAULT CHARACTER SET utf8 ;
USE `todo_db` ;

-- -----------------------------------------------------
-- Table `todo_db`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `todo_db`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(32) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `access_token` VARCHAR(1024) NULL,
  `refresh_token` VARCHAR(1024) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `todo_db`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `todo_db`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `users_id` INT NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_category_users_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_category_users`
    FOREIGN KEY (`users_id`)
    REFERENCES `todo_db`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `todo_db`.`task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `todo_db`.`task` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `duedate` TIMESTAMP NULL,
  `note` VARCHAR(255) NULL,
  `category_id` INT NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isCompleted` TINYINT NOT NULL DEFAULT 0,
  `isFavourited` TINYINT NOT NULL DEFAULT 0,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`, `category_id`, `user_id`),
  INDEX `fk_tasks_category1_idx` (`category_id` ASC) VISIBLE,
  INDEX `fk_task_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_tasks_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `todo_db`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_task_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `todo_db`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
