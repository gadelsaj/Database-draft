-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 24, 2024 at 11:33 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `employees`
--
CREATE DATABASE IF NOT EXISTS `employees` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `employees`;

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `log_id` int(11) NOT NULL,
  `manager_id` int(11) NOT NULL,
  `action_type` varchar(255) NOT NULL,
  `details` text NOT NULL,
  `timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `dept_no` int(11) NOT NULL,
  `dept_name` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `emp_no` int(11) DEFAULT NULL,
  `dept_no` int(11) DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `role` enum('admin','manager') DEFAULT 'manager'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `emp_no` int(11) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `employment_status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `emp_no` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `role_in_project` varchar(100) DEFAULT NULL,
  `assignment_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Table structure for table `performance_reviews`
--

CREATE TABLE `performance_reviews` (
  `review_id` int(11) NOT NULL,
  `emp_no` int(11) NOT NULL,
  `manager_id` int(11) NOT NULL,
  `review_text` text NOT NULL,
  `review_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `project_id` int(11) NOT NULL,
  `project_name` varchar(100) DEFAULT NULL,
  `start_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `emp_no` int(11) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `emp_no` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `dept_no` int(11) DEFAULT NULL,
  `responsibilities` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `performance_reviews`
--
ALTER TABLE `performance_reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
--
-- Database: `emp_project`
--
CREATE DATABASE IF NOT EXISTS `emp_project` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `emp_project`;

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `log_id` int(11) NOT NULL,
  `manager_id` int(11) NOT NULL,
  `action_type` varchar(255) NOT NULL,
  `details` text NOT NULL,
  `timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `dept_no` int(11) NOT NULL,
  `dept_name` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`dept_no`, `dept_name`, `location`) VALUES
(1, 'Engineering', 'FL# 50'),
(2, 'Human Resources', 'FL# 49'),
(3, 'Product Management', 'FL# 50'),
(4, 'Sales', 'FL# 50 '),
(5, 'Customer Support', 'FL# 49'),
(1, 'Development', 'Headquarters');

-- --------------------------------------------------------

--
-- Table structure for table `deptmanagers`
--

CREATE TABLE `deptmanagers` (
  `emp_no` int(11) DEFAULT NULL,
  `dept_no` int(11) DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `role` enum('admin','manager') DEFAULT 'manager',
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deptmanagers`
--

