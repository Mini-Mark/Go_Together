-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 01, 2023 at 12:28 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gotogetherapi`
--

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `postID` int(2) NOT NULL,
  `locationSource` varchar(255) DEFAULT NULL,
  `locationDestination` varchar(255) DEFAULT NULL,
  `seat` int(2) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `online` varchar(255) DEFAULT NULL,
  `userID` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`postID`, `locationSource`, `locationDestination`, `seat`, `status`, `online`, `userID`) VALUES
(11, 'KBBU2', 'LOPBURI2', 4, NULL, 'True', 3),
(12, 'KBBU2', 'LOPBURI2', 4, NULL, 'True', 2);

-- --------------------------------------------------------

--
-- Table structure for table `seat`
--

CREATE TABLE `seat` (
  `ID` int(11) NOT NULL,
  `userID_rider` int(2) NOT NULL,
  `userID` int(2) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `seat`
--

INSERT INTO `seat` (`ID`, `userID_rider`, `userID`, `status`) VALUES
(4, 3, 2, '1'),
(5, 3, 1, '1'),
(6, 3, 4, '1'),
(7, 3, 5, '1'),
(8, 3, 6, '0'),
(9, 3, 7, '0'),
(10, 3, 8, '0'),
(11, 3, 9, '0'),
(12, 2, 10, '0');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userID` int(2) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `tel` varchar(255) NOT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `licenseNo` varchar(255) DEFAULT NULL,
  `drivingLicense` varchar(255) DEFAULT NULL,
  `carImage` varchar(255) DEFAULT NULL,
  `carLicense` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userID`, `email`, `password`, `name`, `tel`, `brand`, `model`, `color`, `licenseNo`, `drivingLicense`, `carImage`, `carLicense`) VALUES
(2, '64015172@kmitl.ac.th', '$2b$10$DY0mZjSemox66EVFgxsHuOUH7hmRfOQwV46eLQU5BMaONqSnKSHSm', 'Mon', '0990123434', 'honda', 'msx-125', 'white', 'กช 9235', 'Photo', 'Photo', 'Photo'),
(3, '64015170@kmitl.ac.th', '$2b$10$m9oYdYlzXgb3GAphWiMh7uBCBSe1xNRRVGgrPP04pxr2UAduC0zQS', 'Mon', '0909528827', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, '64015171@kmitl.ac.th', '$2b$10$f8IwOIFsy.bPii72/Cg7QOfuTEu/JuNZJeBpE1i4nidBXcGr1wG/i', 'Mon', '0909528827', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, '5922040@kmitl.ac.th', '$2b$10$Fl9FUT6hvkvRzFnvcjKSzuZZ99QDhMHYVqlli4NtwVCom0Q/F.uXO', 'Mon', '0909528827', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, '5922040043@kmitl.ac.th', '$2b$10$BqvxEdCY6N0stMFKA/.fQeMOnaVhLCOuCOUBdg2dVAf0aRlZoQYIO', 'Mon', '0909528827', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`postID`);

--
-- Indexes for table `seat`
--
ALTER TABLE `seat`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `post`
--
ALTER TABLE `post`
  MODIFY `postID` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `seat`
--
ALTER TABLE `seat`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userID` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
