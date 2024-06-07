-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 04, 2024 at 09:31 PM
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
-- Database: `e-gringotts`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `userId` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `dob` date NOT NULL,
  `address` varchar(255) NOT NULL,
  `status` int(11) NOT NULL,
  `category` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`userId`, `username`, `full_name`, `password`, `email`, `phone`, `dob`, `address`, `status`, `category`) VALUES
(1, 'admin', 'admin', '201bce2458f00a54130c695ca8d1658319b32206d495adf175847b57bd4a4151', 'linwu212@gmail.com', 'admin', '2024-05-22', 'admin', 2, 4),
(17, 'Big Deeck', 'LIM JIAN CHUEN', '01ad0606cf29a76fe488b27ebfe804cb635483e82f257023cef2fdc056652c39', 'poseidonapollo11@gmail.com', '0123456789', '1890-01-08', 'KINABALU RESIDENTIAL COLLEGE', 2, 2),
(18, 'MyBoy', 'Wong Hoong Liang', '602e6e2dcc123a91aa8d9021d9b87655438c1657b060438b0db1de906e7ef312', 'hoongliang03@gmail.com', '01159996969', '2018-01-09', 'KINABALU RESIDENTIAL COLLEGE', 2, 1),
(21, 'lincry', 'ONG HAN LIN', 'ba10a4a9d3f00888d695ffb11312525c9758288a59256ab9f805ff9a06608bb2', 'onghanlin48@gmail.com', '0132738352', '2001-02-12', 'lot 182 kampung pemindahan', 2, 3),
(22, 'um', 'University Malaya', 'd9e350f0e5c295d2d64bb8f68a39188347b9d9eeb62ec852e8170b41e5ac6798', '23004928@siswa.um.edu.my', '01234567890', '2024-06-01', 'University Malaya', 2, 3);

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `currency` int(11) NOT NULL,
  `balance` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`currency`, `balance`) VALUES
