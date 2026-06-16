-- CREATE TABLE employees(
--     employee_id INT AUTO_INCREMENT PRIMARY KEY,
--     full_name VARCHAR(100) NOT NULL,
--     email VARCHAR(100) NOT NULL UNIQUE,
--     department VARCHAR(100),
--     gender ENUM('male', 'female') NOT NULL,
--     CHECK (email LIKE '%@%' AND email LIKE '%.com')
-- );
-- CREATE TABLE devices (
--     device_id INT AUTO_INCREMENT PRIMARY KEY,
--     device_name VARCHAR(100) NOT NULL,
--     modules Set('RFID', 'PIN', 'Fingerprint') NOT NULL,
--     location VARCHAR(100) NOT NULL
-- );


-- CREATE TABLE auth_method (
--     method_id INT AUTO_INCREMENT PRIMARY KEY,
--     method_name enum('RFID', 'PIN', 'Fingerprint') NOT NULL
--     );
-- CREATE TABLE salary (
--     salary_id INT AUTO_INCREMENT PRIMARY KEY,
--     employee_id INT NOT NULL,
--     gross_salary INT NOT NULL,
--     days_worked INT DEFAULT 0,
--     pay_month DATE NOT NULL,
--     net_salary  INT GENERATED ALWAYS AS ( 
--         ROUND(gross_salary * (days_worked / 26), 2)) STORED,
--     FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
-- );

-- ALTER TABLE salary
-- ADD CONSTRAINT chk_net CHECK (net_salary > 0);

-- CREATE TABLE Attendance (
--     attendance_id INT AUTO_INCREMENT PRIMARY KEY,
--     employee_id INT NOT NULL,
--     device_id INT NOT NULL,
--     method_id INT,
--     attendance_date DATE NOT NULL DEFAULT (CURRENT_DATE),
--     check_in TIME DEFAULT NULL,
--     check_out TIME DEFAULT NULL,
--     FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
--     FOREIGN KEY (device_id) REFERENCES devices(device_id),
--     FOREIGN KEY (method_id) REFERENCES auth_method(method_id)
-- );
-- ALTER TABLE attendance
-- DROP FOREIGN KEY attendance_ibfk_3;
-- ALTER TABLE attendance
-- ADD CONSTRAINT attendance_ibfk_3
-- FOREIGN KEY (method_id) REFERENCES auth_method(method_id)
-- ON DELETE SET NULL
-- ON UPDATE CASCADE;

-- ALTER TABLE attendance
-- ADD CONSTRAINT chk_time CHECK (check_out > check_in);


-- create table login (
-- user_id int auto_increment Primary Key,
-- user_name varchar(100) unique,
-- password varchar(100)
-- );



-- DELIMITER $$
-- CREATE TRIGGER update_days_worked_after_insert
-- AFTER INSERT ON Attendance
-- FOR EACH ROW
-- BEGIN
--     DECLARE total_days INT;

--     Count only the days where both check_in and check_out are present
--     SELECT COUNT(*) INTO total_days
--     FROM Attendance
--     WHERE employee_id = NEW.employee_id
--       AND MONTH(attendance_date) = MONTH(NEW.attendance_date)
--       AND YEAR(attendance_date) = YEAR(NEW.attendance_date)
--       AND check_in IS NOT NULL
--       AND check_out IS NOT NULL;

--     -- Update days_worked in salary table for the same month
--     UPDATE salary
--     SET days_worked = total_days
--      WHERE employee_id = NEW.employee_id
--        AND MONTH(pay_month) = MONTH(NEW.attendance_date)
--        AND YEAR(pay_month) = YEAR(NEW.attendance_date);
--  END$$
--  DELIMITER ;

--  * FROM netslolace.employees;
-- INSERT INTO employees (full_name, email, department, gender)
-- VALUES 
-- ('Ali', 'ali@gmail.com', 'Programmer', 'male'),
-- ('Akbar', 'akbar@gmail.com', 'Project manager', 'male'),
-- ('Ayesha', 'shahid@gmail.com', 'Developer', 'female'),
-- ('Ijaz', 'ijaz@gmail.com', 'ML engineer', 'male'),
-- ('Shahid', 'shakir@gmail.com', 'Security', 'male');



-- INSERT INTO devices (device_id, device_name, modules, location)
-- VALUES
-- (101, 'AccessControlDevice', 'RFID', 'Main Gate'),
-- (102, 'AccessControlDevice', 'PIN', 'Hallway'),
-- (103, 'AccessControlDevice', 'Fingerprint', 'Server Room');
-- SELECT * FROM netslolace.devices;

