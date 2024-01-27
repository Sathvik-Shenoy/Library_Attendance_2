## SQL for DBMS PROJECT : Attendance Management System 
## Done by : 1. B SATHVIK SHENOY  2. BHUVAN S  3. DHANYA VINAYAK HEGDE  4. NIHAL NOOJIBAIL 

#--- Creating a new database 
#--- Database name : attendance management system

#SET @@session.time_zone = '+05:30';

DROP DATABASE IF EXISTS `attendance_management_system`; # Deletes if there is any existing database with the same name. 
CREATE DATABASE `attendance_management_system`;
# Use the database.
USE `attendance_management_system`;
SET SQL_SAFE_UPDATES=0;
#-----------------------------------------------------------------------------
SET NAMES utf8;

# --- Creating table - "Library_card_index"
CREATE TABLE `Library_card_index` (
	`lib_id` varchar(10) UNIQUE NOT NULL,
	`college_id` VARCHAR(20),
	`faculty_id` CHAR(15) UNIQUE,
    `password` VARCHAR(256),
	PRIMARY KEY(`lib_id`)
);

# Creating table - "Students"
/*CREATE TABLE `Students` (
	`USN` VARCHAR(20) NOT NULL UNIQUE,
    `name` CHAR(40) NOT NULL,
    `Date_of_birth` DATE,
    `branch` VARCHAR(40) NOT NULL,
    `semester` INT NOT NULL,
    `email` VARCHAR(50) UNIQUE,
    `phone` BIGINT UNIQUE,
    `lib_id` INT UNIQUE,
    `type` CHAR(2) NOT NULL,
    PRIMARY KEY(`USN`),
    FOREIGN KEY(`lib_id`) REFERENCES Library_card_index(lib_id)
);*/
CREATE TABLE `Students` (
	`lib_id` varchar(10) UNIQUE NOT NULL,
    `name` CHAR(40) NOT NULL,
    `phone` BIGINT UNIQUE NOT NULL,
    `Em_Contact` VARCHAR(100) NOT NULL,
    `Blood` VARCHAR(5) NOT NULL,
    `address` VARCHAR(100) NOT NULL,
    `USN` VARCHAR(20),
    `Date_of_birth` DATE NOT NULL,
    `branch` VARCHAR(40) NOT NULL,
    `type` VARCHAR(50) NOT NULL,
    `photo` VARCHAR(512) NOT NULL,
    PRIMARY KEY(`lib_id`),
    FOREIGN KEY(`lib_id`) REFERENCES Library_card_index(lib_id)
);

#--- Creating Table : "Faculty"
CREATE TABLE `Faculty` (
	`faculty_id` char(6) NOT NULL UNIQUE,
    `name` CHAR(50) NOT NULL,
    `Date_of_joining` DATE NOT NULL,
    `branch` CHAR(50),
    `email` VARCHAR(40) NOT NULL UNIQUE,
    `phone` CHAR(10) UNIQUE,
    `lib_id` varchar(10) UNIQUE,
    `type` CHAR(50) NOT NULL,
    `Designation` CHAR(50) NOT NULL,
    PRIMARY KEY(`faculty_id`),
    FOREIGN KEY(`lib_id`) REFERENCES Library_card_index(`lib_id`)
);

#--- Creating table : "Outsiders"
CREATE TABLE `Outsider_student` (
	`lib_id` varchar(10) UNIQUE,
	`name` CHAR(40) NOT NULL,
    `phone` BIGINT NOT NULL UNIQUE,
    `college` CHAR(50) NOT NULL,
    `branch` CHAR(40),
    `semester` INT,
    `college_id` CHAR(15),
    PRIMARY KEY(`college_id`),
	FOREIGN KEY(`lib_id`) REFERENCES Library_card_index(`lib_id`)
);

#--- Creating table : "Outsider_faculty" - holds the record of outside visitors
CREATE TABLE `Outsider_faculty` (
	`lib_id` varchar(10) UNIQUE,
	`name` CHAR(40) NOT NULL,
    `phone` BIGINT NOT NULL UNIQUE,
    `college` CHAR(50) NOT NULL,
    `department` CHAR(40) NOT NULL,
    `designation` CHAR(40),
    `faculty_id` VARCHAR(15),
    PRIMARY KEY(`faculty_id`),
	FOREIGN KEY(`lib_id`) REFERENCES Library_card_index(`lib_id`)
);

