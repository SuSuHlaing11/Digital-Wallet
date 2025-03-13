-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 13, 2025 at 08:25 AM
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
-- Database: `bank`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `a_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` bigint(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `profile_picture` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`a_id`, `username`, `email`, `phone`, `password`, `profile_picture`) VALUES
(1, 'admin1', 'admin1@example.com', 9876543210, '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', NULL),
(2, 'admin2', 'admin2@example.com', 9876543211, '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', NULL),
(3, 'admin3', 'admin3@example.com', 9876543212, '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `balance`
--

CREATE TABLE `balance` (
  `id` int(11) NOT NULL,
  `accno` int(11) NOT NULL,
  `balance` decimal(15,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deposit_approve`
--

CREATE TABLE `deposit_approve` (
  `deposit_id` int(11) NOT NULL,
  `sender_id` varchar(50) DEFAULT NULL,
  `receiver_id` varchar(50) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `transfer_type` varchar(50) DEFAULT NULL,
  `transfer_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `account_type` varchar(50) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `status` enum('Pending','Approved','Rejected') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `transfer_id` int(11) NOT NULL,
  `sender_id` varchar(50) DEFAULT NULL,
  `receiver_id` varchar(50) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `transfer_type` varchar(50) DEFAULT NULL,
  `transfer_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `account_type` varchar(50) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `id` int(11) NOT NULL,
  `accno` varchar(255) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `rating_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `accno` int(11) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `dob` date NOT NULL,
  `gender` varchar(10) NOT NULL,
  `nrc` varchar(30) NOT NULL,
  `address` text NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` bigint(20) NOT NULL,
  `acctype` varchar(30) NOT NULL,
  `password` varchar(64) NOT NULL,
  `code` int(11) NOT NULL,
  `status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `profile_picture` varchar(255) DEFAULT NULL,
  `is_frozen` tinyint(1) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `accno`, `fullname`, `username`, `dob`, `gender`, `nrc`, `address`, `email`, `phone`, `acctype`, `password`, `code`, `status`, `profile_picture`, `is_frozen`, `is_deleted`) VALUES
(31, 517190, 'Aung Min Tun', 'ming_tun', '1992-07-15', 'Male', '12 / PAZATA (N) 123456', 'No. 23, Pyay Road, Kamayut Township, Yangon', 'example@gmail.com', 959233456789, 'Current Account', '4ddca0982ac98acf7fb5c818f939e910a06b3186204242cc1d40db8b907c68be', 262043, 'Approved', 'img/user_517190.jpg', 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`a_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `balance`
--
ALTER TABLE `balance`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `accno` (`accno`);

--
-- Indexes for table `deposit_approve`
--
ALTER TABLE `deposit_approve`
  ADD PRIMARY KEY (`deposit_id`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`transfer_id`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_account_per_type` (`email`,`acctype`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `a_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `balance`
--
ALTER TABLE `balance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `deposit_approve`
--
ALTER TABLE `deposit_approve`
  MODIFY `deposit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `transfer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=153;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
