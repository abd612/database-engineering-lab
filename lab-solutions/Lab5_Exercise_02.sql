CREATE SCHEMA `Gym_data`;
CREATE TABLE `Gym_data`.`Gym`
(
	`GymName` VARCHAR(30) NOT NULL,
    `Owner` VARCHAR(30) NOT NULL,
    `Street` VARCHAR(30) NOT NULL,
    PRIMARY KEY(`GymName`));
    
CREATE TABLE `Gym_data`.`Frequent`
(
	`CustomerName` VARCHAR(30) NOT NULL,
    `GymName` VARCHAR(30) NOT NULL,
    PRIMARY KEY(`CustomerName`));
    
CREATE TABLE `Gym_data`.`Customer`
(
	`CustomerName` VARCHAR(30) NOT NULL,
    `Street` VARCHAR(30) NOT NULL,
    `Age` VARCHAR(30) NOT NULL,
    PRIMARY KEY(`CustomerName`));


INSERT INTO `gym_data`.`gym` (`GymName`, `Owner`, `Street`) VALUES ('UET', 'UET', '1st');
INSERT INTO `gym_data`.`gym` (`GymName`, `Owner`, `Street`) VALUES ('LUMS', 'LUMS', '2nd');
INSERT INTO `gym_data`.`gym` (`GymName`, `Owner`, `Street`) VALUES ('KSK', 'KSK', '3rd');

INSERT INTO `gym_data`.`customer` (`CustomerName`, `Street`, `Age`) VALUES ('Usman', '1st', '21');
INSERT INTO `gym_data`.`customer` (`CustomerName`, `Street`, `Age`) VALUES ('Umer', '2nd', '20');
INSERT INTO `gym_data`.`customer` (`CustomerName`, `Street`, `Age`) VALUES ('Ussama', '3rd', '22');

INSERT INTO `gym_data`.`frequent` (`CustomerName`, `GymName`) VALUES ('Usman', 'UET');
INSERT INTO `gym_data`.`frequent` (`CustomerName`, `GymName`) VALUES ('Umer', 'KSK');
INSERT INTO `gym_data`.`frequent` (`CustomerName`, `GymName`) VALUES ('Ussama', 'LUMS');

SELECT * FROM gym_data.frequent WHERE `CustomerName` = 'Usman' ; 


SELECT  customer.CustomerName FROM customer,frequent,gym WHERE gym.Street=customer.Street and customer.CustomerName=frequent.CustomerName and gym.GymName=frequent.GymName;