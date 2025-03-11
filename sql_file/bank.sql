-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 11, 2025 at 04:51 PM
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

--
-- Dumping data for table `balance`
--

INSERT INTO `balance` (`id`, `accno`, `balance`) VALUES
(10, 517190, 870000.00),
(11, 293528, 1180003.00),
(12, 691932, 252000.00),
(13, 271197, 880000.00),
(14, 179971, 2791999.00),
(15, 777497, 5619997.00);

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

--
-- Dumping data for table `deposit_approve`
--

INSERT INTO `deposit_approve` (`deposit_id`, `sender_id`, `receiver_id`, `amount`, `transfer_type`, `transfer_time`, `account_type`, `note`, `status`) VALUES
(40, 'DEPOSIT', '271197', 7999.00, 'Deposit', '2025-03-04 16:30:59', 'Current Account', '', 'Rejected');

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

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`transfer_id`, `sender_id`, `receiver_id`, `amount`, `transfer_type`, `transfer_time`, `account_type`, `note`) VALUES
(123, 'DEPOSIT', '517190', 500000.00, 'Deposit', '2025-03-04 14:26:35', 'Current Account', NULL),
(124, 'DEPOSIT', '517190', 500000.00, 'Deposit', '2025-03-04 14:27:02', 'Current Account', NULL),
(125, 'DEPOSIT', '293528', 450000.00, 'Deposit', '2025-03-04 14:44:40', 'Current Account', NULL),
(126, 'DEPOSIT', '691932', 300000.00, 'Deposit', '2025-03-04 14:45:56', 'Saving Account', NULL),
(127, 'DEPOSIT', '271197', 1000000.00, 'Deposit', '2025-03-04 14:46:55', 'Current Account', NULL),
(128, 'DEPOSIT', '179971', 1200000.00, 'Deposit', '2025-03-04 14:47:48', 'Saving Account', NULL),
(129, '179971', 'WITHDRAW', 20000.00, 'withdraw', '2025-03-04 14:53:22', 'Saving Account', NULL),
(130, '179971', '517190', 1000.00, 'transfer', '2025-03-04 14:53:41', 'Checking account', NULL),
(131, 'DEPOSIT', '179971', 1450000.00, 'Deposit', '2025-03-04 14:54:10', 'Saving Account', NULL),
(132, '517190', 'WITHDRAW', 4500.00, 'withdraw', '2025-03-04 14:55:55', 'Current Account', NULL),
(133, '517190', '293528', 6500.00, 'transfer', '2025-03-04 14:56:43', 'Checking account', NULL),
(134, 'DEPOSIT', '293528', 10000.00, 'Deposit', '2025-03-04 14:58:47', 'Current Account', NULL),
(135, 'DEPOSIT', '293528', 100000.00, 'Deposit', '2025-03-04 15:04:53', 'Current Account', NULL),
(136, '517190', '293528', 1000.00, 'transfer', '2025-03-04 15:15:41', 'Checking account', NULL),
(137, 'DEPOSIT', '777497', 3000000.00, 'Deposit', '2025-03-04 15:25:42', 'Current Account', NULL),
(138, '517190', '293528', 9000.00, 'transfer', '2025-03-04 15:47:59', 'Checking account', NULL),
(139, '517190', '691932', 1000.00, 'transfer', '2025-03-04 15:49:01', 'Checking account', NULL),
(140, '691932', 'WITHDRAW', 10000.00, 'withdraw', '2025-03-04 15:50:28', 'Saving Account', NULL),
(141, '691932', '271197', 1000.00, 'transfer', '2025-03-04 15:51:17', 'Checking account', NULL),
(142, '691932', 'WITHDRAW', 45000.00, 'withdraw', '2025-03-04 16:08:23', 'Saving Account', NULL),
(143, 'DEPOSIT', '691932', 5000.00, 'Deposit', '2025-03-04 16:09:42', 'Saving Account', NULL),
(144, 'DEPOSIT', '777497', 3000000.00, 'Deposit', '2025-03-04 15:26:04', 'Current Account', NULL),
(145, 'DEPOSIT', '271197', 70000.00, 'Deposit', '2025-03-04 16:11:28', 'Current Account', NULL),
(146, '517190', '293528', 1000.00, 'transfer', '2025-03-04 16:19:53', 'Checking account', NULL),
(147, '271197', 'WITHDRAW', 2001.00, 'withdraw', '2025-03-04 16:32:07', 'Current Account', NULL),
(148, '293528', 'WITHDRAW', 1500.00, 'withdraw', '2025-03-04 16:41:35', 'Current Account', NULL),
(149, 'DEPOSIT', '517190', 100000.00, 'Deposit', '2025-03-05 09:10:47', 'Current Account', NULL),
(150, '517190', 'WITHDRAW', 8000.00, 'withdraw', '2025-03-05 09:16:11', 'Current Account', NULL),
(151, '517190', '293528', 3.00, 'transfer', '2025-03-05 09:17:43', 'Checking account', NULL),
(152, '517190', '293528', 200000.00, 'transfer', '2025-03-05 09:19:47', 'Checking account', 'alert');

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

