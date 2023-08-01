-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 11, 2023 at 03:40 PM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `idm_exhibition`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`dev`@`localhost` PROCEDURE `list_present` (IN `flag` VARCHAR(255))  BEGIN			
  SELECT
		present_id,
    present_name,
    present_type,
		present_flag,
    present_image
FROM tab_present p
JOIN (
    SELECT @rownum := @rownum + 1 AS num FROM table_temp_present p2 , (select @rownum := 0) r
) n ON n.num <= p.present_stock
WHERE 1 = 1 AND
present_flag LIKE CONCAT('%',flag,'%')
ORDER BY present_id;
END$$

CREATE DEFINER=`dev`@`localhost` PROCEDURE `list_prize` ()  BEGIN
  SELECT
    prize_id,
    prize_name,
    prize_image
FROM tab_prize p
JOIN (
    SELECT @rownum := @rownum + 1 AS num FROM tab_participants p2 , (select @rownum := 0) r
) n ON n.num <= p.prize_stock
ORDER BY prize_id;
END$$

CREATE DEFINER=`dev`@`localhost` PROCEDURE `sp_get_allow_grandprize` (IN `registration_id` INT ZEROFILL, IN `participant_name` VARCHAR(255))  NO SQL
SELECT
	*
FROM (
	SELECT
		a.registration_id,
		b.addon AS registration_date,
		b.participant_id,
		c.participant_name,
		c.participant_email,
		c.participant_wa,
		c.participant_qr,
		COUNT(a.booth_id) AS total_booth
	FROM idm_exhibition.tr_attendance a
	LEFT JOIN idm_exhibition.tr_registration b ON a.registration_id = b.registration_id
	LEFT JOIN idm_exhibition.tab_participants c ON b.participant_id = c.participant_id
	GROUP BY a.registration_id
) t1
WHERE t1.total_booth >= 4 AND t1.registration_id NOT IN (
	SELECT DISTINCT registration_id FROM idm_exhibition.tr_grandprize
    WHERE DATE(addon) = CURRENT_DATE
) AND
( t1.registration_id = registration_id OR (registration_id = 0 AND t1.registration_id LIKE '%' ) OR t1.registration_id IS NULL ) AND
t1.participant_name LIKE CONCAT('%',participant_name,'%')$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tab_booth`
--

CREATE TABLE `tab_booth` (
  `booth_id` int(11) NOT NULL,
  `booth_number` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tab_booth`
--

INSERT INTO `tab_booth` (`booth_id`, `booth_number`) VALUES
(1, 'Bali & Mandalika'),
(2, 'Wedding'),
(3, 'Java Museum'),
(4, 'Panoramic Train'),
(5, 'Candy Store'),
(6, 'booth_6'),
(7, 'booth_7'),
(8, 'booth_8'),
(9, 'booth_9');

-- --------------------------------------------------------

--
-- Table structure for table `tab_gift`
--