-- INSERT INTO auth_method (method_name)
-- VALUES
-- ('RFID'),
-- ('PIN'),
-- ('Fingerprint');
-- SELECT * FROM netslolace.auth_method;

-- INSERT INTO attendance (employee_id, device_id, method_id, full_name, method_name, attendance_date, check_in, check_out) VALUES
-- -- Day 1
-- (1,101,1,'Ali','RFID','2025-11-01','09:00:00','17:00:00'),
-- (2,102,2,'Akbar','PIN','2025-11-01',NULL,NULL),
-- (3,103,3,'Shahid','Fingerprint','2025-11-01','09:15:00','17:05:00'),
-- (4,101,1,'Ijaz','RFID','2025-11-01',NULL,NULL),
-- (5,102,2,'Shakir','PIN','2025-11-01','09:00:00','17:00:00'),

-- -- Day 2
-- (1,102,2,'Ali','PIN','2025-11-02','09:00:00','17:00:00'),
-- (2,101,1,'Akbar','RFID','2025-11-02','09:10:00','17:10:00'),
-- (3,102,2,'Shahid','PIN','2025-11-02',NULL,NULL),
-- (4,103,3,'Ijaz','Fingerprint','2025-11-02','09:00:00','17:00:00'),
-- (5,101,1,'Shakir','RFID','2025-11-02',NULL,NULL),

-- -- Day 3
-- (1,103,3,'Ali','Fingerprint','2025-11-03','09:00:00','17:00:00'),
-- (2,101,1,'Akbar','RFID','2025-11-03',NULL,NULL),
-- (3,101,1,'Shahid','RFID','2025-11-03','09:20:00','17:15:00'),
-- (4,102,2,'Ijaz','PIN','2025-11-03','09:00:00','17:00:00'),
-- (5,103,3,'Shakir','Fingerprint','2025-11-03','09:05:00','17:02:00'),

-- -- Day 4
-- (1,101,1,'Ali','RFID','2025-11-04','09:00:00','17:00:00'),
-- (2,103,3,'Akbar','Fingerprint','2025-11-04','09:12:00','17:03:00'),
-- (3,102,2,'Shahid','PIN','2025-11-04',NULL,NULL),
-- (4,102,2,'Ijaz','PIN','2025-11-04','09:00:00','17:00:00'),
-- (5,101,1,'Shakir','RFID','2025-11-04',NULL,NULL),

-- -- Day 5
-- (1,102,2,'Ali','PIN','2025-11-05','09:00:00','17:00:00'),
-- (2,101,1,'Akbar','RFID','2025-11-05','09:20:00','17:12:00'),
-- (3,103,3,'Shahid','Fingerprint','2025-11-05','09:00:00','17:00:00'),
-- (4,101,1,'Ijaz','RFID','2025-11-05',NULL,NULL),
-- (5,103,3,'Shakir','Fingerprint','2025-11-05','09:03:00','17:00:00'),

-- -- Day 6
-- (1,101,1,'Ali','RFID','2025-11-06','09:00:00','17:00:00'),
-- (2,102,2,'Akbar','PIN','2025-11-06','09:10:00','17:15:00'),
-- (3,101,1,'Shahid','RFID','2025-11-06',NULL,NULL),
-- (4,103,3,'Ijaz','Fingerprint','2025-11-06','09:00:00','17:00:00'),
-- (5,102,2,'Shakir','PIN','2025-11-06','09:00:00','17:00:00'),

-- -- Day 7
-- (1,102,2,'Ali','PIN','2025-11-07','09:00:00','17:00:00'),
-- (2,101,1,'Akbar','RFID','2025-11-07',NULL,NULL),
-- (3,103,3,'Shahid','Fingerprint','2025-11-07','09:05:00','17:05:00'),
-- (4,101,1,'Ijaz','RFID','2025-11-07','09:00:00','17:00:00'),
-- (5,103,3,'Shakir','Fingerprint','2025-11-07',NULL,NULL),

-- -- Day 8
-- (1,103,3,'Ali','Fingerprint','2025-11-08','09:00:00','17:00:00'),
-- (2,102,2,'Akbar','PIN','2025-11-08','09:15:00','17:10:00'),
-- (3,101,1,'Shahid','RFID','2025-11-08',NULL,NULL),
-- (4,103,3,'Ijaz','Fingerprint','2025-11-08','09:00:00','17:00:00'),
-- (5,101,1,'Shakir','RFID','2025-11-08','09:00:00','17:00:00'),