--
-- Dumping data for table `ratings`
--

INSERT INTO `ratings` (`id`, `accno`, `rating`, `rating_time`) VALUES
(81, '777497', 3, '2025-03-04 15:26:15'),
(82, '517190', 4, '2025-03-05 09:32:21'),
(83, '517190', 1, '2025-03-05 09:33:37');

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
(31, 517190, 'Aung Min Tun', 'ming_tun', '1992-07-15', 'Male', '12 / PAZATA (N) 123456', 'No. 23, Pyay Road, Kamayut Township, Yangon', 'Selenamoon172004@gmail.com', 959233456789, 'Current Account', '4ddca0982ac98acf7fb5c818f939e910a06b3186204242cc1d40db8b907c68be', 262043, 'Approved', 'img/user_517190.jpg', 0, 0),
(32, 293528, 'Thiri Wut Yee', 'thiri_123', '2002-06-04', 'Female', '12 / PAZATA (N) 147685', '12B, Yadanar Street, Mingalar Taung Nyunt, Yangon', 'Melissajanerd@gmail.com', 959251987654, 'Current Account', '4ddca0982ac98acf7fb5c818f939e910a06b3186204242cc1d40db8b907c68be', 693729, 'Approved', NULL, 0, 1),
(33, 691932, 'Kyaw Zin Htet', 'cyber_phoenixX', '2003-05-12', 'Male', '12 / TAKANA (N) 045112', '12B, Yadanar Street, Mingalar Taung Nyunt, Yangon', 'kyitharmoe2000@gmail.com', 959785432109, 'Saving Account', '4ddca0982ac98acf7fb5c818f939e910a06b3186204242cc1d40db8b907c68be', 977223, 'Approved', NULL, 0, 0),
(34, 271197, 'Min Htet Zaw', 'shadow_coder07', '2002-01-01', 'Male', '12 / YAKANA (N) 123456', '77, Cherry Lane, Hpa-An, Kayin State', 'Myatshweyimoe551@gmail.com', 959894561230, 'Current Account', '4ddca0982ac98acf7fb5c818f939e910a06b3186204242cc1d40db8b907c68be', 867693, 'Approved', NULL, 0, 0),
(35, 179971, 'Eaint Maw Thaw', 'eaint_01', '2004-06-15', 'Female', '12 / MAGADA (N) 014527', 'No. 45, Myay Ni Street, North Dagon Township, Yangon, Myanmar', 'Aibarahanami11@gmail.com', 959712345678, 'Saving Account', '4ddca0982ac98acf7fb5c818f939e910a06b3186204242cc1d40db8b907c68be', 909994, 'Approved', NULL, 0, 0),
(36, 777497, 'Eaint Maw Thaw', 'eaint_01', '2004-06-15', 'Female', '12 / MAGADA (N) 014527', 'No. 45, Myay Ni Street, North Dagon Township, Yangon, Myanmar', 'Aibarahanami11@gmail.com', 959712345678, 'Current Account', '4ddca0982ac98acf7fb5c818f939e910a06b3186204242cc1d40db8b907c68be', 609827, 'Approved', NULL, 0, 1),
(37, 991868, 'Myat', 'yu', '2005-09-09', 'Male', '9 / KASANA NC 123456', 'hu', 'mahichan172004@gmail.com', 95911234567, 'Current Account', '4ddca0982ac98acf7fb5c818f939e910a06b3186204242cc1d40db8b907c68be', 870335, 'Approved', NULL, 0, 0);

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
