-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 12, 2024 at 03:20 AM
-- Server version: 8.4.3
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `emp_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `log_id` int NOT NULL,
  `manager_id` int NOT NULL,
  `action_type` varchar(255) NOT NULL,
  `details` text NOT NULL,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `dept_no` int NOT NULL,
  `dept_name` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`dept_no`, `dept_name`, `location`) VALUES
(1, 'Engineering', 'FL# 50'),
(2, 'Human Resources', 'FL# 49'),
(3, 'Product Management', 'FL# 50'),
(4, 'Sales', 'FL# 50 '),
(5, 'Customer Support', 'FL# 49');

-- --------------------------------------------------------

--
-- Table structure for table `deptmanagers`
--

CREATE TABLE `deptmanagers` (
  `emp_no` int DEFAULT NULL,
  `dept_no` int DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `role` enum('admin','manager') DEFAULT 'manager'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `deptmanagers`
--

INSERT INTO `deptmanagers` (`emp_no`, `dept_no`, `from_date`, `to_date`, `role`) VALUES
(1, 1, '2021-01-01', '9999-01-01', 'manager'),
(3, 3, '2021-06-01', '9999-01-01', 'manager'),
(7, 4, '2018-11-11', '9999-01-01', 'manager');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `emp_no` int NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `employment_status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`emp_no`, `first_name`, `last_name`, `birth_date`, `hire_date`, `address`, `phone`, `gender`, `email`, `employment_status`) VALUES
(1, 'John', 'Doe', '1985-05-12', '2020-03-15', '123 Maple St, New York, NY', '555-1234', 'M', 'johndoe@example.com', 'Active'),
(2, 'Jane', 'Smith', '1990-08-22', '2019-07-20', '456 Elm St, New York, NY', '555-5678', 'F', 'janesmith@example.com', 'Active'),
(3, 'Alice', 'Johnson', '1987-12-05', '2021-02-10', '789 Pine St, New York, NY', '555-8765', 'F', 'alicejohnson@example.com', 'On Leave'),
(4, 'Robert', 'Brown', '1980-11-25', '2015-10-30', '321 Oak St, New York, NY', '555-3456', 'M', 'robertbrown@example.com', 'Active'),
(5, 'Michael', 'Williams', '1992-04-17', '2022-01-15', '654 Cedar St, New York, NY', '555-6543', 'M', 'michaelwilliams@example.com', 'Active'),
(6, 'Emily', 'Jones', '1995-09-30', '2020-09-01', '987 Birch St, New York, NY', '555-2345', 'F', 'emilyjones@example.com', 'Terminated'),
(7, 'Chris', 'Miller', '1983-06-12', '2018-11-11', '135 Willow St, New York, NY', '555-7890', 'M', 'chrismiller@example.com', 'Active'),
(8, 'Sarah', 'Davis', '1991-01-14', '2019-05-22', '246 Aspen St, New York, NY', '555-4567', 'F', 'sarahdavis@example.com', 'On Leave'),
(9, 'James', 'Wilson', '1986-02-25', '2021-07-10', '357 Spruce St, New York, NY', '555-9876', 'M', 'jameswilson@example.com', 'Active'),
(10, 'Laura', 'Martinez', '1993-11-03', '2020-04-18', '468 Fir St, New York, NY', '555-3210', 'F', 'lauramartinez@example.com', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `emp_assignment`
--

CREATE TABLE `emp_assignment` (
  `emp_no` int DEFAULT NULL,
  `project_id` int DEFAULT NULL,
  `role_in_project` varchar(100) DEFAULT NULL,
  `assignment_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `emp_assignment`
--

INSERT INTO `emp_assignment` (`emp_no`, `project_id`, `role_in_project`, `assignment_date`) VALUES
(1, 1, 'Lead Developer', '2022-01-15'),
(2, 2, 'Project Coordinator', '2023-02-20'),
(3, 3, 'Product Owner', '2022-06-05'),
(4, 4, 'Data Migration Specialist', '2021-09-10'),
(5, 5, 'Security Analyst', '2023-03-10');

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `history_id` int NOT NULL,
  `emp_no` int NOT NULL,
  `change_type` varchar(255) NOT NULL,
  `old_value` text,
  `new_value` text,
  `changed_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`history_id`, `emp_no`, `change_type`, `old_value`, `new_value`, `changed_at`) VALUES
(1, 2, 'Department Change', '1', '1', '2024-11-11 20:27:27'),
(2, 2, 'Department Change', '1', '1', '2024-11-11 20:27:31'),
(3, 2, 'Department Change', '1', '2', '2024-11-11 20:39:24'),
(4, 2, 'Department Change', '2', '1', '2024-11-11 20:45:02'),
(5, 2, 'Department Change', '1', '1', '2024-11-11 21:06:41');

-- --------------------------------------------------------

--
-- Table structure for table `performance_reviews`
--

CREATE TABLE `performance_reviews` (
  `review_id` int NOT NULL,
  `emp_no` int NOT NULL,
  `manager_id` int NOT NULL,
  `review_text` text NOT NULL,
  `review_date` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `performance_reviews`
--

INSERT INTO `performance_reviews` (`review_id`, `emp_no`, `manager_id`, `review_text`, `review_date`) VALUES
(1, 1, 3, 'hey', '2024-11-11 21:12:16'),
(2, 1, 3, 'hey', '2024-11-11 21:12:20');

-- --------------------------------------------------------

--
-- Table structure for table `project_assign`
--

CREATE TABLE `project_assign` (
  `project_id` int NOT NULL,
  `project_name` varchar(100) DEFAULT NULL,
  `start_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `project_assign`
--

INSERT INTO `project_assign` (`project_id`, `project_name`, `start_date`) VALUES
(1, 'AI Development', '2022-01-01'),
(2, 'Web Redesign', '2023-02-15'),
(3, 'Mobile App Launch', '2022-06-01'),
(4, 'Data Migration', '2021-09-01'),
(5, 'Cybersecurity Audit', '2023-03-01');

-- --------------------------------------------------------

--
-- Table structure for table `salaries`
--

CREATE TABLE `salaries` (
  `emp_no` int DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `salaries`
--

INSERT INTO `salaries` (`emp_no`, `salary`, `from_date`, `to_date`) VALUES
(2, 60000.00, '2019-02-15', '2024-12-31'),
(3, 95000.00, '2021-06-01', '2024-12-31'),
(4, 50000.00, '2015-11-01', '2024-12-31'),
(5, 55000.00, '2022-01-15', '2024-12-31'),
(6, 78000.00, '2020-09-01', '2024-12-31'),
(7, 62000.00, '2018-11-11', '2024-12-31'),
(8, 72000.00, '2019-05-22', '2024-12-31'),
(9, 88000.00, '2021-07-10', '2024-12-31'),
(10, 70000.00, '2020-04-18', '2024-12-31');

-- --------------------------------------------------------

--
-- Table structure for table `titles`
--

CREATE TABLE `titles` (
  `emp_no` int DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `dept_no` int DEFAULT NULL,
  `responsibilities` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `titles`
--

INSERT INTO `titles` (`emp_no`, `title`, `from_date`, `to_date`, `dept_no`, `responsibilities`) VALUES
(2, 'Customer Support Specialist', '2019-02-15', '9999-01-01', 1, 'Manage employee records and recruitment'),
(3, 'Customer Support Specialist', '2021-06-01', '9999-01-01', 3, 'Oversee product development and manage cross-functional teams'),
(4, 'Customer Support Specialist', '2015-11-01', '9999-01-01', 1, 'Generate leads and handle customer relationships'),
(5, 'Customer Support Specialist', '2022-01-15', '9999-01-01', 5, 'Provide support and troubleshooting to clients'),
(6, 'Customer Support Specialist', '2020-09-01', '9999-01-01', 1, 'Develop user interfaces for applications'),
(7, 'Marketing Coordinator', '2018-11-11', '9999-01-01', 4, 'Coordinate marketing campaigns and strategies'),
(8, 'UI/UX Designer', '2019-05-22', '9999-01-01', 1, 'Design user-friendly interfaces and improve user experience'),
(9, 'Backend Developer', '2021-07-10', '9999-01-01', 1, 'Manage server-side logic and database integration'),
(10, 'Data Analyst', '2020-04-18', '9999-01-01', 1, 'Analyze data to support business decisions');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `manager_id` (`manager_id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`dept_no`);

--
-- Indexes for table `deptmanagers`
--
ALTER TABLE `deptmanagers`
  ADD UNIQUE KEY `emp_no_2` (`emp_no`),
  ADD KEY `emp_no` (`emp_no`),
  ADD KEY `dept_no` (`dept_no`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`emp_no`);

--
-- Indexes for table `emp_assignment`
--
ALTER TABLE `emp_assignment`
  ADD KEY `emp_no` (`emp_no`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `emp_no` (`emp_no`);

--
-- Indexes for table `performance_reviews`
--
ALTER TABLE `performance_reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `emp_no` (`emp_no`),
  ADD KEY `manager_id` (`manager_id`);

--
-- Indexes for table `project_assign`
--
ALTER TABLE `project_assign`
  ADD PRIMARY KEY (`project_id`);

--
-- Indexes for table `salaries`
--
ALTER TABLE `salaries`
  ADD KEY `emp_no` (`emp_no`);

--
-- Indexes for table `titles`
--
ALTER TABLE `titles`
  ADD KEY `emp_no` (`emp_no`),
  ADD KEY `dept_no` (`dept_no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `log_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `history_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `performance_reviews`
--
ALTER TABLE `performance_reviews`
  MODIFY `review_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `deptmanagers` (`emp_no`);

--
-- Constraints for table `deptmanagers`
--
ALTER TABLE `deptmanagers`
  ADD CONSTRAINT `deptmanagers_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`),
  ADD CONSTRAINT `deptmanagers_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`);

--
-- Constraints for table `emp_assignment`
--
ALTER TABLE `emp_assignment`
  ADD CONSTRAINT `emp_assignment_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`),
  ADD CONSTRAINT `emp_assignment_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `project_assign` (`project_id`);

--
-- Constraints for table `history`
--
ALTER TABLE `history`
  ADD CONSTRAINT `history_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`);

--
-- Constraints for table `performance_reviews`
--
ALTER TABLE `performance_reviews`
  ADD CONSTRAINT `performance_reviews_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`),
  ADD CONSTRAINT `performance_reviews_ibfk_2` FOREIGN KEY (`manager_id`) REFERENCES `deptmanagers` (`emp_no`);

--
-- Constraints for table `salaries`
--
ALTER TABLE `salaries`
  ADD CONSTRAINT `salaries_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`);

--
-- Constraints for table `titles`
--
ALTER TABLE `titles`
  ADD CONSTRAINT `titles_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`),
  ADD CONSTRAINT `titles_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
