SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `HighlanderMonkey` ;
CREATE SCHEMA IF NOT EXISTS `HighlanderMonkey` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `HighlanderMonkey` ;

-- -----------------------------------------------------
-- Table `HighlanderMonkey`.`Machines`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HighlanderMonkey`.`Machines` ;

CREATE  TABLE IF NOT EXISTS `HighlanderMonkey`.`Machines` (
  `Nom` VARCHAR(16) NOT NULL ,
  `Type_Machine` ENUM('Routeur','Pare-Feux','Serveur') NOT NULL ,
  PRIMARY KEY (`Nom`) ,
  UNIQUE INDEX `nom_UNIQUE` (`Nom` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HighlanderMonkey`.`Pannes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HighlanderMonkey`.`Pannes` ;

CREATE  TABLE IF NOT EXISTS `HighlanderMonkey`.`Pannes` (
  `Machines_Nom` VARCHAR(16) NOT NULL ,
  `Date` DATETIME NOT NULL ,
  `Type` ENUM('Reseau','Disque','Memoire') NOT NULL ,
  `Status` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`Machines_Nom`, `Date`, `Type`) ,
  INDEX `fk_Pannes_Machines` (`Machines_Nom` ASC) ,
  CONSTRAINT `fk_Pannes_Machines`
    FOREIGN KEY (`Machines_Nom` )
    REFERENCES `HighlanderMonkey`.`Machines` (`Nom` )
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
        if((SElECT Type_Machine FROM Machines WHERE Nom=NEW.Machines_Nom) != 'Serveur' ) then
            if(NEW.Type != 'Reseau') then
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'mauvais type de panne';
            end if;
        end if;
    END;$$


DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO Machines VALUES('E546F2159AC987B1','Serveur');
INSERT INTO Machines VALUES('A123CB65DE874F1A','Serveur');
INSERT INTO Machines VALUES('D45AF6987C154D87','Serveur');
INSERT INTO Machines VALUES('A1546FC32DEA157C','Serveur');
INSERT INTO Machines VALUES('D45AE12CF548A12C','Serveur');

INSERT INTO Machines VALUES('546F2159AC987B12','Serveur');
INSERT INTO Machines VALUES('A123CB65DE874F14','Serveur');
INSERT INTO Machines VALUES('D45AF6687C154D87','Serveur');
INSERT INTO Machines VALUES('A1546FC42DEA157C','Serveur');
INSERT INTO Machines VALUES('D45AE14CF548A12C','Serveur');
INSERT INTO Machines VALUES('169A12BC4548DF45','Pare-Feux');
INSERT INTO Machines VALUES('A1254CFE456987A1','Pare-Feux');

INSERT INTO Machines VALUES('169A12BCE548DF45','Pare-Feux');
INSERT INTO Machines VALUES('A1254CFE656987A1','Pare-Feux');

INSERT INTO Machines VALUES('169A12BC8548DF45','Pare-Feux');
INSERT INTO Machines VALUES('A12544FEA56987A1','Pare-Feux');
INSERT INTO Machines VALUES('96AC145F4698E154','Routeur');
INSERT INTO Machines VALUES('A14B25C64F4789A1','Routeur');
INSERT INTO Machines VALUES('41023ABE678549A1','Routeur');
INSERT INTO Machines VALUES('1457823A5C457126','Routeur');

INSERT INTO Machines VALUES('96AC145F5698E154','Routeur');
INSERT INTO Machines VALUES('A14B25C77F4789A1','Routeur');
INSERT INTO Machines VALUES('41023ABE678549A1','Routeur');
INSERT INTO Machines VALUES('1457823A+C457126','Routeur');