(1, 0),
(2, 0),
(3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `amount`
--

CREATE TABLE `amount` (
  `id` int(255) NOT NULL,
  `cid` int(11) NOT NULL,
  `amount` double NOT NULL,
  `userid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `amount`
--

INSERT INTO `amount` (`id`, `cid`, `amount`, `userid`) VALUES
(17, 1, 0, 17),
(18, 2, 0, 17),
(19, 3, 0, 17),
(20, 1, 0, 18),
(21, 2, 0, 18),
(22, 3, 0, 18),
(29, 1, 0, 21),
(30, 2, 0, 21),
(31, 3, 0, 21),
(32, 1, 0, 22),
(33, 2, 0, 22),
(34, 3, 0, 22);

-- --------------------------------------------------------

--
-- Table structure for table `card`
--

CREATE TABLE `card` (
  `number` varchar(255) NOT NULL,
  `mmyy` varchar(255) NOT NULL,
  `cvv` varchar(255) NOT NULL,
  `PIN` varchar(255) DEFAULT NULL,
  `id` int(11) NOT NULL,
  `try` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `card`
--

INSERT INTO `card` (`number`, `mmyy`, `cvv`, `PIN`, `id`, `try`) VALUES
('48395392477909159', '629', '199', 'e0c0976260dc7294d1264d0482ea8ba47c9324ca2c0f1883af981ab4c4118e99', 21, 0);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `discount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `discount`) VALUES
(1, 'Golden Galleon', 0),
(2, 'Silver Snitch', 10),
(3, 'Platinum Patronus', 20),
(4, 'admin', 100),
(5, 'no member', 0);

-- --------------------------------------------------------

--
-- Table structure for table `currency`
--

CREATE TABLE `currency` (
  `id` int(11) NOT NULL,
  `currency` varchar(11) NOT NULL,
  `short` varchar(255) NOT NULL,
  `v` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `currency`
--

INSERT INTO `currency` (`id`, `currency`, `short`, `v`) VALUES
(1, 'Knut', 'K', 14297),
(2, 'Sickle', 'S', 414613),
(3, 'Galleon', 'G', 7048421);

-- --------------------------------------------------------

--
-- Table structure for table `favourite`
--

CREATE TABLE `favourite` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `favourite` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `favourite`
--

INSERT INTO `favourite` (`id`, `user_id`, `favourite`) VALUES
(49, 21, 18);

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `id` int(11) NOT NULL,
  `invoice` varchar(255) NOT NULL,
  `form` int(11) NOT NULL,
  `receive` int(11) NOT NULL,
  `amount` double NOT NULL,
  `currency` int(11) NOT NULL,
  `date` date NOT NULL,
  `category` varchar(255) NOT NULL,
  `reference` varchar(255) NOT NULL,
  `status` varchar(11) NOT NULL,
  `user` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `image`
--

CREATE TABLE `image` (
  `id` int(11) NOT NULL,
  `path` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `image`
--

INSERT INTO `image` (`id`, `path`) VALUES
(5, 'Group 12.png'),
(6, 'Group 13.png'),
(7, 'Group 14.png'),
(8, 'Group 17.png');

-- --------------------------------------------------------

--
-- Table structure for table `proccessing`
--

CREATE TABLE `proccessing` (
  `id` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `c_id` int(11) NOT NULL,
  `value` double NOT NULL,
  `fee` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proccessing`
--

INSERT INTO `proccessing` (`id`, `cid`, `c_id`, `value`, `fee`) VALUES
(1, 1, 3, 493, 1),
(2, 1, 2, 29, 20),
(3, 2, 3, 17, 8),
(4, 2, 1, 0.034482758620689655, 3),
(5, 3, 1, 0.002028397565922921, 5),
(6, 3, 2, 0.05882, 12);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`userId`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `category` (`category`);

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`currency`);

--
-- Indexes for table `amount`
--
ALTER TABLE `amount`
  ADD PRIMARY KEY (`id`),
  ADD KEY `currency` (`cid`),
  ADD KEY `user_id` (`userid`);

--
-- Indexes for table `card`
--
ALTER TABLE `card`
  ADD PRIMARY KEY (`number`),
  ADD KEY `id_c` (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currency`
--
ALTER TABLE `currency`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `short` (`short`);

--
-- Indexes for table `favourite`
--
ALTER TABLE `favourite`
  ADD PRIMARY KEY (`id`),
  ADD KEY `from` (`user_id`),
  ADD KEY `fa` (`favourite`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `currency` (`currency`);

--
-- Indexes for table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `proccessing`
--
ALTER TABLE `proccessing`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cid` (`cid`),
  ADD KEY `c_id` (`c_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account`
--
ALTER TABLE `account`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `amount`
--
ALTER TABLE `amount`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `currency`
--
ALTER TABLE `currency`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `favourite`
--
ALTER TABLE `favourite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=204;

--
-- AUTO_INCREMENT for table `image`
--
ALTER TABLE `image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `proccessing`
--
ALTER TABLE `proccessing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account`
--
ALTER TABLE `account`
  ADD CONSTRAINT `category` FOREIGN KEY (`category`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`currency`) REFERENCES `currency` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `amount`
--
ALTER TABLE `amount`
  ADD CONSTRAINT `currency` FOREIGN KEY (`cid`) REFERENCES `currency` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_id` FOREIGN KEY (`userid`) REFERENCES `account` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `card`
--
ALTER TABLE `card`
  ADD CONSTRAINT `id_c` FOREIGN KEY (`id`) REFERENCES `account` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `favourite`
--
ALTER TABLE `favourite`
  ADD CONSTRAINT `fa` FOREIGN KEY (`favourite`) REFERENCES `account` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `from` FOREIGN KEY (`user_id`) REFERENCES `account` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `history`
--
ALTER TABLE `history`
  ADD CONSTRAINT `history_ibfk_1` FOREIGN KEY (`currency`) REFERENCES `currency` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `proccessing`
--
ALTER TABLE `proccessing`
  ADD CONSTRAINT `proccessing_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `currency` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `proccessing_ibfk_2` FOREIGN KEY (`c_id`) REFERENCES `currency` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