#--- Creating table : "Library_ledger" => This will hold the record of visitors to the library.
/*CREATE TABLE `Library_ledger` (
	`lib_id` INT NOT NULL,
    `status` BOOLEAN DEFAULT TRUE,
    `entry` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `exit` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `elapsed_time` TIME,
    SUGGESTION VARCHAR(1000),
    PRIMARY KEY(`lib_id`, `entry`),
	FOREIGN KEY(`lib_id`) REFERENCES Library_card_index(`lib_id`)
);
CREATE TABLE `Library_ledger` (
	`lib_id` INT NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `branch` VARCHAR(50) NOT NULL,
    `status` BOOLEAN DEFAULT TRUE,
    `entry` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `exit` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `elapsed_time` TIME,
    SUGGESTION VARCHAR(1000),
    PRIMARY KEY(`lib_id`, `entry`),
	FOREIGN KEY(`lib_id`) REFERENCES Library_card_index(`lib_id`)
);*/
CREATE TABLE `Library_ledger` (
	`lib_id` varchar(10) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `branch` VARCHAR(50) NOT NULL,
    `status` BOOLEAN DEFAULT TRUE,
    `entry` TIMESTAMP,
    `exit` TIMESTAMP,
    `elapsed_time` TIME,
    SUGGESTION VARCHAR(1000),
    PRIMARY KEY(`lib_id`, `entry`),
	FOREIGN KEY(`lib_id`) REFERENCES Library_card_index(`lib_id`)
);

#--- Creating table : "Reference_section" => This will hold the record of visitors to the reference section.
/*CREATE TABLE `Reference_section` (
	`lib_id` INT NOT NULL,
    `status` BOOLEAN DEFAULT TRUE,
    `entry` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `exit` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `elapsed_time` TIME,
    SUGGESTION VARCHAR(1000), 
    PRIMARY KEY(`lib_id`, `entry`),
	FOREIGN KEY(`lib_id`) REFERENCES Library_card_index(`lib_id`)
);*/

CREATE TABLE `Reference_section` (
	`lib_id` varchar(10) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `branch` VARCHAR(50) NOT NULL,
    `status` BOOLEAN DEFAULT TRUE,
    `entry` TIMESTAMP,
    `exit` TIMESTAMP,
    `elapsed_time` TIME,
    SUGGESTION VARCHAR(1000),
    PRIMARY KEY(`lib_id`, `entry`),
	FOREIGN KEY(`lib_id`) REFERENCES Library_card_index(`lib_id`)
);

/*DELIMITER //
CREATE PROCEDURE attendance_management_system.exit_library(id INT)
	LANGUAGE SQL 
	MODIFIES SQL DATA 
    BEGIN
		SET SQL_SAFE_UPDATES=0;
		SET @lib_id = id;
		SELECT CAST(current_timestamp() AS DATETIME) INTO @exit_time;
        SELECT CAST((SELECT `entry` FROM `Library_ledger` WHERE lib_id=@lib_id AND `status`=1) AS DATETIME) INTO @entry_time;
		-- SET @entry_time = (SELECT `entry` FROM `Library_ledger` WHERE lib_id= @lib_id AND `status`=1);
        SELECT CAST(TIMEDIFF(@exit_time, @entry_time) AS TIME) INTO @elapsed_time;
        UPDATE Library_ledger SET `exit`=@exit_time WHERE lib_id=@lib_id AND `exit`=@entry_time;
		UPDATE Library_ledger SET `elapsed_time`=@elapsed_time WHERE `exit`=@exit_time;
        UPDATE Library_ledger SET `status`= false WHERE `lib_id`= @lib_id AND `status`=true;  # Updates the exit time. 
	END	
    // 
DELIMITER ;*/

DELIMITER //
CREATE PROCEDURE attendance_management_system.exit_library(id VARCHAR(10))
    LANGUAGE SQL 
    MODIFIES SQL DATA 
BEGIN
    SET SQL_SAFE_UPDATES=0;
    SET @lib_id = id;
    SELECT CAST(current_timestamp() AS DATETIME) INTO @exit_time;
    SELECT CAST((SELECT `entry` FROM `Library_ledger` WHERE lib_id=@lib_id AND `status`=1) AS DATETIME) INTO @entry_time;
    SELECT CAST(TIMEDIFF(@exit_time, @entry_time) AS TIME) INTO @elapsed_time;
    UPDATE Library_ledger SET `exit`=@exit_time WHERE lib_id=@lib_id AND `exit`=@entry_time;
    UPDATE Library_ledger SET `elapsed_time`=@elapsed_time WHERE `exit`=@exit_time;
    UPDATE Library_ledger SET `status`= false WHERE `lib_id`= @lib_id AND `status`=true;
END
//
DELIMITER ;


/*DELIMITER //
CREATE PROCEDURE attendance_management_system.exit_reference(id INT)
	LANGUAGE SQL 
	MODIFIES SQL DATA 
    BEGIN
		SET SQL_SAFE_UPDATES=0;
		SET @lib_id = id;
		SELECT CAST(current_timestamp() AS DATETIME) INTO @exit_time;
        SELECT CAST((SELECT `entry` FROM `Reference_section` WHERE lib_id=@lib_id AND `status`=1) AS DATETIME) INTO @entry_time;
		-- SET @entry_time = (SELECT `entry` FROM `Library_ledger` WHERE lib_id= @lib_id AND `status`=1);
        SELECT CAST(TIMEDIFF(@exit_time, @entry_time) AS TIME) INTO @elapsed_time;
        UPDATE Reference_section SET `exit`=@exit_time WHERE lib_id=@lib_id AND `exit`=@entry_time;
		UPDATE Reference_section SET `elapsed_time`=@elapsed_time WHERE `exit`=@exit_time;
        UPDATE Reference_section SET `status`= false WHERE `lib_id`= @lib_id AND `status`=true;  # Updates the exit time. 
	END	
    // 
DELIMITER ;*/

