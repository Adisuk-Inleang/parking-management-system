-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 01, 2026 at 09:51 PM
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
-- Database: `parking_db`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `InitSlots` ()   BEGIN
    DECLARE i INT DEFAULT 1;
    IF (SELECT COUNT(*) FROM parking_slots) = 0 THEN
        WHILE i <= 56 DO
            INSERT INTO parking_slots (id, zone) VALUES (CONCAT('A', LPAD(i, 2, '0')), 'A');
            SET i = i + 1;
        END WHILE;
        SET i = 1;
        WHILE i <= 53 DO
            INSERT INTO parking_slots (id, zone) VALUES (CONCAT('B', LPAD(i, 2, '0')), 'B');
            INSERT INTO parking_slots (id, zone) VALUES (CONCAT('C', LPAD(i, 2, '0')), 'C');
            SET i = i + 1;
        END WHILE;
        SET i = 1;
        WHILE i <= 56 DO
            INSERT INTO parking_slots (id, zone) VALUES (CONCAT('D', LPAD(i, 2, '0')), 'D');
            SET i = i + 1;
        END WHILE;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `parking_slots`
--

CREATE TABLE `parking_slots` (
  `id` varchar(10) NOT NULL,
  `zone` varchar(5) NOT NULL,
  `is_occupied` tinyint(1) DEFAULT 0,
  `plate` varchar(20) DEFAULT '',
  `is_reserved` tinyint(1) DEFAULT 0,
  `reserved_by` varchar(255) DEFAULT NULL,
  `reserved_until` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `parking_slots`
--

INSERT INTO `parking_slots` (`id`, `zone`, `is_occupied`, `plate`, `is_reserved`, `reserved_by`, `reserved_until`) VALUES
('A01', 'A', 0, NULL, 0, NULL, NULL),
('A02', 'A', 0, NULL, 0, NULL, NULL),
('A03', 'A', 0, NULL, 0, NULL, NULL),
('A04', 'A', 0, NULL, 0, NULL, NULL),
('A05', 'A', 0, NULL, 0, NULL, NULL),
('A06', 'A', 0, NULL, 0, NULL, NULL),
('A07', 'A', 0, NULL, 0, NULL, NULL),
('A08', 'A', 0, NULL, 0, NULL, NULL),
('A09', 'A', 0, NULL, 0, NULL, NULL),
('A10', 'A', 0, NULL, 0, NULL, NULL),
('A11', 'A', 0, NULL, 0, NULL, NULL),
('A12', 'A', 0, NULL, 0, NULL, NULL),
('A13', 'A', 0, NULL, 0, NULL, NULL),
('A14', 'A', 0, NULL, 0, NULL, NULL),
('A15', 'A', 0, NULL, 0, NULL, NULL),
('A16', 'A', 0, NULL, 0, NULL, NULL),
('A17', 'A', 0, NULL, 0, NULL, NULL),
('A18', 'A', 0, NULL, 0, NULL, NULL),
('A19', 'A', 0, NULL, 0, NULL, NULL),
('A20', 'A', 0, NULL, 0, NULL, NULL),
('A21', 'A', 0, NULL, 0, NULL, NULL),
('A22', 'A', 0, NULL, 0, NULL, NULL),
('A23', 'A', 0, NULL, 0, NULL, NULL),
('A24', 'A', 0, NULL, 0, NULL, NULL),
('A25', 'A', 0, NULL, 0, NULL, NULL),
('A26', 'A', 0, NULL, 0, NULL, NULL),
('A27', 'A', 0, NULL, 0, NULL, NULL),
('A28', 'A', 0, NULL, 0, NULL, NULL),
('A29', 'A', 0, NULL, 0, NULL, NULL),
('A30', 'A', 0, NULL, 0, NULL, NULL),
('A31', 'A', 0, NULL, 0, NULL, NULL),
('A32', 'A', 0, NULL, 0, NULL, NULL),
('A33', 'A', 0, NULL, 0, NULL, NULL),
('A34', 'A', 0, NULL, 0, NULL, NULL),
('A35', 'A', 0, NULL, 0, NULL, NULL),
('A36', 'A', 0, NULL, 0, NULL, NULL),
('A37', 'A', 0, NULL, 0, NULL, NULL),
('A38', 'A', 0, NULL, 0, NULL, NULL),
('A39', 'A', 0, NULL, 0, NULL, NULL),
('A40', 'A', 0, NULL, 0, NULL, NULL),
('A41', 'A', 0, NULL, 0, NULL, NULL),
('A42', 'A', 0, NULL, 0, NULL, NULL),
('A43', 'A', 0, NULL, 0, NULL, NULL),
('A44', 'A', 0, NULL, 0, NULL, NULL),
('A45', 'A', 0, NULL, 0, NULL, NULL),
('A46', 'A', 0, NULL, 0, NULL, NULL),
('A47', 'A', 0, NULL, 0, NULL, NULL),
('A48', 'A', 0, NULL, 0, NULL, NULL),
('A49', 'A', 0, NULL, 0, NULL, NULL),
('A50', 'A', 0, NULL, 0, NULL, NULL),
('A51', 'A', 0, NULL, 0, NULL, NULL),
('A52', 'A', 0, NULL, 0, NULL, NULL),
('A53', 'A', 0, NULL, 0, NULL, NULL),
('A54', 'A', 0, NULL, 0, NULL, NULL),
('A55', 'A', 0, NULL, 0, NULL, NULL),
('A56', 'A', 0, NULL, 0, NULL, NULL),
('B01', 'B', 0, NULL, 0, NULL, NULL),
('B02', 'B', 0, NULL, 0, NULL, NULL),
('B03', 'B', 0, NULL, 0, NULL, NULL),
('B04', 'B', 0, NULL, 0, NULL, NULL),
('B05', 'B', 0, NULL, 0, NULL, NULL),
('B06', 'B', 0, NULL, 0, NULL, NULL),
('B07', 'B', 0, NULL, 0, NULL, NULL),
('B08', 'B', 0, NULL, 0, NULL, NULL),
('B09', 'B', 0, NULL, 0, NULL, NULL),
('B10', 'B', 0, NULL, 0, NULL, NULL),
('B11', 'B', 0, NULL, 0, NULL, NULL),
('B12', 'B', 0, NULL, 0, NULL, NULL),
('B13', 'B', 0, NULL, 0, NULL, NULL),
('B14', 'B', 0, NULL, 0, NULL, NULL),
('B15', 'B', 0, NULL, 0, NULL, NULL),
('B16', 'B', 0, NULL, 0, NULL, NULL),
('B17', 'B', 0, NULL, 0, NULL, NULL),
('B18', 'B', 0, NULL, 0, NULL, NULL),
('B19', 'B', 0, NULL, 0, NULL, NULL),
('B20', 'B', 0, NULL, 0, NULL, NULL),
('B21', 'B', 0, NULL, 0, NULL, NULL),
('B22', 'B', 0, NULL, 0, NULL, NULL),
('B23', 'B', 0, NULL, 0, NULL, NULL),
('B24', 'B', 0, NULL, 0, NULL, NULL),
('B25', 'B', 0, NULL, 0, NULL, NULL),
('B26', 'B', 0, NULL, 0, NULL, NULL),
('B27', 'B', 0, NULL, 0, NULL, NULL),
('B28', 'B', 0, NULL, 0, NULL, NULL),
('B29', 'B', 0, NULL, 0, NULL, NULL),
('B30', 'B', 0, NULL, 0, NULL, NULL),
('B31', 'B', 0, NULL, 0, NULL, NULL),
('B32', 'B', 0, NULL, 0, NULL, NULL),
('B33', 'B', 0, NULL, 0, NULL, NULL),
('B34', 'B', 0, NULL, 0, NULL, NULL),
('B35', 'B', 0, NULL, 0, NULL, NULL),
('B36', 'B', 0, NULL, 0, NULL, NULL),
('B37', 'B', 0, NULL, 0, NULL, NULL),
('B38', 'B', 0, NULL, 0, NULL, NULL),
('B39', 'B', 0, NULL, 0, NULL, NULL),
('B40', 'B', 0, NULL, 0, NULL, NULL),
('B41', 'B', 0, NULL, 0, NULL, NULL),
('B42', 'B', 0, NULL, 0, NULL, NULL),
('B43', 'B', 0, NULL, 0, NULL, NULL),
('B44', 'B', 0, NULL, 0, NULL, NULL),
('B45', 'B', 0, NULL, 0, NULL, NULL),
('B46', 'B', 0, NULL, 0, NULL, NULL),
('B47', 'B', 0, NULL, 0, NULL, NULL),
('B48', 'B', 0, NULL, 0, NULL, NULL),
('B49', 'B', 0, NULL, 0, NULL, NULL),
('B50', 'B', 0, NULL, 0, NULL, NULL),
('B51', 'B', 0, NULL, 0, NULL, NULL),
('B52', 'B', 0, NULL, 0, NULL, NULL),
('B53', 'B', 0, NULL, 0, NULL, NULL),
('C01', 'C', 0, NULL, 0, NULL, NULL),
('C02', 'C', 0, NULL, 0, NULL, NULL),
('C03', 'C', 0, NULL, 0, NULL, NULL),
('C04', 'C', 0, NULL, 0, NULL, NULL),
('C05', 'C', 0, NULL, 0, NULL, NULL),
('C06', 'C', 0, NULL, 0, NULL, NULL),
('C07', 'C', 0, NULL, 0, NULL, NULL),
('C08', 'C', 0, NULL, 0, NULL, NULL),
('C09', 'C', 0, NULL, 0, NULL, NULL),
('C10', 'C', 0, NULL, 0, NULL, NULL),
('C11', 'C', 0, NULL, 0, NULL, NULL),
('C12', 'C', 0, NULL, 0, NULL, NULL),
('C13', 'C', 0, NULL, 0, NULL, NULL),
('C14', 'C', 0, NULL, 0, NULL, NULL),
('C15', 'C', 0, NULL, 0, NULL, NULL),
('C16', 'C', 0, NULL, 0, NULL, NULL),
('C17', 'C', 0, NULL, 0, NULL, NULL),
('C18', 'C', 0, NULL, 0, NULL, NULL),
('C19', 'C', 0, NULL, 0, NULL, NULL),
('C20', 'C', 0, NULL, 0, NULL, NULL),
('C21', 'C', 0, NULL, 0, NULL, NULL),
('C22', 'C', 0, NULL, 0, NULL, NULL),
('C23', 'C', 0, NULL, 0, NULL, NULL),
('C24', 'C', 0, NULL, 0, NULL, NULL),
('C25', 'C', 0, NULL, 0, NULL, NULL),
('C26', 'C', 0, NULL, 0, NULL, NULL),
('C27', 'C', 0, NULL, 0, NULL, NULL),
('C28', 'C', 0, NULL, 0, NULL, NULL),
('C29', 'C', 0, NULL, 0, NULL, NULL),
('C30', 'C', 0, NULL, 0, NULL, NULL),
('C31', 'C', 0, NULL, 0, NULL, NULL),
('C32', 'C', 0, NULL, 0, NULL, NULL),
('C33', 'C', 0, NULL, 0, NULL, NULL),
('C34', 'C', 0, NULL, 0, NULL, NULL),
('C35', 'C', 0, NULL, 0, NULL, NULL),
('C36', 'C', 0, NULL, 0, NULL, NULL),
('C37', 'C', 0, NULL, 0, NULL, NULL),
('C38', 'C', 0, NULL, 0, NULL, NULL),
('C39', 'C', 0, NULL, 0, NULL, NULL),
('C40', 'C', 0, NULL, 0, NULL, NULL),
('C41', 'C', 0, NULL, 0, NULL, NULL),
('C42', 'C', 0, NULL, 0, NULL, NULL),
('C43', 'C', 0, NULL, 0, NULL, NULL),
('C44', 'C', 0, NULL, 0, NULL, NULL),
('C45', 'C', 0, NULL, 0, NULL, NULL),
('C46', 'C', 0, NULL, 0, NULL, NULL),
('C47', 'C', 0, NULL, 0, NULL, NULL),
('C48', 'C', 0, NULL, 0, NULL, NULL),
('C49', 'C', 0, NULL, 0, NULL, NULL),
('C50', 'C', 0, NULL, 0, NULL, NULL),
('C51', 'C', 0, NULL, 0, NULL, NULL),
('C52', 'C', 0, NULL, 0, NULL, NULL),
('C53', 'C', 0, NULL, 0, NULL, NULL),
('D01', 'D', 0, NULL, 0, NULL, NULL),
('D02', 'D', 0, NULL, 0, NULL, NULL),
('D03', 'D', 0, NULL, 0, NULL, NULL),
('D04', 'D', 0, NULL, 0, NULL, NULL),
('D05', 'D', 0, NULL, 0, NULL, NULL),
('D06', 'D', 0, NULL, 0, NULL, NULL),
('D07', 'D', 0, NULL, 0, NULL, NULL),
('D08', 'D', 0, NULL, 0, NULL, NULL),
('D09', 'D', 0, NULL, 0, NULL, NULL),
('D10', 'D', 0, NULL, 0, NULL, NULL),
('D11', 'D', 0, NULL, 0, NULL, NULL),
('D12', 'D', 0, NULL, 0, NULL, NULL),
('D13', 'D', 0, NULL, 0, NULL, NULL),
('D14', 'D', 0, NULL, 0, NULL, NULL),
('D15', 'D', 0, NULL, 0, NULL, NULL),
('D16', 'D', 0, NULL, 0, NULL, NULL),
('D17', 'D', 0, NULL, 0, NULL, NULL),
('D18', 'D', 0, NULL, 0, NULL, NULL),
('D19', 'D', 0, NULL, 0, NULL, NULL),
('D20', 'D', 0, NULL, 0, NULL, NULL),
('D21', 'D', 0, NULL, 0, NULL, NULL),
('D22', 'D', 0, NULL, 0, NULL, NULL),
('D23', 'D', 0, NULL, 0, NULL, NULL),
('D24', 'D', 0, NULL, 0, NULL, NULL),
('D25', 'D', 0, NULL, 0, NULL, NULL),
('D26', 'D', 0, NULL, 0, NULL, NULL),
('D27', 'D', 0, NULL, 0, NULL, NULL),
('D28', 'D', 0, NULL, 0, NULL, NULL),
('D29', 'D', 0, NULL, 0, NULL, NULL),
('D30', 'D', 0, NULL, 0, NULL, NULL),
('D31', 'D', 0, NULL, 0, NULL, NULL),
('D32', 'D', 0, NULL, 0, NULL, NULL),
('D33', 'D', 0, NULL, 0, NULL, NULL),
('D34', 'D', 0, NULL, 0, NULL, NULL),
('D35', 'D', 0, NULL, 0, NULL, NULL),
('D36', 'D', 0, NULL, 0, NULL, NULL),
('D37', 'D', 0, NULL, 0, NULL, NULL),
('D38', 'D', 0, NULL, 0, NULL, NULL),
('D39', 'D', 0, NULL, 0, NULL, NULL),
('D40', 'D', 0, NULL, 0, NULL, NULL),
('D41', 'D', 0, NULL, 0, NULL, NULL),
('D42', 'D', 0, NULL, 0, NULL, NULL),
('D43', 'D', 0, NULL, 0, NULL, NULL),
('D44', 'D', 0, NULL, 0, NULL, NULL),
('D45', 'D', 0, NULL, 0, NULL, NULL),
('D46', 'D', 0, NULL, 0, NULL, NULL),
('D47', 'D', 0, NULL, 0, NULL, NULL),
('D48', 'D', 0, NULL, 0, NULL, NULL),
('D49', 'D', 0, NULL, 0, NULL, NULL),
('D50', 'D', 0, NULL, 0, NULL, NULL),
('D51', 'D', 0, NULL, 0, NULL, NULL),
('D52', 'D', 0, NULL, 0, NULL, NULL),
('D53', 'D', 0, NULL, 0, NULL, NULL),
('D54', 'D', 0, NULL, 0, NULL, NULL),
('D55', 'D', 0, NULL, 0, NULL, NULL),
('D56', 'D', 0, NULL, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('student','staff') DEFAULT 'student'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `role`) VALUES
(3, 'adisuk.inl67@psru.ac.th', '23042549', 'student'),
(4, 'admin@psru.ac.th', '$2y$10$iTT8OLGftYQ/7QnIoh7QyeB8tLONw2SBIJOlLXncc/n/VtVf1IXqW', 'staff');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `parking_slots`
--
ALTER TABLE `parking_slots`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
