SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `Highlander Monkey` ;
CREATE SCHEMA IF NOT EXISTS `Highlander Monkey` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `Highlander Monkey` ;

-- -----------------------------------------------------
-- Table `Highlander Monkey`.`Serveurs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Highlander Monkey`.`Serveurs` ;

CREATE  TABLE IF NOT EXISTS `Highlander Monkey`.`Serveurs` (
  `nom` VARCHAR(16) NOT NULL ,
  `type` ENUM('Routeur','Pare-Feux','Serveur') NOT NULL ,
  PRIMARY KEY (`nom`) ,
  UNIQUE INDEX `nom_UNIQUE` (`nom` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Highlander Monkey`.`Pannes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Highlander Monkey`.`Pannes` ;

CREATE  TABLE IF NOT EXISTS `Highlander Monkey`.`Pannes` (
  `Serveurs_nom` VARCHAR(16) NOT NULL ,
  `Date` DATE NOT NULL ,
  `type` ENUM('Reseau','Disque','Memoire') NOT NULL ,
  `Status` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`Serveurs_nom`) ,
  INDEX `fk_Pannes_Serveurs` (`Serveurs_nom` ASC) ,
  CONSTRAINT `fk_Pannes_Serveurs`
    FOREIGN KEY (`Serveurs_nom` )
    REFERENCES `Highlander Monkey`.`Serveurs` (`nom` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `Highlander Monkey`;

DELIMITER $$

USE `Highlander Monkey`$$
DROP TRIGGER IF EXISTS `Highlander Monkey`.`verif_insertion` $$
USE `Highlander Monkey`$$
CREATE TRIGGER verif_insertion BEFORE INSERT 
ON Pannes FOR EACH ROW
    BEGIN
        if((SElECT type FROM Serveurs WHERE nom=NEW.Serveurs_nom) != 'Serveur' ) then
            if(NEW.type != 'Reseau') then
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'mauvais type de panne';
            else
                INSERT iNTO Pannes VALUES(new.Serveur_nom,new.type);
            end if;
        else
                INSERT iNTO Pannes VALUES(new.Serveur_nom,new.type);
        end if;
    END

$$


DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