DELIMITER //
CREATE PROCEDURE attendance_management_system.exit_reference(id VARCHAR(10))
	LANGUAGE SQL 
	MODIFIES SQL DATA 
    BEGIN
		SET SQL_SAFE_UPDATES=0;
		SET @lib_id = id;
		SELECT CAST(current_timestamp() AS DATETIME) INTO @exit_time;
        SELECT CAST((SELECT `entry` FROM `Reference_section` WHERE lib_id=@lib_id AND `status`=1) AS DATETIME) INTO @entry_time;
		-- SET @entry_time = (SELECT `entry` FROM `Library_ledger` WHERE lib_id= @lib_id AND `status`=1);
        SELECT CAST(TIMEDIFF(@exit_time, @entry_time) AS TIME) INTO @elapsed_time;
        UPDATE Reference_section SET `exit`=@exit_time WHERE lib_id=@lib_id AND `exit`=@entry_time;
		UPDATE Reference_section SET `elapsed_time`=@elapsed_time WHERE `exit`=@exit_time;
        UPDATE Reference_section SET `status`= false WHERE `lib_id`= @lib_id AND `status`=true;  # Updates the exit time. 
	END	
    // 
DELIMITER ;

#--- Event - Executes everyday at 5:30pm and changes the state of all entries to 0.
CREATE EVENT exit_library_event
  ON SCHEDULE
    EVERY 1 DAY
    STARTS '2021-06-20 17:30:00' ON COMPLETION PRESERVE ENABLE 
  DO
    UPDATE `Library_ledger` SET `status`=0 WHERE `status`=1;

#--- Event - Executes everyday at 8:00pm and changes the state of all entries to 0.
CREATE EVENT exit_reference_section_event
  ON SCHEDULE
    EVERY 1 DAY
    STARTS '2021-06-20 20:00:00' ON COMPLETION PRESERVE ENABLE 
  DO
    UPDATE `Library_ledger` SET `status`=0 WHERE `status`=1;

SELECT * FROM `Library_card_index`;
SELECT * FROM LIBRARY_LEDGER;
SELECT * FROM OUTSIDER_STUDENT; 
SELECT * FROM FACULTY;

-- DELIMITER //
-- CREATE PROCEDURE attendance_management_system.exit_library(id INT)
-- 	LANGUAGE SQL 
-- 	MODIFIES SQL DATA 
--     BEGIN
-- 		SET SQL_SAFE_UPDATES=0;
-- 		SET @lib_id = id;
-- 		SELECT CAST(current_timestamp() AS DATETIME) INTO @exit_time;
--         SELECT CAST((SELECT `entry` FROM `Library_ledger` WHERE lib_id=@lib_id AND `status`=1) AS DATETIME) INTO @entry_time;
-- 		-- SET @entry_time = (SELECT `entry` FROM `Library_ledger` WHERE lib_id= @lib_id AND `status`=1);
--         SELECT CAST(TIMEDIFF(@exit_time, @entry_time) AS TIME) INTO @elapsed_time;
--         UPDATE Library_ledger SET `exit`=@exit_time WHERE lib_id=@lib_id AND `exit`=@entry_time;
-- 		UPDATE Library_ledger SET `elapsed_time`=@elapsed_time WHERE `exit`=@exit_time;
--         UPDATE Library_ledger SET `status`= false WHERE `lib_id`= @lib_id AND `status`=true;  # Updates the exit time. 
-- 	END	
--     // 
-- DELIMITER ;

-- DELIMITER //
-- CREATE PROCEDURE attendance_management_system.exit_reference()
-- 	LANGUAGE SQL 
-- 	MODIFIES SQL DATA 
--     BEGIN
-- 		UPDATE Reference_section SET `status`= false WHERE `lib_id`= @lib_id;  # Updates the exit time. 
-- 		SET @entry_time = (SELECT `entry` FROM `Reference_section` WHERE lib_id= @lib_id);
--         SET @exit_time = (SELECT `exit` FROM `Reference_section` WHERE lib_id= @lib_id);
--         SET @elapsed_time = (SELECT TIMEDIFF(@exit_time, @entry_time));
-- 		UPDATE Reference_section SET `elapsed_time`=@elapsed_time WHERE `lib_id`= @lib_id;
-- 	END	
--     // 
-- DELIMITER ;

-- CALL exit_reference();