-- -- Day 9
-- (1,101,1,'Ali','RFID','2025-11-09','09:00:00','17:00:00'),
-- (2,103,3,'Akbar','Fingerprint','2025-11-09','09:18:00','17:12:00'),
-- (3,102,2,'Shahid','PIN','2025-11-09','09:00:00','17:00:00'),
-- (4,102,2,'Ijaz','PIN','2025-11-09',NULL,NULL),
-- (5,101,1,'Shakir','RFID','2025-11-09',NULL,NULL),

-- -- Day 10
-- (1,102,2,'Ali','PIN','2025-11-10','09:00:00','17:00:00'),
-- (2,101,1,'Akbar','RFID','2025-11-10',NULL,NULL),
-- (3,103,3,'Shahid','Fingerprint','2025-11-10','09:03:00','17:00:00'),
-- (4,101,1,'Ijaz','RFID','2025-11-10','09:00:00','17:00:00'),
-- (5,103,3,'Shakir','Fingerprint','2025-11-10','09:04:00','17:01:00'),

-- -- Day 11
-- (1,101,1,'Ali','RFID','2025-11-11','09:00:00','17:00:00'),
-- (2,103,3,'Akbar','Fingerprint','2025-11-11','09:08:00','17:00:00'),
-- (3,102,2,'Shahid','PIN','2025-11-11',NULL,NULL),
-- (4,102,2,'Ijaz','PIN','2025-11-11','09:00:00','17:00:00'),
-- (5,101,1,'Shakir','RFID','2025-11-11',NULL,NULL),

-- -- Day 12
-- (1,103,3,'Ali','Fingerprint','2025-11-12','09:00:00','17:00:00'),
-- (2,102,2,'Akbar','PIN','2025-11-12','09:20:00','17:15:00'),
-- (3,101,1,'Shahid','RFID','2025-11-12','09:00:00','17:00:00'),
-- (4,103,3,'Ijaz','Fingerprint','2025-11-12',NULL,NULL),
-- (5,102,2,'Shakir','PIN','2025-11-12','09:00:00','17:00:00'),

-- -- Day 13
-- (1,101,1,'Ali','RFID','2025-11-13','09:00:00','17:00:00'),
-- (2,102,2,'Akbar','PIN','2025-11-13',NULL,NULL),
-- (3,103,3,'Shahid','Fingerprint','2025-11-13','09:00:00','17:00:00'),
-- (4,101,1,'Ijaz','RFID','2025-11-13','09:00:00','17:00:00'),
-- (5,103,3,'Shakir','Fingerprint','2025-11-13',NULL,NULL),

-- -- Day 14
-- (1,102,2,'Ali','PIN','2025-11-14','09:00:00','17:00:00'),
-- (2,103,3,'Akbar','Fingerprint','2025-11-14','09:12:00','17:10:00'),
-- (3,101,1,'Shahid','RFID','2025-11-14','09:00:00','17:00:00'),
-- (4,102,2,'Ijaz','PIN','2025-11-14',NULL,NULL),
-- (5,101,1,'Shakir','RFID','2025-11-14','09:00:00','17:00:00'),

-- -- Day 15
-- (1,103,3,'Ali','Fingerprint','2025-11-15','09:00:00','17:00:00'),
-- (2,101,1,'Akbar','RFID','2025-11-15','09:00:00','17:00:00'),
-- (3,102,2,'Shahid','PIN','2025-11-15',NULL,NULL),
-- (4,103,3,'Ijaz','Fingerprint','2025-11-15','09:00:00','17:00:00'),
-- (5,102,2,'Shakir','PIN','2025-11-15','09:05:00','17:00:00'),

-- -- Day 16
-- (1,101,1,'Ali','RFID','2025-11-16','09:00:00','17:00:00'),
-- (2,102,2,'Akbar','PIN','2025-11-16',NULL,NULL),
-- (3,101,1,'Shahid','RFID','2025-11-16','09:00:00','17:00:00'),
-- (4,102,2,'Ijaz','PIN','2025-11-16','09:00:00','17:00:00'),
-- (5,103,3,'Shakir','Fingerprint','2025-11-16',NULL,NULL),

-- -- Day 17
-- (1,102,2,'Ali','PIN','2025-11-17','09:00:00','17:00:00'),
-- (2,101,1,'Akbar','RFID','2025-11-17','09:00:00','17:00:00'),
-- (3,103,3,'Shahid','Fingerprint','2025-11-17','09:10:00','17:05:00'),
-- (4,101,1,'Ijaz','RFID','2025-11-17',NULL,NULL),
-- (5,102,2,'Shakir','PIN','2025-11-17','09:00:00','17:00:00'),

