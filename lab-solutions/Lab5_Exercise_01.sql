CREATE SCHEMA `university` ;
CREATE TABLE `university`.`campus`
 (
  `CampusID` INT NOT NULL,
  `CampusName` VARCHAR(30) NOT NULL,
  `CampusAddress` VARCHAR(50) NOT NULL,
  `Country` VARCHAR(20) NOT NULL,
  `City` VARCHAR(20) NOT NULL,
  `IsOpen` BIT(1) NOT NULL,
  PRIMARY KEY (`CampusID`));
  
  CREATE TABLE `university`.`building` (
  `BuildingID` INT NOT NULL,
  `BuildingName` VARCHAR(30) NULL,
  `Address` VARCHAR(30) NULL,
  PRIMARY KEY (`BuildingID`));
  
ALTER TABLE `university`.`building` 
ADD COLUMN `CampusID` INT NULL AFTER `Address`;
  
ALTER TABLE `university`.`building` 
ADD INDEX `CampusID_idx` (`CampusID` ASC);
ALTER TABLE `university`.`building` 
ADD CONSTRAINT `CampusID`
FOREIGN KEY (`CampusID`)
REFERENCES `university`.`campus` (`CampusID`)
ON DELETE SET NULL
ON UPDATE CASCADE;


INSERT INTO `university`.`campus` (`CampusID`, `CampusName`, `CampusAddress`, `Country`, `City`, `IsOpen`) VALUES ('1', 'EE', 'Lahore', 'Pakistan', 'Lahore', 1);
INSERT INTO `university`.`campus` (`CampusID`, `CampusName`, `CampusAddress`, `Country`, `City`, `IsOpen`) VALUES ('2', 'CE', 'Lahore', 'Pakistan', 'Lahore', 1);
INSERT INTO `university`.`campus` (`CampusID`, `CampusName`, `CampusAddress`, `Country`, `City`, `IsOpen`) VALUES ('3', 'CS', 'Lahore', 'Pakistan', 'Lahore', 1);
INSERT INTO `university`.`campus` (`CampusID`, `CampusName`, `CampusAddress`, `Country`, `City`, `IsOpen`) VALUES ('4', 'EE', 'KSK', 'Pakistan', 'KSK', 1);
INSERT INTO `university`.`campus` (`CampusID`, `CampusName`, `CampusAddress`, `Country`, `City`, `IsOpen`) VALUES ('5', 'EE', 'Rachna', 'Pakistan', 'Rachna', 1);

INSERT INTO `university`.`building` (`BuildingID`, `BuildingName`, `Address`, `CampusID`) VALUES ('1', 'Main Block', 'Lahore', '1');
INSERT INTO `university`.`building` (`BuildingID`, `BuildingName`, `Address`, `CampusID`) VALUES ('2', 'Main Block', 'Lahore', '2');
INSERT INTO `university`.`building` (`BuildingID`, `BuildingName`, `Address`, `CampusID`) VALUES ('3', 'Annexe', 'Lahore', '3');
INSERT INTO `university`.`building` (`BuildingID`, `BuildingName`, `Address`, `CampusID`) VALUES ('4', 'Annexe', 'Lahore', '2');
INSERT INTO `university`.`building` (`BuildingID`, `BuildingName`, `Address`, `CampusID`) VALUES ('5', 'SSC', 'Lahore', '4');

SELECT * FROM university.building;
SELECT * FROM university.campus ;

ALTER TABLE `university`.`campus` 
CHANGE COLUMN `CampusName` `MyCampus` VARCHAR(30) NOT NULL ;
