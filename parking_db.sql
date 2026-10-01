-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 01, 2026 at 07:25 PM
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
  `plate` varchar(20) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `parking_slots`
--

INSERT INTO `parking_slots` (`id`, `zone`, `is_occupied`, `plate`) VALUES
('A01', 'A', 1, '23'),
('A02', 'A', 0, ''),
('A03', 'A', 0, ''),
('A04', 'A', 0, ''),
('A05', 'A', 0, ''),
('A06', 'A', 0, ''),
('A07', 'A', 0, ''),
('A08', 'A', 0, ''),
('A09', 'A', 0, ''),
('A10', 'A', 0, ''),
('A11', 'A', 1, '45'),
('A12', 'A', 0, ''),
('A13', 'A', 0, ''),
('A14', 'A', 0, ''),
('A15', 'A', 0, ''),
('A16', 'A', 0, ''),
('A17', 'A', 0, ''),
('A18', 'A', 0, ''),
('A19', 'A', 0, ''),
('A20', 'A', 0, ''),
('A21', 'A', 0, ''),
('A22', 'A', 0, ''),
('A23', 'A', 0, ''),
('A24', 'A', 0, ''),
('A25', 'A', 0, ''),
('A26', 'A', 0, ''),
('A27', 'A', 0, ''),
('A28', 'A', 0, ''),
('A29', 'A', 0, ''),
('A30', 'A', 0, ''),
('A31', 'A', 0, ''),
('A32', 'A', 0, ''),
('A33', 'A', 0, ''),
('A34', 'A', 0, ''),
('A35', 'A', 1, 'ถถ'),
('A36', 'A', 0, ''),
('A37', 'A', 0, ''),
('A38', 'A', 0, ''),
('A39', 'A', 0, ''),
('A40', 'A', 0, ''),
('A41', 'A', 0, ''),
('A42', 'A', 0, ''),
('A43', 'A', 0, ''),
('A44', 'A', 0, ''),
('A45', 'A', 0, ''),
('A46', 'A', 0, ''),
('A47', 'A', 0, ''),
('A48', 'A', 0, ''),
('A49', 'A', 0, ''),
('A50', 'A', 0, ''),
('A51', 'A', 0, ''),
('A52', 'A', 0, ''),
('A53', 'A', 0, ''),
('A54', 'A', 0, ''),
('A55', 'A', 0, ''),
('A56', 'A', 0, ''),
('B01', 'B', 0, ''),
('B02', 'B', 0, ''),
('B03', 'B', 0, ''),
('B04', 'B', 0, ''),
('B05', 'B', 0, ''),
('B06', 'B', 0, ''),
('B07', 'B', 1, '32'),
('B08', 'B', 0, ''),
('B09', 'B', 0, ''),
('B10', 'B', 0, ''),
('B11', 'B', 0, ''),
('B12', 'B', 0, ''),
('B13', 'B', 0, ''),
('B14', 'B', 0, ''),
('B15', 'B', 0, ''),
('B16', 'B', 0, ''),
('B17', 'B', 0, ''),
('B18', 'B', 0, ''),
('B19', 'B', 0, ''),
('B20', 'B', 0, ''),
('B21', 'B', 0, ''),
('B22', 'B', 0, ''),
('B23', 'B', 0, ''),
('B24', 'B', 0, ''),
('B25', 'B', 0, ''),
('B26', 'B', 0, ''),
('B27', 'B', 0, ''),
('B28', 'B', 0, ''),
('B29', 'B', 0, ''),
('B30', 'B', 0, ''),
('B31', 'B', 0, ''),
('B32', 'B', 0, ''),
('B33', 'B', 0, ''),
('B34', 'B', 0, ''),
('B35', 'B', 0, ''),
('B36', 'B', 0, ''),
('B37', 'B', 0, ''),
('B38', 'B', 0, ''),
('B39', 'B', 0, ''),
('B40', 'B', 0, ''),
('B41', 'B', 0, ''),
('B42', 'B', 0, ''),
('B43', 'B', 0, ''),
('B44', 'B', 0, ''),
('B45', 'B', 0, ''),
('B46', 'B', 0, ''),
('B47', 'B', 0, ''),
('B48', 'B', 0, ''),
('B49', 'B', 0, ''),
('B50', 'B', 0, ''),
('B51', 'B', 0, ''),
('B52', 'B', 0, ''),
('B53', 'B', 0, ''),
('C01', 'C', 0, ''),
('C02', 'C', 0, ''),
('C03', 'C', 0, ''),
('C04', 'C', 0, ''),
('C05', 'C', 0, ''),
('C06', 'C', 0, ''),
('C07', 'C', 0, ''),
('C08', 'C', 0, ''),
('C09', 'C', 0, ''),
('C10', 'C', 0, ''),
('C11', 'C', 0, ''),
('C12', 'C', 0, ''),
('C13', 'C', 0, ''),
('C14', 'C', 0, ''),
('C15', 'C', 0, ''),
('C16', 'C', 0, ''),
('C17', 'C', 0, ''),
('C18', 'C', 0, ''),
('C19', 'C', 0, ''),
('C20', 'C', 0, ''),
('C21', 'C', 0, ''),
('C22', 'C', 0, ''),
('C23', 'C', 0, ''),
('C24', 'C', 0, ''),
('C25', 'C', 0, ''),
('C26', 'C', 0, ''),
('C27', 'C', 0, ''),
('C28', 'C', 0, ''),
('C29', 'C', 0, ''),
('C30', 'C', 0, ''),
('C31', 'C', 0, ''),
('C32', 'C', 0, ''),
('C33', 'C', 0, ''),
('C34', 'C', 0, ''),
('C35', 'C', 0, ''),
('C36', 'C', 0, ''),
('C37', 'C', 0, ''),
('C38', 'C', 0, ''),
('C39', 'C', 0, ''),
('C40', 'C', 0, ''),
('C41', 'C', 0, ''),
('C42', 'C', 0, ''),
('C43', 'C', 0, ''),
('C44', 'C', 0, ''),
('C45', 'C', 0, ''),
('C46', 'C', 0, ''),
('C47', 'C', 0, ''),
('C48', 'C', 0, ''),
('C49', 'C', 0, ''),
('C50', 'C', 0, ''),
('C51', 'C', 0, ''),
('C52', 'C', 0, ''),
('C53', 'C', 0, ''),
('D01', 'D', 0, ''),
('D02', 'D', 0, ''),
('D03', 'D', 0, ''),
('D04', 'D', 0, ''),
('D05', 'D', 0, ''),
('D06', 'D', 0, ''),
('D07', 'D', 0, ''),
('D08', 'D', 0, ''),
('D09', 'D', 0, ''),
('D10', 'D', 0, ''),
('D11', 'D', 0, ''),
('D12', 'D', 0, ''),
('D13', 'D', 0, ''),
('D14', 'D', 0, ''),
('D15', 'D', 0, ''),
('D16', 'D', 0, ''),
('D17', 'D', 0, ''),
('D18', 'D', 0, ''),
('D19', 'D', 0, ''),
('D20', 'D', 0, ''),
('D21', 'D', 0, ''),
('D22', 'D', 0, ''),
('D23', 'D', 0, ''),
('D24', 'D', 0, ''),
('D25', 'D', 0, ''),
('D26', 'D', 0, ''),
('D27', 'D', 0, ''),
('D28', 'D', 0, ''),
('D29', 'D', 0, ''),
('D30', 'D', 0, ''),
('D31', 'D', 0, ''),
('D32', 'D', 0, ''),
('D33', 'D', 0, ''),
('D34', 'D', 0, ''),
('D35', 'D', 0, ''),
('D36', 'D', 0, ''),
('D37', 'D', 0, ''),
('D38', 'D', 0, ''),
('D39', 'D', 0, ''),
('D40', 'D', 0, ''),
('D41', 'D', 0, ''),
('D42', 'D', 0, ''),
('D43', 'D', 0, ''),
('D44', 'D', 0, ''),
('D45', 'D', 0, ''),
('D46', 'D', 0, ''),
('D47', 'D', 0, ''),
('D48', 'D', 0, ''),
('D49', 'D', 0, ''),
('D50', 'D', 0, ''),
('D51', 'D', 0, ''),
('D52', 'D', 0, ''),
('D53', 'D', 0, ''),
('D54', 'D', 0, ''),
('D55', 'D', 0, ''),
('D56', 'D', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`) VALUES
(1, 'admin', '1234'),
(2, '12', '$2y$10$NrdD5p3S.6xt0yNBZDzlVumZdu73URPTjLrzcsqxJW36083fleU..');

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
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
