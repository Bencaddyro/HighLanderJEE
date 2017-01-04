SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';


-- -----------------------------------------------------
-- Table `HighlanderMonkey`.`Serveurs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HighlanderMonkey`.`Serveurs` ;

CREATE  TABLE IF NOT EXISTS `HighlanderMonkey`.`Serveurs` (
  `nom` VARCHAR(16) NOT NULL ,
  `type` ENUM('Routeur','Pare-Feux','Serveur') NOT NULL ,
  PRIMARY KEY (`nom`) ,
  UNIQUE INDEX `nom_UNIQUE` (`nom` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HighlanderMonkey`.`Pannes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HighlanderMonkey`.`Pannes` ;

CREATE  TABLE IF NOT EXISTS `HighlanderMonkey`.`Pannes` (
  `Serveurs_nom` VARCHAR(16) NOT NULL ,
  `Date` DATE NOT NULL ,
  `type` ENUM('Reseau','Disque','Memoire') NOT NULL ,
  `Status` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`Serveurs_nom`) ,
  INDEX `fk_Pannes_Serveurs` (`Serveurs_nom` ASC) ,
  CONSTRAINT `fk_Pannes_Serveurs`
    FOREIGN KEY (`Serveurs_nom` )
    REFERENCES `HighlanderMonkey`.`Serveurs` (`nom` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `HighlanderMonkey`;

DELIMITER $$

USE `HighlanderMonkey`$$
DROP TRIGGER IF EXISTS `HighlanderMonkey`.`verif_insertion` $$
USE `HighlanderMonkey`$$
CREATE TRIGGER verif_insertion BEFORE INSERT 
ON Pannes FOR EACH ROW
    BEGIN
        if((SElECT type FROM Serveurs WHERE nom=NEW.Serveurs_nom) != 'Serveur' ) then
            if(NEW.type != 'Reseau') then
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'mauvais type de panne';
            else
                INSERT iNTO Pannes VALUES(new.Serveurs_nom,new.type);
            end if;
        else
                INSERT iNTO Pannes VALUES(new.Serveurs_nom,new.type);
        end if;
    END

$$


DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