-- -- Day 18
-- (1,103,3,'Ali','Fingerprint','2025-11-18','09:00:00','17:00:00'),
-- (2,102,2,'Akbar','PIN','2025-11-18',NULL,NULL),
-- (3,101,1,'Shahid','RFID','2025-11-18','09:00:00','17:00:00'),
-- (4,103,3,'Ijaz','Fingerprint','2025-11-18','09:00:00','17:00:00'),
-- (5,101,1,'Shakir','RFID','2025-11-18','09:00:00','17:00:00'),

-- -- Day 19
-- (1,101,1,'Ali','RFID','2025-11-19','09:00:00','17:00:00'),
-- (2,103,3,'Akbar','Fingerprint','2025-11-19','09:12:00','17:00:00'),
-- (3,102,2,'Shahid','PIN','2025-11-19',NULL,NULL),
-- (4,101,1,'Ijaz','RFID','2025-11-19','09:00:00','17:00:00'),
-- (5,103,3,'Shakir','Fingerprint','2025-11-19',NULL,NULL),

-- -- Day 20
-- (1,102,2,'Ali','PIN','2025-11-20','09:00:00','17:00:00'),
-- (2,101,1,'Akbar','RFID','2025-11-20','09:05:00','17:00:00'),
-- (3,103,3,'Shahid','Fingerprint','2025-11-20','09:00:00','17:00:00'),
-- (4,102,2,'Ijaz','PIN','2025-11-20',NULL,NULL),
-- (5,101,1,'Shakir','RFID','2025-11-20','09:00:00','17:00:00'),

-- -- Day 21
-- (1,103,3,'Ali','Fingerprint','2025-11-21','09:00:00','17:00:00'),
-- (2,102,2,'Akbar','PIN','2025-11-21',NULL,NULL),
-- (3,101,1,'Shahid','RFID','2025-11-21','09:00:00','17:00:00'),
-- (4,103,3,'Ijaz','Fingerprint','2025-11-21','09:10:00','17:12:00'),
-- (5,102,2,'Shakir','PIN','2025-11-21','09:03:00','17:00:00'),

-- -- Day 22
-- (1,101,1,'Ali','RFID','2025-11-22','09:00:00','17:00:00'),
-- (2,101,1,'Akbar','RFID','2025-11-22','09:00:00','17:00:00'),
-- (3,102,2,'Shahid','PIN','2025-11-22',NULL,NULL),
-- (4,101,1,'Ijaz','RFID','2025-11-22','09:00:00','17:00:00'),
-- (5,103,3,'Shakir','Fingerprint','2025-11-22',NULL,NULL),

-- -- Day 23
-- (1,102,2,'Ali','PIN','2025-11-23','09:00:00','17:00:00'),
-- (2,103,3,'Akbar','Fingerprint','2025-11-23',NULL,NULL),
-- (3,101,1,'Shahid','RFID','2025-11-23','09:00:00','17:00:00'),
-- (4,103,3,'Ijaz','Fingerprint','2025-11-23','09:00:00','17:00:00'),
-- (5,102,2,'Shakir','PIN','2025-11-23','09:00:00','17:00:00'),

-- -- Day 24
-- (1,103,3,'Ali','Fingerprint','2025-11-24','09:00:00','17:00:00'),
-- (2,102,2,'Akbar','PIN','2025-11-24','09:15:00','17:05:00'),
-- (3,101,1,'Shahid','RFID','2025-11-24',NULL,NULL),
-- (4,101,1,'Ijaz','RFID','2025-11-24','09:00:00','17:00:00'),
-- (5,103,3,'Shakir','Fingerprint','2025-11-24','09:00:00','17:00:00'),

-- -- Day 25
-- (1,101,1,'Ali','RFID','2025-11-25','09:00:00','17:00:00'),
-- (2,101,1,'Akbar','RFID','2025-11-25','09:03:00','17:00:00'),
-- (3,102,2,'Shahid','PIN','2025-11-25','09:00:00','17:00:00'),
-- (4,103,3,'Ijaz','Fingerprint','2025-11-25',NULL,NULL),
-- (5,102,2,'Shakir','PIN','2025-11-25','09:00:00','17:00:00'),

-- -- Day 26
-- (1,103,3,'Ali','Fingerprint','2025-11-26','09:00:00','17:00:00'),
-- (2,102,2,'Akbar','PIN','2025-11-26',NULL,NULL),
-- (3,103,3,'Shahid','Fingerprint','2025-11-26','09:00:00','17:00:00'),
-- (4,101,1,'Ijaz','RFID','2025-11-26','09:00:00','17:00:00'),
-- (5,101,1,'Shakir','RFID','2025-11-26',NULL,NULL);


-- insert into login (user_name, password) values
-- ('Finance', 'Finance123', 'Administration' ),
-- ('Admin', 'Admin123', 'Finance');
