-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: emp_project
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `dept_no` int NOT NULL,
  `dept_name` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`dept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'Engineering','FL# 50'),(2,'Human Resources','FL# 49'),(3,'Product Management','FL# 50'),(4,'Sales','FL# 50 '),(5,'Customer Support','FL# 49');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deptmanagers`
--

DROP TABLE IF EXISTS `deptmanagers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deptmanagers` (
  `emp_no` int DEFAULT NULL,
  `dept_no` int DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  KEY `emp_no` (`emp_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `deptmanagers_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`),
  CONSTRAINT `deptmanagers_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deptmanagers`
--

LOCK TABLES `deptmanagers` WRITE;
/*!40000 ALTER TABLE `deptmanagers` DISABLE KEYS */;
INSERT INTO `deptmanagers` VALUES (1,1,'2021-01-01','2023-12-31'),(3,3,'2021-06-01','2023-12-31'),(7,4,'2018-11-11','2023-12-31');
/*!40000 ALTER TABLE `deptmanagers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp_assignment`
--

DROP TABLE IF EXISTS `emp_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emp_assignment` (
  `emp_no` int DEFAULT NULL,
  `project_id` int DEFAULT NULL,
  `role_in_project` varchar(100) DEFAULT NULL,
  `assignment_date` date DEFAULT NULL,
  KEY `emp_no` (`emp_no`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `emp_assignment_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`),
  CONSTRAINT `emp_assignment_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `project_assign` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp_assignment`
--

LOCK TABLES `emp_assignment` WRITE;
/*!40000 ALTER TABLE `emp_assignment` DISABLE KEYS */;
INSERT INTO `emp_assignment` VALUES (1,1,'Lead Developer','2022-01-15'),(2,2,'Project Coordinator','2023-02-20'),(3,3,'Product Owner','2022-06-05'),(4,4,'Data Migration Specialist','2021-09-10'),(5,5,'Security Analyst','2023-03-10');
/*!40000 ALTER TABLE `emp_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
  `employment_status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'John','Doe','1985-05-12','2020-03-15','123 Maple St, New York, NY','555-1234','M','johndoe@example.com','Active'),(2,'Jane','Smith','1990-08-22','2019-07-20','456 Elm St, New York, NY','555-5678','F','janesmith@example.com','Active'),(3,'Alice','Johnson','1987-12-05','2021-02-10','789 Pine St, New York, NY','555-8765','F','alicejohnson@example.com','On Leave'),(4,'Robert','Brown','1980-11-25','2015-10-30','321 Oak St, New York, NY','555-3456','M','robertbrown@example.com','Active'),(5,'Michael','Williams','1992-04-17','2022-01-15','654 Cedar St, New York, NY','555-6543','M','michaelwilliams@example.com','Active'),(6,'Emily','Jones','1995-09-30','2020-09-01','987 Birch St, New York, NY','555-2345','F','emilyjones@example.com','Terminated'),(7,'Chris','Miller','1983-06-12','2018-11-11','135 Willow St, New York, NY','555-7890','M','chrismiller@example.com','Active'),(8,'Sarah','Davis','1991-01-14','2019-05-22','246 Aspen St, New York, NY','555-4567','F','sarahdavis@example.com','On Leave'),(9,'James','Wilson','1986-02-25','2021-07-10','357 Spruce St, New York, NY','555-9876','M','jameswilson@example.com','Active'),(10,'Laura','Martinez','1993-11-03','2020-04-18','468 Fir St, New York, NY','555-3210','F','lauramartinez@example.com','Active');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_assign`
--

DROP TABLE IF EXISTS `project_assign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_assign` (
  `project_id` int NOT NULL,
  `project_name` varchar(100) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_assign`
--

LOCK TABLES `project_assign` WRITE;
/*!40000 ALTER TABLE `project_assign` DISABLE KEYS */;
INSERT INTO `project_assign` VALUES (1,'AI Development','2022-01-01'),(2,'Web Redesign','2023-02-15'),(3,'Mobile App Launch','2022-06-01'),(4,'Data Migration','2021-09-01'),(5,'Cybersecurity Audit','2023-03-01');
/*!40000 ALTER TABLE `project_assign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salaries`
--

DROP TABLE IF EXISTS `salaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salaries` (
  `emp_no` int DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  KEY `emp_no` (`emp_no`),
  CONSTRAINT `salaries_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salaries`
--

LOCK TABLES `salaries` WRITE;
/*!40000 ALTER TABLE `salaries` DISABLE KEYS */;
INSERT INTO `salaries` VALUES (1,85000.00,'2021-01-01','2024-12-31'),(2,60000.00,'2019-02-15','2024-12-31'),(3,95000.00,'2021-06-01','2024-12-31'),(4,50000.00,'2015-11-01','2024-12-31'),(5,55000.00,'2022-01-15','2024-12-31'),(6,78000.00,'2020-09-01','2024-12-31'),(7,62000.00,'2018-11-11','2024-12-31'),(8,72000.00,'2019-05-22','2024-12-31'),(9,88000.00,'2021-07-10','2024-12-31'),(10,70000.00,'2020-04-18','2024-12-31');
/*!40000 ALTER TABLE `salaries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `titles`
--

DROP TABLE IF EXISTS `titles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `titles` (
  `emp_no` int DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `dept_no` int DEFAULT NULL,
  `responsibilities` text,
  KEY `emp_no` (`emp_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `titles_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`),
  CONSTRAINT `titles_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `titles`
--

LOCK TABLES `titles` WRITE;
/*!40000 ALTER TABLE `titles` DISABLE KEYS */;
INSERT INTO `titles` VALUES (1,'Software Engineer','2021-01-01','2023-12-31',1,'Develop and maintain software applications'),(2,'HR Specialist','2019-02-15','2022-12-31',2,'Manage employee records and recruitment'),(3,'Product Manager','2021-06-01','2023-12-31',3,'Oversee product development and manage cross-functional teams'),(4,'Sales Associate','2015-11-01','2022-12-31',4,'Generate leads and handle customer relationships'),(5,'Customer Support Specialist','2022-01-15','2023-12-31',5,'Provide support and troubleshooting to clients'),(6,'Front-End Developer','2020-09-01','2023-12-31',1,'Develop user interfaces for applications'),(7,'Marketing Coordinator','2018-11-11','2023-12-31',4,'Coordinate marketing campaigns and strategies'),(8,'UI/UX Designer','2019-05-22','2023-12-31',1,'Design user-friendly interfaces and improve user experience'),(9,'Backend Developer','2021-07-10','2023-12-31',1,'Manage server-side logic and database integration'),(10,'Data Analyst','2020-04-18','2023-12-31',1,'Analyze data to support business decisions');
/*!40000 ALTER TABLE `titles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-07 18:50:20