CREATE TABLE `tab_gift` (
  `gift_id` int(11) NOT NULL,
  `gift_name` varchar(255) NOT NULL,
  `gift_file` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tab_gift`
--

INSERT INTO `tab_gift` (`gift_id`, `gift_name`, `gift_file`) VALUES
(1, 'Hotel Room \r\nDiscount Voucher', 'motorlistrik.png'),
(2, 'Hotel Dining \r\n Discount Voucher', 'sepedagunung.png'),
(3, 'Hotel Spa \r\nDiscount Voucher', 'sepedalipat.png'),
(4, 'Hotel Gift', 'motorlistrik.png');

-- --------------------------------------------------------

--
-- Table structure for table `tab_participants`
--

CREATE TABLE `tab_participants` (
  `participant_id` int(11) NOT NULL,
  `participant_name` varchar(255) NOT NULL,
  `participant_email` varchar(255) NOT NULL,
  `participant_wa` varchar(255) NOT NULL,
  `participant_qr` varchar(255) NOT NULL,
  `addon` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tab_participants`
--

INSERT INTO `tab_participants` (`participant_id`, `participant_name`, `participant_email`, `participant_wa`, `participant_qr`, `addon`) VALUES
(1, 'Participant 1', 'seftianalfredo.9@gmail.com', '0123456789', 'c4ca4238a0b923820dcc509a6f75849b.png', '2023-02-10 14:04:26'),
(2, 'Participant 2', 'seftianalfredo.9@gmail.com', '0123456789', '', '2023-02-10 14:04:26'),
(3, 'Participant 3', 'seftianalfredo.9@gmail.com', '0123456789', '', '2023-02-10 14:04:26'),
(4, 'Participant 4', 'seftianalfredo.9@gmail.com', '0123456789', '', '2023-02-10 14:04:26'),
(5, 'Participant 5', 'seftianalfredo.9@gmail.com', '0123456789', '', '2023-02-10 14:04:26'),
(6, 'Participant 6', 'seftianalfredo.9@gmail.com', '0123456789', '', '2023-02-10 14:04:26'),
(7, 'Participant 7', 'seftianalfredo.9@gmail.com', '0123456789', '', '2023-02-10 14:04:26'),
(8, 'Participant 8', 'seftianalfredo.9@gmail.com', '0123456789', '', '2023-02-10 14:04:26'),
(9, 'Participant 9', 'seftianalfredo.9@gmail.com', '0123456789', '', '2023-02-10 14:04:26'),
(10, 'Participant 10', 'seftianalfredo.9@gmail.com', '0123456789', '', '2023-02-10 14:04:26');

-- --------------------------------------------------------

--
-- Table structure for table `tab_user`
--

CREATE TABLE `tab_user` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `user_pass` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tab_user`
--

INSERT INTO `tab_user` (`user_id`, `user_name`, `user_pass`) VALUES
(1, 'admin', 'd54e5ae10222d681124b795096598b65'),
(2, 'developer', '92ffac9bb4cf1f872bfb8dafb3a44864');

-- --------------------------------------------------------

--
-- Table structure for table `tr_attendance`
--

CREATE TABLE `tr_attendance` (
  `attendance_id` int(11) NOT NULL,
  `registration_id` int(11) DEFAULT NULL,
  `booth_id` int(11) DEFAULT NULL,
  `attendance_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tr_attendance`
--

INSERT INTO `tr_attendance` (`attendance_id`, `registration_id`, `booth_id`, `attendance_date`) VALUES
(1, 1, 1, '2023-02-15 00:00:00'),
(2, 2, 1, '2023-02-10 08:12:28'),
(3, 3, 1, '2023-02-10 08:12:31'),
(4, 4, 1, '2023-02-10 08:12:33'),
(5, 5, 1, '2023-02-10 08:12:36'),
(6, 6, 1, '2023-02-10 08:12:41'),
(7, 7, 1, '2023-02-10 08:12:44'),
(8, 8, 1, '2023-02-10 08:12:47'),
(9, 9, 1, '2023-02-10 08:12:51'),
(10, 10, 1, '2023-02-10 08:12:55'),
(11, 1, 2, '2023-02-10 08:12:25'),
(12, 2, 2, '2023-02-10 08:12:28'),
(13, 3, 2, '2023-02-10 08:12:31'),
(14, 4, 2, '2023-02-10 08:12:33'),
(15, 5, 2, '2023-02-10 08:12:36'),
(16, 6, 2, '2023-02-10 08:12:41'),
(17, 7, 2, '2023-02-10 08:12:44'),
(18, 8, 2, '2023-02-10 08:12:47'),
(19, 9, 2, '2023-02-10 08:12:51'),
(20, 10, 2, '2023-02-10 08:12:55'),
(21, 1, 3, '2023-02-10 08:12:25'),
(22, 2, 3, '2023-02-10 08:12:28'),
(23, 3, 3, '2023-02-10 08:12:31'),
(24, 4, 3, '2023-02-10 08:12:33'),
(25, 5, 3, '2023-02-10 08:12:36'),
(26, 6, 3, '2023-02-10 08:12:41'),
(27, 7, 3, '2023-02-10 08:12:44'),
(28, 8, 3, '2023-02-10 08:12:47'),
(29, 9, 3, '2023-02-10 08:12:51'),
(30, 10, 3, '2023-02-10 08:12:55'),
(31, 1, 4, '2023-02-10 08:12:25'),
(32, 2, 4, '2023-02-10 08:12:28'),
(33, 3, 4, '2023-02-10 08:12:31'),
(34, 4, 4, '2023-02-10 08:12:33'),
(35, 5, 4, '2023-02-10 08:12:36'),
(36, 6, 4, '2023-02-10 08:12:41'),
(37, 7, 4, '2023-02-10 08:12:44'),
(38, 8, 4, '2023-02-10 08:12:47'),
(39, 9, 4, '2023-02-10 08:12:51'),
(40, 10, 4, '2023-02-10 08:12:55'),
(41, 1, 5, '2023-02-10 08:12:25'),
(42, 2, 5, '2023-02-10 08:12:28'),
(43, 3, 5, '2023-02-10 08:12:31'),
(44, 4, 5, '2023-02-10 08:12:33'),
(45, 5, 5, '2023-02-10 08:12:36'),
(46, 6, 5, '2023-02-10 08:12:41'),
(47, 7, 5, '2023-02-10 08:12:44'),
(48, 8, 5, '2023-02-10 08:12:47'),
(49, 9, 5, '2023-02-10 08:12:51'),
(50, 10, 5, '2023-02-10 08:12:55');

-- --------------------------------------------------------

--
-- Table structure for table `tr_grandprize`
--

CREATE TABLE `tr_grandprize` (
  `grandprize_id` int(11) NOT NULL,
  `registration_id` int(11) NOT NULL,
  `gift_id` int(11) NOT NULL,
  `addon` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tr_grandprize`
--

INSERT INTO `tr_grandprize` (`grandprize_id`, `registration_id`, `gift_id`, `addon`) VALUES
(1, 1, 4, '2023-02-11 20:25:35'),
(2, 3, 2, '2023-02-11 20:26:02'),
(3, 5, 2, '2023-02-11 20:26:15'),
(4, 7, 1, '2023-02-11 20:26:31'),
(5, 9, 4, '2023-02-11 20:26:59');

-- --------------------------------------------------------

--
-- Table structure for table `tr_grandprize_choosen`
--

CREATE TABLE `tr_grandprize_choosen` (
  `granprize2_id` int(11) NOT NULL,
  `registration_id` int(11) NOT NULL,
  `addon` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tr_grandprize_choosen`
--

INSERT INTO `tr_grandprize_choosen` (`granprize2_id`, `registration_id`, `addon`) VALUES
(1, 8, '2023-02-11 20:27:48'),
(3, 1, '2023-02-11 20:28:25');

-- --------------------------------------------------------

--
-- Table structure for table `tr_registration`
--

CREATE TABLE `tr_registration` (
  `registration_id` int(11) NOT NULL,
  `participant_id` int(11) NOT NULL,
  `is_choosen` int(11) NOT NULL DEFAULT '0',
  `addon` datetime NOT NULL,
  `modion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tr_registration`
--

INSERT INTO `tr_registration` (`registration_id`, `participant_id`, `is_choosen`, `addon`, `modion`) VALUES
(1, 1, 1, '2023-02-10 14:04:26', '2023-02-10 14:04:26'),
(2, 2, 0, '2023-02-10 14:04:26', '2023-02-10 14:04:26'),
(3, 3, 0, '2023-02-10 14:04:26', '2023-02-10 14:04:26'),
(4, 4, 0, '2023-02-10 14:04:26', '2023-02-10 14:04:26'),
(5, 5, 1, '2023-02-10 14:04:26', '2023-02-10 14:04:26'),
(6, 6, 0, '2023-02-10 14:04:26', '2023-02-10 14:04:26'),
(7, 7, 0, '2023-02-10 14:04:26', '2023-02-10 14:04:26'),
(8, 8, 1, '2023-02-10 14:04:26', '2023-02-10 14:04:26'),
(9, 9, 0, '2023-02-10 14:04:26', '2023-02-10 14:04:26'),
(10, 10, 1, '2023-02-10 14:04:26', '2023-02-10 14:04:26');

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_allow_grandprize`
-- (See below for the actual view)
--
CREATE TABLE `view_allow_grandprize` (
`registration_id` int(11)
,`registration_date` datetime
,`participant_id` int(11)
,`participant_name` varchar(255)
,`participant_email` varchar(255)
,`participant_wa` varchar(255)
,`participant_qr` varchar(255)
,`total_booth` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_allow_grandprize_20230123`
-- (See below for the actual view)
--
CREATE TABLE `view_allow_grandprize_20230123` (
`registration_id` int(11)
,`participant_id` int(11)
,`addon` datetime
,`modion` datetime
,`participant_name` varchar(255)
,`participant_email` varchar(255)
,`participant_wa` varchar(255)
,`participant_qr` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_allow_grandprize_choosen`
-- (See below for the actual view)
--
CREATE TABLE `view_allow_grandprize_choosen` (
`registration_id` int(11)
,`participant_id` int(11)
,`registration_date` datetime
,`participant_name` varchar(255)
,`participant_email` varchar(255)
,`participant_wa` varchar(255)
,`participant_qr` varchar(255)
,`addon` datetime
,`is_choosen` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_booth_attendance`
-- (See below for the actual view)
--
CREATE TABLE `view_booth_attendance` (
`attendance_id` int(11)
,`registration_id` int(11)
,`booth_id` int(11)
,`attendance_date` datetime
,`participant_id` int(11)
,`registration_date` datetime
,`participant_name` varchar(255)
,`participant_email` varchar(255)
,`participant_wa` varchar(255)
,`participant_qr` varchar(255)
,`booth_number` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_count_booth`
-- (See below for the actual view)
--
CREATE TABLE `view_count_booth` (
`registration_id` int(11)
,`registration_date` datetime
,`participant_id` int(11)
,`participant_name` varchar(255)
,`participant_email` varchar(255)
,`participant_wa` varchar(255)
,`participant_qr` varchar(255)
,`total_booth` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_participants`
-- (See below for the actual view)
--
CREATE TABLE `view_participants` (
`participant_id` int(11)
,`participant_name` varchar(255)
,`participant_email` varchar(255)
,`participant_wa` varchar(255)
,`participant_qr` varchar(255)
,`addon` datetime
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_registration`
-- (See below for the actual view)
--
CREATE TABLE `view_registration` (
`registration_id` int(11)
,`participant_id` int(11)
,`registration_date` datetime
,`participant_name` varchar(255)
,`participant_email` varchar(255)
,`participant_wa` varchar(255)
,`participant_qr` varchar(255)
,`addon` datetime
,`is_choosen` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_report_attendance`
-- (See below for the actual view)
--
CREATE TABLE `view_report_attendance` (
`registration_id` int(11)
,`participant_id` int(11)
,`addon` datetime
,`modion` datetime
,`participant_name` varchar(255)
,`participant_email` varchar(255)
,`participant_wa` varchar(255)
,`participant_qr` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_report_grandprize_choosen`
-- (See below for the actual view)
--
CREATE TABLE `view_report_grandprize_choosen` (
`granprize2_id` int(11)
,`registration_id` int(11)
,`addon` datetime
,`participant_id` int(11)
,`participant_name` varchar(255)
,`participant_wa` varchar(255)
,`participant_email` varchar(255)
,`participant_qr` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_report_spinwheel`
-- (See below for the actual view)
--
CREATE TABLE `view_report_spinwheel` (
`grandprize_id` int(11)
,`registration_id` int(11)
,`gift_id` int(11)
,`addon` datetime
,`participant_id` int(11)
,`gift_name` varchar(255)
,`gift_file` varchar(255)
,`participant_name` varchar(255)
,`participant_email` varchar(255)
,`participant_wa` varchar(255)
,`participant_qr` varchar(255)
);

-- --------------------------------------------------------

--
-- Structure for view `view_allow_grandprize`
--
DROP TABLE IF EXISTS `view_allow_grandprize`;

CREATE ALGORITHM=UNDEFINED DEFINER=`dev`@`localhost` SQL SECURITY DEFINER VIEW `view_allow_grandprize`  AS  select `a`.`registration_id` AS `registration_id`,`a`.`registration_date` AS `registration_date`,`a`.`participant_id` AS `participant_id`,`a`.`participant_name` AS `participant_name`,`a`.`participant_email` AS `participant_email`,`a`.`participant_wa` AS `participant_wa`,`a`.`participant_qr` AS `participant_qr`,`a`.`total_booth` AS `total_booth` from `view_count_booth` `a` where ((`a`.`total_booth` >= 4) and (not(`a`.`registration_id` in (select distinct `tr_grandprize`.`registration_id` from `tr_grandprize` where (cast(`tr_grandprize`.`addon` as date) = curdate()))))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_allow_grandprize_20230123`
--
DROP TABLE IF EXISTS `view_allow_grandprize_20230123`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_allow_grandprize_20230123`  AS  select `a`.`registration_id` AS `registration_id`,`a`.`participant_id` AS `participant_id`,`a`.`addon` AS `addon`,`a`.`modion` AS `modion`,`b`.`participant_name` AS `participant_name`,`b`.`participant_email` AS `participant_email`,`b`.`participant_wa` AS `participant_wa`,`b`.`participant_qr` AS `participant_qr` from (`tr_registration` `a` left join `tab_participants` `b` on((`a`.`participant_id` = `b`.`participant_id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_allow_grandprize_choosen`
--
DROP TABLE IF EXISTS `view_allow_grandprize_choosen`;

CREATE ALGORITHM=UNDEFINED DEFINER=`dev`@`localhost` SQL SECURITY DEFINER VIEW `view_allow_grandprize_choosen`  AS  select `view_registration`.`registration_id` AS `registration_id`,`view_registration`.`participant_id` AS `participant_id`,`view_registration`.`registration_date` AS `registration_date`,`view_registration`.`participant_name` AS `participant_name`,`view_registration`.`participant_email` AS `participant_email`,`view_registration`.`participant_wa` AS `participant_wa`,`view_registration`.`participant_qr` AS `participant_qr`,`view_registration`.`addon` AS `addon`,`view_registration`.`is_choosen` AS `is_choosen` from `view_registration` where ((`view_registration`.`is_choosen` = 1) and (not(`view_registration`.`registration_id` in (select distinct `tr_grandprize_choosen`.`registration_id` from `tr_grandprize_choosen`)))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_booth_attendance`
--
DROP TABLE IF EXISTS `view_booth_attendance`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_booth_attendance`  AS  select `a`.`attendance_id` AS `attendance_id`,`a`.`registration_id` AS `registration_id`,`a`.`booth_id` AS `booth_id`,`a`.`attendance_date` AS `attendance_date`,`b`.`participant_id` AS `participant_id`,`b`.`addon` AS `registration_date`,`c`.`participant_name` AS `participant_name`,`c`.`participant_email` AS `participant_email`,`c`.`participant_wa` AS `participant_wa`,`c`.`participant_qr` AS `participant_qr`,`d`.`booth_number` AS `booth_number` from (((`tr_attendance` `a` left join `tr_registration` `b` on((`a`.`registration_id` = `b`.`registration_id`))) left join `tab_participants` `c` on((`b`.`participant_id` = `c`.`participant_id`))) left join `tab_booth` `d` on((`a`.`booth_id` = `d`.`booth_id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_count_booth`
--
DROP TABLE IF EXISTS `view_count_booth`;

CREATE ALGORITHM=UNDEFINED DEFINER=`dev`@`localhost` SQL SECURITY DEFINER VIEW `view_count_booth`  AS  select `a`.`registration_id` AS `registration_id`,`b`.`addon` AS `registration_date`,`b`.`participant_id` AS `participant_id`,`c`.`participant_name` AS `participant_name`,`c`.`participant_email` AS `participant_email`,`c`.`participant_wa` AS `participant_wa`,`c`.`participant_qr` AS `participant_qr`,count(`a`.`booth_id`) AS `total_booth` from ((`tr_attendance` `a` left join `tr_registration` `b` on((`a`.`registration_id` = `b`.`registration_id`))) left join `tab_participants` `c` on((`b`.`participant_id` = `c`.`participant_id`))) group by `a`.`registration_id` ;

-- --------------------------------------------------------

--
-- Structure for view `view_participants`
--
DROP TABLE IF EXISTS `view_participants`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_participants`  AS  select `tab_participants`.`participant_id` AS `participant_id`,`tab_participants`.`participant_name` AS `participant_name`,`tab_participants`.`participant_email` AS `participant_email`,`tab_participants`.`participant_wa` AS `participant_wa`,`tab_participants`.`participant_qr` AS `participant_qr`,`tab_participants`.`addon` AS `addon` from `tab_participants` ;

-- --------------------------------------------------------

--
-- Structure for view `view_registration`
--
DROP TABLE IF EXISTS `view_registration`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_registration`  AS  select `a`.`registration_id` AS `registration_id`,`a`.`participant_id` AS `participant_id`,`a`.`addon` AS `registration_date`,`b`.`participant_name` AS `participant_name`,`b`.`participant_email` AS `participant_email`,`b`.`participant_wa` AS `participant_wa`,`b`.`participant_qr` AS `participant_qr`,`a`.`addon` AS `addon`,`a`.`is_choosen` AS `is_choosen` from (`tr_registration` `a` left join `tab_participants` `b` on((`a`.`participant_id` = `b`.`participant_id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_report_attendance`
--
DROP TABLE IF EXISTS `view_report_attendance`;

CREATE ALGORITHM=UNDEFINED DEFINER=`dev`@`localhost` SQL SECURITY DEFINER VIEW `view_report_attendance`  AS  select `a`.`registration_id` AS `registration_id`,`a`.`participant_id` AS `participant_id`,`a`.`addon` AS `addon`,`a`.`modion` AS `modion`,`b`.`participant_name` AS `participant_name`,`b`.`participant_email` AS `participant_email`,`b`.`participant_wa` AS `participant_wa`,`b`.`participant_qr` AS `participant_qr` from (`tr_registration` `a` left join `tab_participants` `b` on((`a`.`participant_id` = `b`.`participant_id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_report_grandprize_choosen`
--
DROP TABLE IF EXISTS `view_report_grandprize_choosen`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_report_grandprize_choosen`  AS  select `a`.`granprize2_id` AS `granprize2_id`,`a`.`registration_id` AS `registration_id`,`a`.`addon` AS `addon`,`b`.`participant_id` AS `participant_id`,`c`.`participant_name` AS `participant_name`,`c`.`participant_wa` AS `participant_wa`,`c`.`participant_email` AS `participant_email`,`c`.`participant_qr` AS `participant_qr` from ((`tr_grandprize_choosen` `a` left join `tr_registration` `b` on((`a`.`registration_id` = `b`.`registration_id`))) left join `tab_participants` `c` on((`b`.`participant_id` = `c`.`participant_id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_report_spinwheel`
--
DROP TABLE IF EXISTS `view_report_spinwheel`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_report_spinwheel`  AS  select `a`.`grandprize_id` AS `grandprize_id`,`a`.`registration_id` AS `registration_id`,`a`.`gift_id` AS `gift_id`,`a`.`addon` AS `addon`,`b`.`participant_id` AS `participant_id`,`c`.`gift_name` AS `gift_name`,`c`.`gift_file` AS `gift_file`,`d`.`participant_name` AS `participant_name`,`d`.`participant_email` AS `participant_email`,`d`.`participant_wa` AS `participant_wa`,`d`.`participant_qr` AS `participant_qr` from (((`tr_grandprize` `a` left join `tr_registration` `b` on((`a`.`registration_id` = `b`.`registration_id`))) left join `tab_gift` `c` on((`a`.`gift_id` = `c`.`gift_id`))) left join `tab_participants` `d` on((`b`.`participant_id` = `d`.`participant_id`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tab_booth`
--
ALTER TABLE `tab_booth`
  ADD PRIMARY KEY (`booth_id`);

--
-- Indexes for table `tab_gift`
--
ALTER TABLE `tab_gift`
  ADD PRIMARY KEY (`gift_id`);

--
-- Indexes for table `tab_participants`
--
ALTER TABLE `tab_participants`
  ADD PRIMARY KEY (`participant_id`);

--
-- Indexes for table `tab_user`
--
ALTER TABLE `tab_user`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `tr_attendance`
--
ALTER TABLE `tr_attendance`
  ADD PRIMARY KEY (`attendance_id`);

--
-- Indexes for table `tr_grandprize`
--
ALTER TABLE `tr_grandprize`
  ADD PRIMARY KEY (`grandprize_id`);

--
-- Indexes for table `tr_grandprize_choosen`
--
ALTER TABLE `tr_grandprize_choosen`
  ADD PRIMARY KEY (`granprize2_id`);

--
-- Indexes for table `tr_registration`
--
ALTER TABLE `tr_registration`
  ADD PRIMARY KEY (`registration_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tab_booth`
--
ALTER TABLE `tab_booth`
  MODIFY `booth_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tab_gift`
--
ALTER TABLE `tab_gift`
  MODIFY `gift_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tab_participants`
--
ALTER TABLE `tab_participants`
  MODIFY `participant_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tab_user`
--
ALTER TABLE `tab_user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tr_attendance`
--
ALTER TABLE `tr_attendance`
  MODIFY `attendance_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `tr_grandprize`
--
ALTER TABLE `tr_grandprize`
  MODIFY `grandprize_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tr_grandprize_choosen`
--
ALTER TABLE `tr_grandprize_choosen`
  MODIFY `granprize2_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tr_registration`
--
ALTER TABLE `tr_registration`
  MODIFY `registration_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