INSERT INTO `deptmanagers` (`emp_no`, `dept_no`, `from_date`, `to_date`, `role`, `password`) VALUES
(1, 1, '2021-01-01', '9999-01-01', 'manager', NULL),
(3, 3, '2021-06-01', '9999-01-01', 'manager', '$2y$10$7oWVWTCM3UYt2vTDCvvki.7kVw5XwT/zQt5LQ4Wxd2Y/ib6uTDcxW'),
(7, 4, '2018-11-11', '9999-01-01', 'manager', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `emp_no` int(11) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `employment_status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`emp_no`, `first_name`, `last_name`, `birth_date`, `hire_date`, `address`, `phone`, `gender`, `email`, `employment_status`) VALUES
(1, 'John', 'Doe', '1985-05-12', '2020-03-15', '123 Maple St, New York, NY', '555-1234', 'M', 'johndoe@example.com', 'terminated'),
(2, 'Jane', 'Smith', '1990-08-22', '2019-07-20', '456 Elm St, New York, NY', '555-5678', 'F', 'janesmith@example.com', 'Active'),
(3, 'Alice', 'Johnson', '1987-12-05', '2021-02-10', '789 Pine St, New York, NY', '555-8765', 'F', 'alicejohnson@example.com', 'On Leave'),
(4, 'Robert', 'Brown', '1980-11-25', '2015-10-30', '321 Oak St, New York, NY', '555-3456', 'M', 'robertbrown@example.com', 'Active'),
(5, 'Michael', 'Williams', '1992-04-17', '2022-01-15', '654 Cedar St, New York, NY', '555-6543', 'M', 'michaelwilliams@example.com', 'terminated'),
(6, 'Emily', 'Jones', '1995-09-30', '2020-09-01', '987 Birch St, New York, NY', '555-2345', 'F', 'emilyjones@example.com', 'Terminated'),
(7, 'Chris', 'Miller', '1983-06-12', '2018-11-11', '135 Willow St, New York, NY', '555-7890', 'M', 'chrismiller@example.com', 'Active'),
(8, 'Sarah', 'Davis', '1991-01-14', '2019-05-22', '246 Aspen St, New York, NY', '555-4567', 'F', 'sarahdavis@example.com', 'On Leave'),
(9, 'James', 'Wilson', '1986-02-25', '2021-07-10', '357 Spruce St, New York, NY', '555-9876', 'M', 'jameswilson@example.com', 'terminated'),
(10, 'Laura', 'Martinez', '1993-11-03', '2020-04-18', '468 Fir St, New York, NY', '555-3210', 'F', 'lauramartinez@example.com', 'Active'),
(11, 'Justin', 'Fair', '2010-01-01', '2024-12-24', '12 Apple Street', '555-7799', 'M', 'fairju@kean.edu', 'terminated'),
(22, 'Bob', 'Hope', '2000-01-05', '2023-11-21', '12 new street', '555-7788', 'M', 'hope@gmail.com', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `emp_assignment`
--

CREATE TABLE `emp_assignment` (
  `emp_no` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `role_in_project` varchar(100) DEFAULT NULL,
  `assignment_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `emp_assignment`
--

INSERT INTO `emp_assignment` (`emp_no`, `project_id`, `role_in_project`, `assignment_date`) VALUES
(1, 2, 'Lead Developer', '2022-01-15'),
(2, 2, 'Project Coordinator', '2023-02-20'),
(3, 2, 'Product Owner', '2022-06-05'),
(4, 2, 'Data Migration Specialist', '2021-09-10'),
(5, 2, 'Security Analyst', '2023-03-10');

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `history_id` int(11) NOT NULL,
  `emp_no` int(11) NOT NULL,
  `change_type` varchar(255) NOT NULL,
  `old_value` text DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  `changed_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`history_id`, `emp_no`, `change_type`, `old_value`, `new_value`, `changed_at`) VALUES
(1, 2, 'Department Change', '1', '1', '2024-11-11 20:27:27'),
(2, 2, 'Department Change', '1', '1', '2024-11-11 20:27:31'),
(3, 2, 'Department Change', '1', '2', '2024-11-11 20:39:24'),
(4, 2, 'Department Change', '2', '1', '2024-11-11 20:45:02'),
(5, 2, 'Department Change', '1', '1', '2024-11-11 21:06:41'),
(0, 2, 'Department Change', '1', '2', '2024-11-22 21:01:45'),
(0, 0, 'Salary Update', '20000.00', '50000', '2024-11-22 21:46:33'),
(0, 0, 'Salary Update', '50000.00', '50000', '2024-11-22 21:46:50'),
(0, 4, 'Department Change', '1', '3', '2024-11-23 19:10:31'),
(0, 4, 'Department Change', '3', '3', '2024-11-23 19:13:41'),
(0, 2, 'Salary Update', '60000.00', '20000', '2024-11-23 19:14:00'),
(0, 7, 'Salary Update', '62000.00', '25000', '2024-11-23 19:14:22'),
(0, 6, 'Department Change', '1', '3', '2024-11-24 11:46:34'),
(0, 6, 'Department Change', '3', '4', '2024-11-24 11:51:55'),
(0, 8, 'Salary Update', '72000.00', '75000', '2024-11-24 11:52:34'),
(0, 11, 'Department Change', NULL, '1', '2024-11-24 13:52:40'),
(0, 11, 'Department Change', NULL, '2', '2024-11-24 13:57:26'),
(0, 22, 'Department Change', '1', '4', '2024-11-24 14:23:30');

-- --------------------------------------------------------

--
-- Table structure for table `performance_reviews`
--

CREATE TABLE `performance_reviews` (
  `review_id` int(11) NOT NULL,
  `emp_no` int(11) NOT NULL,
  `manager_id` int(11) NOT NULL,
  `review_text` text NOT NULL,
  `review_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `performance_reviews`
--

INSERT INTO `performance_reviews` (`review_id`, `emp_no`, `manager_id`, `review_text`, `review_date`) VALUES
(1, 1, 3, 'hey', '2024-11-11 21:12:16'),
(2, 1, 3, 'hey', '2024-11-11 21:12:20'),
(0, 5, 3, 'Great Job', '2024-11-24 11:45:44'),
(0, 10, 3, 'You are doing a great job keep it up!', '2024-11-24 13:19:04'),
(0, 22, 3, 'Great job!', '2024-11-24 14:23:19');

-- --------------------------------------------------------

--
-- Table structure for table `project_assign`
--

CREATE TABLE `project_assign` (
  `project_id` int(11) NOT NULL,
  `project_name` varchar(100) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `completion_date` date DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `project_assign`
--

INSERT INTO `project_assign` (`project_id`, `project_name`, `start_date`, `completion_date`, `status`) VALUES
(1, 'AI Development', '2022-01-01', '2023-06-30', 'Completed'),
(2, 'Web Redesign', '2021-09-10', NULL, 'Active'),
(3, 'Mobile App Launch', '2022-06-01', '2022-12-31', 'Completed'),
(4, 'Data Migration', '2021-09-01', '2022-01-15', 'Completed'),
(5, 'Cybersecurity Audit', '2023-03-01', NULL, 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `salaries`
--

CREATE TABLE `salaries` (
  `emp_no` int(11) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `salaries`
--

INSERT INTO `salaries` (`emp_no`, `salary`, `from_date`, `to_date`) VALUES
(2, 20000.00, '2019-02-15', '2024-12-31'),
(3, 95000.00, '2021-06-01', '2024-12-31'),
(4, 50000.00, '2015-11-01', '2024-12-31'),
(5, 55000.00, '2022-01-15', '2024-12-31'),
(6, 78000.00, '2020-09-01', '2024-12-31'),
(7, 25000.00, '2018-11-11', '2024-12-31'),
(8, 75000.00, '2019-05-22', '2024-12-31'),
(9, 88000.00, '2021-07-10', '2024-12-31'),
(10, 70000.00, '2020-04-18', '2024-12-31'),
(0, 50000.00, '2024-11-22', '9999-01-01'),
(0, 50000.00, '2024-11-22', '9999-01-01'),
(0, 55000.00, '2024-11-22', '9999-01-01'),
(22, 50000.00, '2024-11-24', '9999-01-01');

-- --------------------------------------------------------

--
-- Table structure for table `titles`
--

CREATE TABLE `titles` (
  `emp_no` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `dept_no` int(11) DEFAULT NULL,
  `responsibilities` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `titles`
--

INSERT INTO `titles` (`emp_no`, `title`, `from_date`, `to_date`, `dept_no`, `responsibilities`) VALUES
(2, 'Tech', '2019-02-15', '9999-01-01', 2, 'Manage employee records and recruitment'),
(3, 'Tech', '2021-06-01', '9999-01-01', 3, 'Oversee product development and manage cross-functional teams'),
(4, 'Customer Support Specialist', '2015-11-01', '9999-01-01', 3, 'Generate leads and handle customer relationships'),
(5, 'Marketing Coordinator', '2022-01-15', '9999-01-01', 5, 'Provide support and troubleshooting to clients'),
(6, 'Customer Support Specialist', '2020-09-01', '9999-01-01', 4, 'Develop user interfaces for applications'),
(7, 'Marketing Coordinator', '2018-11-11', '9999-01-01', 4, 'Coordinate marketing campaigns and strategies'),
(8, 'Tech', '2019-05-22', '9999-01-01', 4, 'Design user-friendly interfaces and improve user experience'),
(9, 'Backend Developer', '2021-07-10', '9999-01-01', 4, 'Manage server-side logic and database integration'),
(10, 'UI/UX Designer', '2020-04-18', '9999-01-01', 1, 'Analyze data to support business decisions'),
(0, 'Tech', '2024-11-22', '9999-01-01', 1, NULL),
(0, 'Head Tech', '2024-11-22', '9999-01-01', 1, NULL),
(0, 'Head Tech', '2024-11-22', '9999-01-01', 1, NULL),
(22, 'UI/UX Designer', '2024-11-24', '9999-01-01', 4, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`emp_no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `emp_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Dumping data for table `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"emp_project\",\"table\":\"project_assign\"},{\"db\":\"emp_project\",\"table\":\"emp_assignment\"},{\"db\":\"emp_project\",\"table\":\"employees\"},{\"db\":\"emp_project\",\"table\":\"departments\"},{\"db\":\"emp_project\",\"table\":\"salaries\"},{\"db\":\"emp_project\",\"table\":\"titles\"},{\"db\":\"emp_project\",\"table\":\"performance_reviews\"},{\"db\":\"emp_project\",\"table\":\"audit_logs\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data for table `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2024-11-24 22:32:49', '{\"Console\\/Mode\":\"collapse\",\"NavigationWidth\":342}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indexes for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indexes for table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
