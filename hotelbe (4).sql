-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 14, 2026 at 04:03 AM
-- Server version: 8.0.30
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hotelbe`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `room_id` bigint UNSIGNED NOT NULL,
  `quantity` int DEFAULT NULL,
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `cancel_free_days` int NOT NULL DEFAULT '3',
  `cancel_fee` decimal(15,2) DEFAULT NULL,
  `status` enum('pending','confirmed','cancelled','completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `payment_status` enum('paid','unpaid','refunded','not_refunded') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unpaid',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `pre_checkin_email_sent` tinyint(1) NOT NULL DEFAULT '0',
  `discount_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_amount` int NOT NULL DEFAULT '0',
  `final_price` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `room_id`, `quantity`, `check_in`, `check_out`, `total_price`, `cancel_free_days`, `cancel_fee`, `status`, `payment_status`, `created_at`, `updated_at`, `pre_checkin_email_sent`, `discount_code`, `discount_amount`, `final_price`) VALUES
(25, 8, 4, 1, '2025-11-13', '2025-11-14', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-10-13 09:55:24', '2025-11-13 10:30:01', 0, NULL, 0, 0),
(26, 8, 5, 1, '2025-11-13', '2025-11-14', 2000000.00, 3, NULL, 'cancelled', 'unpaid', '2025-10-13 10:19:11', '2025-11-13 19:50:05', 0, NULL, 0, 0),
(27, 8, 5, 1, '2025-11-13', '2025-11-14', 2000000.00, 3, NULL, 'cancelled', 'unpaid', '2025-10-13 10:20:29', '2025-11-13 19:50:05', 0, NULL, 0, 0),
(28, 8, 4, 1, '2025-11-15', '2025-11-16', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-10-13 10:23:07', '2025-11-13 19:50:05', 0, NULL, 0, 0),
(29, 8, 4, 1, '2025-11-15', '2025-11-16', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-10-15 00:11:58', '2025-11-16 08:35:00', 0, NULL, 0, 0),
(34, 8, 6, 1, '2025-11-18', '2025-11-19', 1200000.00, 3, NULL, 'cancelled', 'refunded', '2025-11-17 02:45:41', '2025-11-18 19:38:02', 0, NULL, 0, 0),
(35, 8, 4, 1, '2025-11-20', '2025-11-21', 1800000.00, 3, NULL, 'cancelled', 'refunded', '2025-11-18 00:33:33', '2025-11-18 00:56:01', 0, NULL, 0, 0),
(36, 8, 4, 1, '2025-11-20', '2025-11-21', 1800000.00, 3, NULL, 'cancelled', 'refunded', '2025-11-18 00:47:29', '2025-11-18 00:56:01', 0, NULL, 0, 0),
(37, 8, 5, 1, '2025-11-20', '2025-11-21', 2000000.00, 3, NULL, 'cancelled', 'refunded', '2025-11-18 01:05:35', '2025-11-18 01:11:30', 0, NULL, 0, 0),
(38, 8, 5, 1, '2025-11-19', '2025-11-20', 2000000.00, 3, NULL, 'completed', 'paid', '2025-11-18 20:43:34', '2025-11-22 10:25:01', 0, NULL, 0, 0),
(40, 8, 5, 1, '2025-11-21', '2025-11-22', 2000000.00, 3, NULL, 'cancelled', 'refunded', '2025-11-18 21:46:08', '2025-11-18 21:48:01', 0, NULL, 0, 0),
(41, 8, 4, 1, '2025-11-24', '2025-11-25', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-11-23 20:51:20', '2025-11-23 21:25:03', 0, NULL, 0, 0),
(42, 8, 4, 1, '2025-11-24', '2025-11-25', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-11-23 21:11:57', '2025-11-23 21:45:01', 0, NULL, 0, 0),
(43, 8, 4, 1, '2025-11-24', '2025-11-25', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-11-23 21:12:58', '2025-11-23 21:45:01', 0, NULL, 0, 0),
(44, 8, 4, 1, '2025-11-24', '2025-11-25', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-11-23 21:25:06', '2025-11-23 22:00:02', 0, NULL, 0, 0),
(45, 8, 4, 1, '2025-11-24', '2025-11-25', 1800000.00, 3, NULL, 'completed', 'paid', '2025-11-23 21:52:17', '2025-11-24 18:20:02', 0, NULL, 0, 0),
(46, 8, 4, 1, '2025-11-24', '2025-11-25', 1800000.00, 3, NULL, 'completed', 'paid', '2025-11-23 22:47:08', '2025-11-24 18:20:02', 0, NULL, 0, 0),
(47, 8, 5, 1, '2025-11-26', '2025-11-27', 2000000.00, 3, NULL, 'cancelled', 'unpaid', '2025-11-23 23:51:08', '2025-11-24 00:25:01', 0, NULL, 0, 0),
(48, 8, 5, 1, '2025-11-25', '2025-11-26', 2000000.00, 3, NULL, 'cancelled', 'unpaid', '2025-11-25 03:00:08', '2025-11-25 05:55:01', 0, NULL, 0, 0),
(49, 1, 4, 1, '2025-11-27', '2025-11-28', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-11-26 23:58:40', '2025-11-27 00:30:01', 0, NULL, 0, 0),
(50, 8, 4, 1, '2025-11-27', '2025-11-28', 1800000.00, 3, NULL, 'cancelled', 'not_refunded', '2025-11-27 00:25:51', '2025-11-27 00:57:05', 0, NULL, 0, 0),
(51, 8, 4, 1, '2025-12-01', '2025-12-02', 1800000.00, 3, NULL, 'cancelled', 'refunded', '2025-11-27 00:58:05', '2025-11-27 00:59:46', 0, NULL, 0, 0),
(52, 8, 4, 1, '2025-11-28', '2025-11-29', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-11-28 00:03:18', '2025-11-28 00:35:01', 0, NULL, 0, 0),
(53, 8, 4, 1, '2025-11-29', '2025-11-30', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-11-29 00:43:50', '2025-11-29 01:15:01', 0, NULL, 0, 0),
(54, 8, 4, 1, '2025-11-30', '2025-12-01', 1800000.00, 3, NULL, 'completed', 'paid', '2025-11-30 06:20:00', '2025-11-30 18:05:01', 0, NULL, 0, 0),
(55, 8, 4, 1, '2025-12-02', '2025-12-03', 1800000.00, 3, NULL, 'cancelled', 'not_refunded', '2025-11-30 11:22:25', '2025-11-30 20:00:54', 0, NULL, 0, 0),
(56, 1, 7, 1, '2025-12-01', '2025-12-02', 3724000.00, 3, NULL, 'completed', 'paid', '2025-12-01 08:10:53', '2025-12-01 08:12:20', 0, NULL, 0, 0),
(57, 1, 8, 1, '2025-12-03', '2025-12-04', 4500000.00, 3, NULL, 'completed', 'paid', '2025-12-01 08:13:09', '2025-12-01 08:13:54', 0, NULL, 0, 0),
(58, 1, 10, 1, '2025-12-02', '2025-12-03', 1462050.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-02 01:35:52', '2025-12-02 02:10:01', 0, NULL, 0, 0),
(59, 1, 5, 1, '2025-12-02', '2025-12-03', 2000000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-02 02:14:34', '2025-12-02 02:45:01', 0, NULL, 0, 0),
(60, 8, 4, 1, '2025-12-03', '2025-12-04', 1800000.00, 3, NULL, 'completed', 'paid', '2025-12-03 04:54:21', '2025-12-03 04:55:47', 0, NULL, 0, 0),
(61, 1, 8, 1, '2025-12-07', '2025-12-08', 4500000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-06 09:42:30', '2025-12-07 08:30:02', 0, 'SUMMER2024', 900000, 3600000),
(63, 8, 4, 1, '2025-12-06', '2025-12-07', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-06 09:45:39', '2025-12-07 08:30:02', 0, 'SUMMER2024', 360000, 1440000),
(64, 8, 4, 1, '2025-12-09', '2025-12-10', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-06 11:15:34', '2025-12-07 08:30:02', 0, 'SUMMER2024', 360000, 1440000),
(65, 8, 4, 1, '2025-12-10', '2025-12-11', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-06 11:27:09', '2025-12-07 08:30:02', 0, NULL, 0, 0),
(66, 8, 4, 1, '2025-12-06', '2025-12-07', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-06 11:32:46', '2025-12-07 08:30:02', 0, NULL, 0, 0),
(67, 8, 4, 1, '2025-12-09', '2025-12-10', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-06 11:42:50', '2025-12-07 08:30:02', 0, NULL, 0, 0),
(68, 8, 5, 1, '2025-12-09', '2025-12-10', 2000000.00, 3, NULL, 'completed', 'paid', '2025-12-07 08:19:59', '2025-12-07 08:29:53', 0, 'SUMMER2026', 400000, 1600000),
(69, 8, 4, 1, '2025-12-09', '2025-12-10', 1800000.00, 3, NULL, 'completed', 'paid', '2025-12-08 00:38:23', '2025-12-08 00:40:52', 0, 'SUMMER2026', 360000, 1440000),
(70, 8, 4, 1, '2025-12-09', '2025-12-10', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-08 01:00:48', '2025-12-08 02:45:01', 0, NULL, 0, 0),
(71, 8, 4, 1, '2025-12-09', '2025-12-10', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-08 08:32:14', '2025-12-08 09:05:01', 0, NULL, 0, 0),
(72, 8, 4, 1, '2025-12-08', '2025-12-09', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-08 08:35:41', '2025-12-08 09:10:01', 0, NULL, 0, 0),
(73, 8, 4, 1, '2025-12-09', '2025-12-10', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-08 09:16:35', '2025-12-08 09:50:01', 0, NULL, 0, 0),
(74, 8, 4, 1, '2025-12-09', '2025-12-10', 1800000.00, 3, NULL, 'completed', 'paid', '2025-12-09 01:04:28', '2025-12-09 01:07:40', 0, 'SUMMER2026', 360000, 1440000),
(75, 8, 4, 1, '2025-12-13', '2025-12-14', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-12 20:20:23', '2025-12-12 20:55:01', 0, NULL, 0, 0),
(76, 8, 4, 1, '2025-12-13', '2025-12-14', 1800000.00, 3, NULL, 'completed', 'paid', '2025-12-12 20:43:01', '2025-12-12 20:58:24', 0, NULL, 0, 0),
(77, 8, 4, 1, '2025-12-13', '2025-12-14', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-12 20:45:38', '2025-12-12 21:20:01', 0, NULL, 0, 0),
(78, 8, 6, 1, '2025-12-13', '2025-12-14', 1200000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-12 20:53:45', '2025-12-12 21:25:01', 0, NULL, 0, 0),
(79, 8, 6, 1, '2025-12-13', '2025-12-14', 1200000.00, 3, NULL, 'completed', 'paid', '2025-12-12 21:05:43', '2025-12-12 21:07:57', 0, NULL, 0, 0),
(80, 8, 4, 1, '2025-12-13', '2025-12-14', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-12 21:51:52', '2025-12-12 22:25:01', 0, NULL, 0, 0),
(81, 8, 4, 1, '2025-12-13', '2025-12-14', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-12 22:05:01', '2025-12-12 23:05:01', 0, NULL, 0, 0),
(82, 8, 4, 1, '2025-12-14', '2025-12-15', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-14 08:22:17', '2025-12-14 08:55:01', 0, NULL, 0, 0),
(83, 8, 4, 1, '2025-12-14', '2025-12-15', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-14 09:00:25', '2025-12-14 09:40:01', 0, NULL, 0, 0),
(84, 3, 4, 1, '2025-12-14', '2025-12-15', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-14 09:00:30', '2025-12-14 09:40:01', 0, NULL, 0, 0),
(85, 8, 4, 1, '2025-12-14', '2025-12-15', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-14 10:50:27', '2025-12-14 21:00:07', 0, NULL, 0, 0),
(86, 3, 4, 1, '2025-12-18', '2025-12-19', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-18 07:36:43', '2025-12-18 08:10:05', 0, NULL, 0, 0),
(88, 3, 4, 1, '2025-12-18', '2025-12-19', 1800000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-18 11:06:39', '2025-12-18 12:00:01', 0, NULL, 0, 0),
(89, 8, 5, 1, '2025-12-19', '2025-12-20', 2000000.00, 3, NULL, 'completed', 'paid', '2025-12-18 20:25:47', '2025-12-18 20:27:58', 0, 'SUMMER2026', 400000, 1600000),
(90, 8, 8, 1, '2025-12-21', '2025-12-22', 4500000.00, 3, NULL, 'cancelled', 'not_refunded', '2025-12-21 07:16:51', '2025-12-21 07:33:15', 0, 'SUMMER2026', 900000, 3600000),
(91, 8, 4, 3, '2025-12-22', '2025-12-23', 7500000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-21 10:16:47', '2025-12-21 14:35:00', 0, 'SUMMER2026', 1000000, 6500000),
(92, 11, 4, 1, '2025-12-22', '2025-12-23', 2500000.00, 3, NULL, 'cancelled', 'unpaid', '2025-12-21 18:58:10', '2025-12-21 19:30:01', 0, NULL, 0, 0),
(93, 11, 4, 2, '2025-12-22', '2025-12-23', 5000000.00, 3, NULL, 'completed', 'paid', '2025-12-21 20:33:58', '2025-12-21 20:35:38', 0, 'SUMMER2026', 1000000, 4000000);

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint UNSIGNED NOT NULL,
  `userId` bigint UNSIGNED NOT NULL,
  `parent_id` bigint UNSIGNED DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `rating` tinyint DEFAULT NULL COMMENT 'Rating 1-5',
  `userName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userAvatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maHotel` bigint UNSIGNED DEFAULT NULL,
  `maBlog` bigint UNSIGNED DEFAULT NULL,
  `level` int NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `userId`, `parent_id`, `comment`, `rating`, `userName`, `userAvatar`, `maHotel`, `maBlog`, `level`, `time`, `created_at`, `updated_at`) VALUES
(2, 8, 1, 'chê', NULL, 'TranVi25', 'https://i.ibb.co/7tBGLBBJ/ea28ccf5ec15.png', 1, NULL, 1, '2025-11-08 09:47:32', '2025-11-08 09:47:32', '2025-11-08 09:47:32'),
(3, 8, 2, 'éc', NULL, 'TranVi25', 'https://i.ibb.co/7tBGLBBJ/ea28ccf5ec15.png', 1, NULL, 2, '2025-11-08 09:54:27', '2025-11-08 09:54:27', '2025-11-08 09:54:27'),
(4, 8, 2, 'éc éc', NULL, 'TranVi25', 'https://i.ibb.co/7tBGLBBJ/ea28ccf5ec15.png', 1, NULL, 2, '2025-11-08 09:54:51', '2025-11-08 09:54:51', '2025-11-08 09:54:51'),
(5, 8, 3, 'aaa', NULL, 'TranVi25', 'https://i.ibb.co/7tBGLBBJ/ea28ccf5ec15.png', 1, NULL, 3, '2025-11-08 09:59:20', '2025-11-08 09:59:20', '2025-11-08 09:59:20'),
(6, 1, NULL, 'quãi thật chớ', 5, 'vi', NULL, 1, NULL, 0, '2025-11-08 10:11:43', '2025-11-08 10:11:43', '2025-11-08 10:11:43'),
(9, 8, NULL, 'test final', 3, 'TranVi2444', 'https://i.ibb.co/4nzywY8H/9b6b89f7d3ab.jpg', 1, NULL, 0, '2025-11-11 10:29:00', '2025-11-11 10:29:00', '2025-11-11 10:29:00'),
(10, 8, 9, 'aaaa', NULL, 'TranVi2444', 'https://i.ibb.co/35YLgLzL/8e947100bef0.jpg', 1, NULL, 1, '2025-11-11 10:45:27', '2025-11-11 10:45:27', '2025-11-11 10:45:27'),
(11, 8, 10, 'ccc', NULL, 'TranVi2444', 'https://i.ibb.co/qFhM75gD/3212c5381bf3.jpg', 1, NULL, 2, '2025-11-18 06:35:42', '2025-11-18 06:35:42', '2025-11-18 06:35:42'),
(12, 8, NULL, 'test', 3, 'TranVi2508', 'https://i.ibb.co/G3Nrcx8p/edef95ab08e0.jpg', 2, NULL, 0, '2025-12-15 16:33:07', '2025-12-15 16:33:07', '2025-12-15 16:33:07'),
(13, 8, 12, 'aaaaa', NULL, 'TranVi2508', 'https://i.ibb.co/G3Nrcx8p/edef95ab08e0.jpg', 2, NULL, 1, '2025-12-15 16:34:06', '2025-12-15 16:34:06', '2025-12-15 16:34:06'),
(14, 8, NULL, 'fffff', 3, 'TranVi2508', 'https://i.ibb.co/G3Nrcx8p/edef95ab08e0.jpg', 1, NULL, 0, '2025-12-18 20:22:22', '2025-12-18 20:22:22', '2025-12-20 09:46:36'),
(16, 8, 15, 'Vân đẹp trai lắm nha hehe', NULL, 'TranVi2508', 'https://i.ibb.co/G3Nrcx8p/edef95ab08e0.jpg', 37, NULL, 1, '2025-12-21 10:03:12', '2025-12-21 10:03:12', '2025-12-21 10:04:41');

-- --------------------------------------------------------

--
-- Table structure for table `discounts`
--

CREATE TABLE `discounts` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `minOrder` int NOT NULL,
  `maxDiscount` int NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `expiryDate` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `discounts`
--

INSERT INTO `discounts` (`id`, `title`, `code`, `value`, `minOrder`, `maxDiscount`, `image`, `isActive`, `expiryDate`, `created_at`, `updated_at`) VALUES
(1, 'Giảm giá mùa hè', 'SUMMER2026', '20%', 1800000, 1000000, '/assets/images/discount/discount-1.jpg', 1, '2026-08-31', '2025-12-06 09:18:55', '2025-12-06 09:18:55'),
(2, 'Ưu đãi cuối tuần', 'WEEKEND15', '15%', 1500000, 500000, '/assets/images/discount/discount-2.jpg', 1, '2025-12-31', '2025-12-06 09:22:40', '2025-12-06 09:22:40'),
(3, 'Khách hàng thân thiết', 'LOYALTY25', '30%', 3000000, 1500000, '/assets/images/discount/discount-3.jpg', 1, '2025-11-11', '2025-12-06 09:22:40', '2025-12-06 09:22:40'),
(4, 'Đặt sớm giảm sâu', 'EARLYBIRD30', '25%', 2500000, 1200000, '/assets/images/discount/discount-4.jpg', 1, '2026-02-01', '2025-12-06 09:22:40', '2025-12-06 09:22:40'),
(5, 'Combo gia đình', 'FAMILY20', '20%', 3500000, 800000, '/assets/images/discount/discount-7.jpg', 1, '2026-12-31', '2025-12-06 09:22:40', '2025-12-06 09:22:40'),
(6, 'Flash Sale Giữa Tuần', 'MIDWEEK12', '12%', 1000000, 300000, '/assets/images/discount/discount-6.jpg', 1, '2026-06-30', '2025-12-06 09:22:40', '2025-12-06 09:22:40'),
(8, 'Giảm giá lễ 30/4', 'HOLIDAY304', '18%', 1800000, 700000, '/assets/images/discount/discount-8.jpg', 1, '2026-04-30', '2025-12-06 09:22:40', '2025-12-06 09:22:40'),
(9, 'Ưu đãi Black Friday', 'BLACKFRIDAY50', '50%', 4000000, 2000000, '/assets/images/discount/discount-9.jpg', 1, '2025-11-29', '2025-12-06 09:22:40', '2025-12-06 09:22:40');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `failed_jobs`
--

INSERT INTO `failed_jobs` (`id`, `uuid`, `connection`, `queue`, `payload`, `exception`, `failed_at`) VALUES
(1, '30129477-324d-41e6-8108-67f9cc5c4c70', 'redis', 'default', '{\"uuid\":\"30129477-324d-41e6-8108-67f9cc5c4c70\",\"displayName\":\"App\\\\Events\\\\BookingCreated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:25:\\\"App\\\\Events\\\\BookingCreated\\\":1:{s:7:\\\"booking\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Booking\\\";s:2:\\\"id\\\";i:62;s:9:\\\"relations\\\";a:2:{i:0;s:4:\\\"user\\\";i:1;s:4:\\\"room\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"},\"id\":\"OsbS23vYdAR6o8JhcwEoPlwXO21jml2Z\",\"attempts\":0}', 'Illuminate\\Database\\Eloquent\\ModelNotFoundException: No query results for model [App\\Models\\Booking]. in D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Builder.php:621\nStack trace:\n#0 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\SerializesAndRestoresModelIdentifiers.php(109): Illuminate\\Database\\Eloquent\\Builder->firstOrFail()\n#1 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\SerializesAndRestoresModelIdentifiers.php(62): App\\Events\\BookingCreated->restoreModel(Object(Illuminate\\Contracts\\Database\\ModelIdentifier))\n#2 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\SerializesModels.php(93): App\\Events\\BookingCreated->getRestoredPropertyValue(Object(Illuminate\\Contracts\\Database\\ModelIdentifier))\n#3 [internal function]: App\\Events\\BookingCreated->__unserialize(Array)\n#4 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(97): unserialize(\'O:38:\"Illuminat...\')\n#5 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(60): Illuminate\\Queue\\CallQueuedHandler->getCommand(Array)\n#6 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\RedisJob), Array)\n#7 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(439): Illuminate\\Queue\\Jobs\\Job->fire()\n#8 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(389): Illuminate\\Queue\\Worker->process(\'redis\', Object(Illuminate\\Queue\\Jobs\\RedisJob), Object(Illuminate\\Queue\\WorkerOptions))\n#9 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(176): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\RedisJob), \'redis\', Object(Illuminate\\Queue\\WorkerOptions))\n#10 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(137): Illuminate\\Queue\\Worker->daemon(\'redis\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#11 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(120): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'redis\', \'default\')\n#12 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#13 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(41): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#14 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#15 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#16 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(662): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#17 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call(Array)\n#18 D:\\Hotel-Booking-BE\\vendor\\symfony\\console\\Command\\Command.php(326): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#19 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(180): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#20 D:\\Hotel-Booking-BE\\vendor\\symfony\\console\\Application.php(1096): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#21 D:\\Hotel-Booking-BE\\vendor\\symfony\\console\\Application.php(324): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#22 D:\\Hotel-Booking-BE\\vendor\\symfony\\console\\Application.php(175): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#23 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(201): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#24 D:\\Hotel-Booking-BE\\artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#25 {main}', '2025-12-06 11:23:36'),
(2, 'e5e8b31a-7cd8-4f82-9773-1463d14d95c8', 'redis', 'default', '{\"uuid\":\"e5e8b31a-7cd8-4f82-9773-1463d14d95c8\",\"timeout\":null,\"id\":\"4Gu5ZY8JaM6loVBVUHM5FAttTdrBNQ4P\",\"backoff\":null,\"displayName\":\"App\\\\Jobs\\\\CreateUserBehaviorJob\",\"maxTries\":null,\"failOnTimeout\":false,\"maxExceptions\":null,\"retryUntil\":null,\"data\":{\"command\":\"O:30:\\\"App\\\\Jobs\\\\CreateUserBehaviorJob\\\":1:{s:6:\\\"\\u0000*\\u0000log\\\";a:4:{s:7:\\\"user_id\\\";i:8;s:8:\\\"hotel_id\\\";i:1;s:6:\\\"action\\\";s:7:\\\"booking\\\";s:8:\\\"metadata\\\";a:5:{s:6:\\\"userId\\\";i:8;s:7:\\\"hotelId\\\";i:1;s:9:\\\"hotelName\\\";s:14:\\\"H Hôtel L\'Art\\\";s:5:\\\"price\\\";s:14:\\\"2.836.440 VNĐ\\\";s:8:\\\"location\\\";s:9:\\\"Hà Nội\\\";}}}\",\"commandName\":\"App\\\\Jobs\\\\CreateUserBehaviorJob\"},\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"attempts\":1}', 'Illuminate\\Queue\\MaxAttemptsExceededException: App\\Jobs\\CreateUserBehaviorJob has been attempted too many times. in D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\MaxAttemptsExceededException.php:24\nStack trace:\n#0 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(785): Illuminate\\Queue\\MaxAttemptsExceededException::forJob(Object(Illuminate\\Queue\\Jobs\\RedisJob))\n#1 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(519): Illuminate\\Queue\\Worker->maxAttemptsExceededException(Object(Illuminate\\Queue\\Jobs\\RedisJob))\n#2 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts(\'redis\', Object(Illuminate\\Queue\\Jobs\\RedisJob), 1)\n#3 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(389): Illuminate\\Queue\\Worker->process(\'redis\', Object(Illuminate\\Queue\\Jobs\\RedisJob), Object(Illuminate\\Queue\\WorkerOptions))\n#4 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(176): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\RedisJob), \'redis\', Object(Illuminate\\Queue\\WorkerOptions))\n#5 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(137): Illuminate\\Queue\\Worker->daemon(\'redis\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#6 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(120): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'redis\', \'default\')\n#7 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#8 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(41): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(662): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call(Array)\n#13 D:\\Hotel-Booking-BE\\vendor\\symfony\\console\\Command\\Command.php(326): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#14 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(180): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#15 D:\\Hotel-Booking-BE\\vendor\\symfony\\console\\Application.php(1096): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#16 D:\\Hotel-Booking-BE\\vendor\\symfony\\console\\Application.php(324): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#17 D:\\Hotel-Booking-BE\\vendor\\symfony\\console\\Application.php(175): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#18 D:\\Hotel-Booking-BE\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(201): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#19 D:\\Hotel-Booking-BE\\artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#20 {main}', '2025-12-09 03:39:46');

-- --------------------------------------------------------

--
-- Table structure for table `hotels`
--

CREATE TABLE `hotels` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `province` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `text` text COLLATE utf8mb4_unicode_ci,
  `name_nearby_place` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hotel_class` tinyint NOT NULL DEFAULT '0',
  `amenities` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hotels`
--

INSERT INTO `hotels` (`id`, `name`, `province`, `description`, `price`, `text`, `name_nearby_place`, `hotel_class`, `amenities`, `created_at`, `updated_at`, `user_id`, `status`) VALUES
(1, 'H Hôtel L\'Art', 'Hà Nội', 'H Hôtel L\'Art Hà Nội, nằm ở , được đánh giá Xuất sắc, địa chỉ: 74 Phố Hàng Gà', 2936440.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\", \"OYO Rooms\"]', '2025-10-09 18:43:11', '2025-12-20 12:25:17', 12, 'pending'),
(2, 'L\'Signature Hotel & Spa', 'Hà Nội', 'L\'Signature Hotel & Spa, nằm ở , được đánh giá Xuất sắc, địa chỉ: 4 Ngõ Báo Khánh', 3724000.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 18:46:01', '2025-10-09 18:46:01', 12, 'pending'),
(3, 'Léman Old Quarter', 'Hà Nội', 'Léman Old Quarter, nằm ở , được đánh giá Xuất sắc, địa chỉ: 4 Phố Lương Ngọc Quyến', 1462050.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 18:48:03', '2025-10-09 18:48:03', NULL, 'approved'),
(4, 'Hanoi Center Silk Hotel & Travel', 'Hà Nội', 'Hanoi Center Silk Hotel & Travel, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 22A Ta Hien Street, Hang Buom', 1833960.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 18:50:07', '2025-10-09 18:50:07', NULL, 'approved'),
(5, 'Splendid Star Grand Hotel and Spa', 'Hà Nội', 'Splendid Star Grand Hotel and Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 14 Tho Xuong Lane, Au Trieu', 1917664.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\", \"Resort\"]', '2025-10-09 18:56:36', '2025-10-09 18:56:36', NULL, 'approved'),
(6, 'Hanoi Chic Boutique Hotel', 'Hà Nội', 'Hanoi Chic Boutique Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 51 - 53 Bat Su street, Hoan Kiem', 1178100.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:06:54', '2025-10-09 20:06:54', NULL, 'approved'),
(7, 'Hanoi La Palm Premier Hotel & Spa', 'Hà Nội', 'Hanoi La Palm Premier Hotel & Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 35 Hang Quat, Hoan Kiem', 1810881.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:07:01', '2025-10-09 20:07:01', NULL, 'approved'),
(8, 'Aurora Premium - A Lifestyle Hotel', 'Hà Nội', 'Aurora Premium - A Lifestyle Hotel, nằm ở , được đánh giá Xuất sắc, địa chỉ: 61 Hàng Bè', 2562435.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:07:09', '2025-10-09 20:07:09', NULL, 'approved'),
(9, 'Hanoi Siva Luxury Hotel & Travel', 'Hà Nội', 'Hanoi Siva Luxury Hotel & Travel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 31 Hang Ga, Hoan Kiem', 1040000.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:08:57', '2025-10-09 20:08:57', NULL, 'approved'),
(10, 'Ja Cosmo Hotel and Spa', 'Hà Nội', 'Ja Cosmo Hotel and Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 23 Lo Su Street, Hoan Kiem District', 1612800.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:09:04', '2025-10-09 20:09:04', NULL, 'approved'),
(11, 'Hanoi Calista Hotel & Spa', 'Hà Nội', 'Hanoi Calista Hotel & Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 161-163 Hang Bong, Hoan Kiem', 2124745.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:09:11', '2025-10-09 20:09:11', NULL, 'approved'),
(12, 'Royal Lotus Hotel', 'Cầu Giấy', 'Royal Lotus Hotel, nằm ở Cau Giay, được đánh giá , địa chỉ: ROYAL LOTUS VILLA 6 tầng', 480000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Cau Giay', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:09:19', '2025-10-09 20:09:19', NULL, 'approved'),
(13, 'Eliana Premio Hotel Hanoi', 'Hoàn Kiếm', 'Eliana Premio Hotel Hanoi, nằm ở , được đánh giá Xuất sắc, địa chỉ: 108 Phố Hàng Bông', 2730000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:09:26', '2025-10-09 20:09:26', NULL, 'approved'),
(14, 'GRAND HOTEL du LAC Hanoi', 'Hà Nội', 'GRAND HOTEL du LAC Hanoi, nằm ở , được đánh giá Xuất sắc, địa chỉ: 18 - 20 - 22 - 24 Nha Chung, Hoan Kiem District', 4909311.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 50, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:09:36', '2025-10-09 20:09:36', NULL, 'approved'),
(15, 'Hanoi Amorita Boutique Hotel & Travel', 'Hà Nội', 'Hanoi Amorita Boutique Hotel & Travel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 7 Hang Dau street, Hang Bac ward, Hoan Kiem district', 1275000.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:09:56', '2025-10-09 20:09:56', NULL, 'approved'),
(16, 'Bella Premier Hotel & Rooftop Skybar', 'Hà Nội', 'Bella Premier Hotel & Rooftop Skybar, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 11 Cau Go, Old Quarter, Hoan Kiem', 5000000.00, 'Khách sạn sở hữu sky bar tầng thượng với view toàn cảnh thành phố ngoạn mục, là điểm đến lý tưởng để thưởng thức cocktail và ngắm hoàng hôn. Không gian bar sang trọng với thiết kế hiện đại, bàn ghế được bố trí tối ưu để tận hưởng trọn vẹn khung cảnh. Menu cocktail đặc biệt được pha chế bởi bartender chuyên nghiệp, kết hợp cùng âm nhạc sôi động và không khí sầm uất. Phòng nghệ được thiết kế tinh tế với ban công riêng, giường king size êm ái và phòng tắm sang trọng. Dịch vụ phòng 24/7, minibar đa dạng và hệ thống giải trí hiện đại. Thích hợp cho các cặp đôi, nhóm bạn và các sự kiện đặc biệt.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Sky bar\", \"Restaurant\", \"Bar\", \"Spa\", \"Terrace\"]', '2025-10-09 20:10:03', '2025-10-09 20:10:03', NULL, 'approved'),
(17, 'San Hotel & Spa', 'Cầu Giấy', 'San Hotel & Spa, nằm ở Cau Giay, được đánh giá Tuyệt hảo, địa chỉ: 78 Phố Nguyễn Chánh', 1320000.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Cau Giay', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:10:12', '2025-10-09 20:10:12', NULL, 'approved'),
(18, 'The Oriental Jade Hotel', 'Hà Nội', 'The Oriental Jade Hotel, nằm ở , được đánh giá Xuất sắc, địa chỉ: 92 - 94 Hang Trong, Hoan Kiem', 4819237.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:10:19', '2025-10-09 20:10:19', NULL, 'approved'),
(19, 'Aurora Oriental Hotel', 'Hoàn Kiếm', 'Aurora Oriental Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 26 Phố Lý Thái Tổ 10', 2842875.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:10:27', '2025-10-09 20:10:27', NULL, 'approved'),
(20, 'Amara Hanoi Hotel and Spa', 'Hà Nội', 'Amara Hanoi Hotel and Spa, nằm ở , được đánh giá Xuất sắc, địa chỉ: 18 Phố Hàng Quạt', 1664245.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:10:33', '2025-10-09 20:10:33', NULL, 'approved'),
(21, 'Serene Central Hotel', 'Hà Nội', 'Serene Central Hotel, nằm ở , được đánh giá Xuất sắc, địa chỉ: 106 Hàng Bông, Hoàn Kiếm, Hanoi', 1450000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:10:42', '2025-10-09 20:10:42', NULL, 'approved'),
(22, 'THE LEGEND HANOI Hotel', 'Hoàn Kiếm', 'THE LEGEND HANOI Hotel, nằm ở , được đánh giá Xuất sắc, địa chỉ: 8 Phố Yết Kiêu', 2185000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:10:49', '2025-10-09 20:10:49', NULL, 'approved'),
(23, 'Astoria Hotel - St Joseph Cathedral Hanoi', 'Hoàn Kiếm', 'Astoria Hotel - St Joseph Cathedral Hanoi, nằm ở , được đánh giá Xuất sắc, địa chỉ: Ngõ Huyện số 16A', 2287350.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:10:55', '2025-10-09 20:10:55', NULL, 'approved'),
(24, 'San Boutique Hotel & Travel', 'Hoàn Kiếm', 'San Boutique Hotel & Travel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 24 Hàng Hành', 1990230.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:11:03', '2025-10-09 20:11:03', NULL, 'approved'),
(25, 'Shining Central Hotel & Spa', 'Ha Noi', 'Shining Central Hotel & Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 20 Lo Su Street', 3277500.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 50, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:11:10', '2025-10-09 20:11:10', NULL, 'approved'),
(26, 'Beryl Signature Hotel & Travel', 'Ha Noi', 'Beryl Signature Hotel & Travel, nằm ở , được đánh giá Xuất sắc, địa chỉ: 24 Quan Su, Hoan Kiem', 1244958.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:11:18', '2025-10-09 20:11:18', NULL, 'approved'),
(27, 'Ben\'s Premier Hotel & Apartment - Hanoi Center', 'Hai Bà Trưng', 'Ben\'s Premier Hotel & Apartment - Hanoi Center, nằm ở Quận Hai Bà Trưng, được đánh giá Tuyệt vời, địa chỉ: 10 Ngõ Trần Xuân Soạn', 994500.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Quận Hai Bà Trưng', 30, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:11:28', '2025-10-09 20:11:28', NULL, 'approved'),
(28, 'Hanoi E Central Luxury Hotel & Restaurant', 'Hà Nội', 'Hanoi E Central Luxury Hotel & Restaurant, nằm ở , được đánh giá Xuất sắc, địa chỉ: 18 Lo Su', 1620000.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:11:36', '2025-10-09 20:11:36', NULL, 'approved'),
(29, 'Hanoi Sena Hotel & Travel', 'Hoàn Kiếm', 'Hanoi Sena Hotel & Travel, nằm ở , được đánh giá Rất tốt, địa chỉ: 1 Hàng Hòm', 980000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:11:43', '2025-10-09 20:11:43', NULL, 'approved'),
(30, 'Casa Dos Príncipes Hotel & Spa', 'Hoàn Kiếm', 'Casa Dos Príncipes Hotel & Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 56 Phố Đào Duy Từ', 1749950.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:11:51', '2025-10-09 20:11:51', NULL, 'approved'),
(31, 'MAY DE VILLE Corner Hotel', 'Hoàn Kiếm', 'MAY DE VILLE Corner Hotel, nằm ở , được đánh giá Xuất sắc, địa chỉ: 24 Phan Huy Chú, Hoàn Kiếm, Hà Nội', 2200000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:11:58', '2025-10-09 20:11:58', NULL, 'approved'),
(32, 'San Palace Hotel & Rooftop', 'Hà Nội', 'San Palace Hotel & Rooftop, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 187 Hang Bong, Hoan Kiem', 2451390.00, 'Khách sạn sở hữu sky bar tầng thượng với view toàn cảnh thành phố ngoạn mục, là điểm đến lý tưởng để thưởng thức cocktail và ngắm hoàng hôn. Không gian bar sang trọng với thiết kế hiện đại, bàn ghế được bố trí tối ưu để tận hưởng trọn vẹn khung cảnh. Menu cocktail đặc biệt được pha chế bởi bartender chuyên nghiệp, kết hợp cùng âm nhạc sôi động và không khí sầm uất. Phòng nghệ được thiết kế tinh tế với ban công riêng, giường king size êm ái và phòng tắm sang trọng. Dịch vụ phòng 24/7, minibar đa dạng và hệ thống giải trí hiện đại. Thích hợp cho các cặp đôi, nhóm bạn và các sự kiện đặc biệt.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Sky bar\", \"Restaurant\", \"Bar\", \"Spa\", \"Terrace\"]', '2025-10-09 20:12:07', '2025-10-09 20:12:07', NULL, 'approved'),
(33, 'Hanoi Ancient Paradise Hotel', 'Hoàn Kiếm', 'Hanoi Ancient Paradise Hotel, nằm ở , được đánh giá Xuất sắc, địa chỉ: 95 Phố Hàng Chiếu', 1479576.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:12:15', '2025-10-09 20:12:15', NULL, 'approved'),
(34, 'Elegance Premium Hotel', 'Hoàn Kiếm', 'Elegance Premium Hotel, nằm ở , được đánh giá Xuất sắc, địa chỉ: 21-23 P. Bát Đàn', 792000.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:12:19', '2025-10-09 20:12:19', NULL, 'approved'),
(35, 'Hotel Emerald Waters Classy', 'Hà Nội', 'Hotel Emerald Waters Classy, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 27-29 Gia Ngu Street', 1338120.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:12:26', '2025-10-09 20:12:26', NULL, 'approved'),
(36, 'The West Hotel & Spa', 'Hà Nội', 'The West Hotel & Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 23 Hàng Đào', 1677500.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:12:34', '2025-10-09 20:12:34', NULL, 'approved'),
(37, 'Anatole Hotel Hanoi', 'Ha Noi', 'Anatole Hotel Hanoi, nằm ở , được đánh giá Xuất sắc, địa chỉ: 26 - 28 - 30 Nha Chung, Hang Trong, Hoan Kiem', 3708400.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:12:40', '2025-10-09 20:12:40', NULL, 'approved'),
(38, 'Bendecir Hotel & Spa', 'Hà Nội', 'Bendecir Hotel & Spa, nằm ở , được đánh giá Rất tốt, địa chỉ: 27 Lo Su, Hoan Kiem', 1856000.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:12:48', '2025-10-09 20:12:48', NULL, 'approved'),
(39, 'Calista Trendy Hotel & Spa', 'Hoàn Kiếm', 'Calista Trendy Hotel & Spa, nằm ở , được đánh giá Xuất sắc, địa chỉ: 18 Ngõ Hội Vũ', 1775310.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(40, 'Hanoi Le Chateau Hotel & Spa', 'Hà Nội', 'Hanoi Le Chateau Hotel & Spa, nằm ở , được đánh giá Xuất sắc, địa chỉ: 23-25 Phố Hàng Thiếc', 3934870.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 50, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(41, 'Solare De Monte Hotel & Spa', 'Hà Nội', 'Solare De Monte Hotel & Spa, nằm ở , được đánh giá Xuất sắc, địa chỉ: 25 Nguyen Sieu, Hang Buom, Hoan Kiem', 2728440.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 50, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(42, 'Hanoi Emerald Waters Hotel & Spa', 'Hà Nội', 'Hanoi Emerald Waters Hotel & Spa, nằm ở , được đánh giá Xuất sắc, địa chỉ: 47 Lo Su', 2026820.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(43, 'Royal Holiday Hanoi Hotel', 'Hà Nội', 'Royal Holiday Hanoi Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 19 Hang Hanh, Hang Trong', 1139600.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(44, 'Avani Central Hanoi Hotel', 'Hà Nội', 'Avani Central Hanoi Hotel, nằm ở , được đánh giá Xuất sắc, địa chỉ: 22 Quan Su, Hoan Kiem', 1879801.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(45, 'Champton Hanoi Hotel', 'Hà Nội', 'Champton Hanoi Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 130 Hang Bong', 2380950.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(46, 'La Passion Hanoi Hotel & Apartment', 'Hoàn Kiếm', 'La Passion Hanoi Hotel & Apartment, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 64 Ngõ Phất Lộc', 3207600.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(47, 'The Embassy Hotel Hanoi', 'Hoàn Kiếm', 'The Embassy Hotel Hanoi, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 166 Đ. Trần Quang Khải', 1185462.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(48, 'Hanoi Center Silk Charming Hotel & Travel', 'Hà Nội', 'Hanoi Center Silk Charming Hotel & Travel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 40 phố Mã Mây, Phố Cổ, Hàng Buồm, Hoàn Kiếm, Hà Nội, Việt Nam 40 phố Mã Mây, Phố Cổ, Hàng Buồm, Hoàn Kiếm, Hà Nội, Việt Nam', 1013760.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(49, 'Silk Path Boutique Hanoi', 'Hà Nội', 'Silk Path Boutique Hanoi, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 21 Hang Khay, Hoan Kiem', 2242665.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(50, 'Flora Centre Hotel & Spa', 'Hoàn Kiếm', 'Flora Centre Hotel & Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 14A Phố Lương Văn Can', 1867020.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(51, 'Le Petit Prince Hotel & Rooftop Bar', 'Hoàn Kiếm', 'Le Petit Prince Hotel & Rooftop Bar, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 58 Phố Hàng Gai', 2289000.00, 'Khách sạn sở hữu sky bar tầng thượng với view toàn cảnh thành phố ngoạn mục, là điểm đến lý tưởng để thưởng thức cocktail và ngắm hoàng hôn. Không gian bar sang trọng với thiết kế hiện đại, bàn ghế được bố trí tối ưu để tận hưởng trọn vẹn khung cảnh. Menu cocktail đặc biệt được pha chế bởi bartender chuyên nghiệp, kết hợp cùng âm nhạc sôi động và không khí sầm uất. Phòng nghệ được thiết kế tinh tế với ban công riêng, giường king size êm ái và phòng tắm sang trọng. Dịch vụ phòng 24/7, minibar đa dạng và hệ thống giải trí hiện đại. Thích hợp cho các cặp đôi, nhóm bạn và các sự kiện đặc biệt.', 'Quận Hoàn Kiếm', 50, '[\"WiFi\", \"Sky bar\", \"Restaurant\", \"Bar\", \"Spa\", \"Terrace\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(52, 'Drift Backpackers Hostel', 'Hoàn Kiếm', 'Drift Backpackers Hostel, nằm ở , được đánh giá Rất tốt, địa chỉ: 38 Phố Ấu Triệu', 405000.00, 'Không gian trẻ trung, năng động dành cho du khách ba lô với mức giá hợp lý. Phòng dorm sạch sẽ được chia thành các capsule riêng tư với rèm che, ổ khóa cá nhân và đèn đọc sách riêng. Mỗi capsule đều có ổ cắm điện, kệ để đồ và không gian đủ rộng để nghỉ ngơi thoải mái. Khu vực bếp chung được trang bị đầy đủ dụng cụ nấu ăn, tủ lạnh và máy giặt tự động. Phòng sinh hoạt cộng đồng rộng rãi với TV, kệ sách và bàn bi-a, tạo cơ hội kết nối với du khách từ khắp nơi trên thế giới. Dịch vụ đặt tour giá rẻ, thuê xe máy và hướng dẫn du lịch bản địa. Vị trí trung tâm, thuận tiện di chuyển đến các điểm tham quan nổi tiếng.', 'Quận Hoàn Kiếm', 0, '[\"WiFi\", \"Shared kitchen\", \"Common area\", \"Laundry\", \"Bicycle rental\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(53, 'Eliana Signature Hanoi Hotel', 'Hoàn Kiếm', 'Eliana Signature Hanoi Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 38 Phố Lò Sũ', 1864800.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved');
INSERT INTO `hotels` (`id`, `name`, `province`, `description`, `price`, `text`, `name_nearby_place`, `hotel_class`, `amenities`, `created_at`, `updated_at`, `user_id`, `status`) VALUES
(54, 'La Passion Premium Cau Go', 'Hoàn Kiếm', 'La Passion Premium Cau Go, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 7 Cau Go, Hang Bac ward', 3024000.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(55, 'Hanoi Center Silk Classic Hotel & Travel', 'Hoàn Kiếm', 'Hanoi Center Silk Classic Hotel & Travel, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 41 Phố Bát Sứ 41 Phố Bát Sứ, Hàng Bồ, Hoàn Kiếm, Hà Nội, Việt Nam', 1793792.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(56, 'Splendid Secret Hotel', 'Hoàn Kiếm', 'Splendid Secret Hotel, nằm ở , được đánh giá Xuất sắc, địa chỉ: 36/30 Phố Lò Sũ, Lý Thái Tổ', 4840000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(57, 'Concon house', 'Hà Nôi', 'Concon house, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: Ngõ Nội Miếu, Hàng Buồm, Hoàn Kiếm, Hà Nội, Việt Nam Số nhà 11+13 Nội Miếu', 1660050.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(58, 'La Sinfonía Majesty Hotel and Spa', 'Hà Nội', 'La Sinfonía Majesty Hotel and Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 1B Cau Go Street, Hoan Kiem District', 2360909.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(59, 'The Ambery Hanoi Boutique Hotel & Travel', 'Hà Nội', 'The Ambery Hanoi Boutique Hotel & Travel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 83 Thuoc Bac Street', 891000.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(60, 'The Chi Boutique Hotel', 'Hà Nội', 'The Chi Boutique Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 13 Nha Chung street, Hoan Kiem district', 2106000.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(61, 'Hanoi Central Hotel & Residences', 'Hoàn Kiếm', 'Hanoi Central Hotel & Residences, nằm ở , được đánh giá Xuất sắc, địa chỉ: 5-7 Hoi Vu', 2469250.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(62, 'Classy Holiday Hotel & Spa', 'Hà Nội', 'Classy Holiday Hotel & Spa, nằm ở , được đánh giá Rất tốt, địa chỉ: 49 Lan Ong Street', 1548360.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(63, 'Splendid Holiday Hotel Spa', 'Hoàn Kiếm', 'Splendid Holiday Hotel Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 16 Ngõ Thọ Xương  lane', 1495648.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(64, 'Singita Classy - A Cozy Rustic Hideaway in Hanoi Old Quarter', 'Hà Nội', 'Singita Classy - A Cozy Rustic Hideaway in Hanoi Old Quarter, nằm ở , được đánh giá Rất tốt, địa chỉ: 16H Đường Thành, Phường Cửa Đông, ', 875327.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(65, 'HOTEL de LAGOM', 'Hà Nội', 'HOTEL de LAGOM, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 30b Phố Lý Nam Đế', 4168117.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(66, 'Minerva Premium Hotel', 'Hà Nội', 'Minerva Premium Hotel, nằm ở , được đánh giá Xuất sắc, địa chỉ: 36 Hang Trong, Hoan Kiem', 2624501.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(67, 'Rex Hanoi Hotel', 'Ha Noi', 'Rex Hanoi Hotel, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 42-44 Gia Ngu Street, Hoan Kiem Ward, Ha Noi, Viet Nam ', 2325600.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(68, 'Hanoian Central Hotel & Spa', 'Hà Nội', 'Hanoian Central Hotel & Spa, nằm ở , được đánh giá Xuất sắc, địa chỉ: 42A Hang Cot Street', 2574000.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:05', '2025-10-09 20:17:05', NULL, 'approved'),
(69, 'Babylon Premium Hotel & Spa', 'Hoàn Kiếm', 'Babylon Premium Hotel & Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 05-07 Hàng Hòm', 1470000.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(70, 'Matilda Boutique Hotel & Spa', 'Hà Nội', 'Matilda Boutique Hotel & Spa, nằm ở , được đánh giá Rất tốt, địa chỉ: 73 Ma May Street', 1567500.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(71, 'Ha Noi Lake View Hotel & Travel', 'Hà Nội', 'Ha Noi Lake View Hotel & Travel, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 40 Lò Sũ, phường Lý Thái Tổ, quận Hoàn Kiếm', 990000.00, 'Tận hưởng không gian yên bình với view hồ tuyệt đẹp ngay từ phòng nghỉ, nơi bạn có thể ngắm bình minh và hoàng hôn trên mặt hồ. Căn hộ được thiết kế như nhà riêng với đầy đủ tiện nghi: bếp đầy đủ dụng cụ nấu ăn, phòng khách rộng rãi với sofa thoải mái, ban công thoáng mát với bàn ghế thư giãn. Mỗi căn hộ đều có phòng ngủ riêng biệt với giường king size, tủ quần áo rộng rãi và phòng tắm hiện đại. Khu vực hồ bơi riêng được bao quanh bởi vườn cây xanh mát, tạo không gian thư giãn lý tưởng. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/24 và hỗ trợ đặt vé tham quan. Lý tưởng cho kỳ nghỉ gia đình hoặc công tác dài ngày.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Kitchenette\", \"Lake view\", \"Terrace\", \"Family rooms\", \"Laundry\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(72, 'Media Central Hotel & Spa', 'Hải Phòng', 'Media Central Hotel & Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 108 Phố Hàng Bạc 108 Hàng Bạc, Hoàn Kiếm, Hà Nội', 1839200.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(73, 'The Silk Grand Premium Hotel & Spa -Old Quarter Hanoi', 'Hải Phòng', 'The Silk Grand Premium Hotel & Spa -Old Quarter Hanoi, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 6 Phố Lương Ngọc Quyến', 1282500.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(74, 'Golden Legend Boutique Hotel', 'Hải Phòng', 'Golden Legend Boutique Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 10 Chan Cam Street', 1963500.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(75, 'MAY DE VILLE Lakeside Hotel', 'Hải Phòng', 'MAY DE VILLE Lakeside Hotel, nằm ở , được đánh giá Xuất sắc, địa chỉ: 43 Gia Ngu Street', 3650000.00, 'Tận hưởng không gian yên bình với view hồ tuyệt đẹp ngay từ phòng nghỉ, nơi bạn có thể ngắm bình minh và hoàng hôn trên mặt hồ. Căn hộ được thiết kế như nhà riêng với đầy đủ tiện nghi: bếp đầy đủ dụng cụ nấu ăn, phòng khách rộng rãi với sofa thoải mái, ban công thoáng mát với bàn ghế thư giãn. Mỗi căn hộ đều có phòng ngủ riêng biệt với giường king size, tủ quần áo rộng rãi và phòng tắm hiện đại. Khu vực hồ bơi riêng được bao quanh bởi vườn cây xanh mát, tạo không gian thư giãn lý tưởng. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/24 và hỗ trợ đặt vé tham quan. Lý tưởng cho kỳ nghỉ gia đình hoặc công tác dài ngày.', 'Quận Hoàn Kiếm', 50, '[\"WiFi\", \"Kitchenette\", \"Lake view\", \"Terrace\", \"Family rooms\", \"Laundry\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(76, 'Splendid Hotel & Spa', 'Hải Phòng', 'Splendid Hotel & Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: ​06 Hang Hanh street', 1667020.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(77, 'Hanoi Buffalo Hostel', 'Hải Phòng', 'Hanoi Buffalo Hostel, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 44 Hang Giay Street, Hoan Kiem District, Ha Noi', 1036800.00, 'Không gian trẻ trung, năng động dành cho du khách ba lô với mức giá hợp lý. Phòng dorm sạch sẽ được chia thành các capsule riêng tư với rèm che, ổ khóa cá nhân và đèn đọc sách riêng. Mỗi capsule đều có ổ cắm điện, kệ để đồ và không gian đủ rộng để nghỉ ngơi thoải mái. Khu vực bếp chung được trang bị đầy đủ dụng cụ nấu ăn, tủ lạnh và máy giặt tự động. Phòng sinh hoạt cộng đồng rộng rãi với TV, kệ sách và bàn bi-a, tạo cơ hội kết nối với du khách từ khắp nơi trên thế giới. Dịch vụ đặt tour giá rẻ, thuê xe máy và hướng dẫn du lịch bản địa. Vị trí trung tâm, thuận tiện di chuyển đến các điểm tham quan nổi tiếng.', 'Quận Hoàn Kiếm', 0, '[\"WiFi\", \"Shared kitchen\", \"Common area\", \"Laundry\", \"Bicycle rental\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(78, 'Sena Boutique Hotel & Travel', 'Hải Phòng', 'Sena Boutique Hotel & Travel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 20 Phố Hàng Hòm', 1089000.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(79, 'Bella Rosa Trendy Hotel & Spa', 'Hải Phòng', 'Bella Rosa Trendy Hotel & Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 11 Luong Ngoc Quyen', 1952875.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(80, 'Veshia Hotel & Spa', 'Hải Phòng', 'Veshia Hotel & Spa, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 373 Đường Hồng Hà', 1132740.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(81, 'Golden Time Hostel 3', 'Hải Phòng', 'Golden Time Hostel 3, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 106 Ma May Street', 640900.00, 'Không gian trẻ trung, năng động dành cho du khách ba lô với mức giá hợp lý. Phòng dorm sạch sẽ được chia thành các capsule riêng tư với rèm che, ổ khóa cá nhân và đèn đọc sách riêng. Mỗi capsule đều có ổ cắm điện, kệ để đồ và không gian đủ rộng để nghỉ ngơi thoải mái. Khu vực bếp chung được trang bị đầy đủ dụng cụ nấu ăn, tủ lạnh và máy giặt tự động. Phòng sinh hoạt cộng đồng rộng rãi với TV, kệ sách và bàn bi-a, tạo cơ hội kết nối với du khách từ khắp nơi trên thế giới. Dịch vụ đặt tour giá rẻ, thuê xe máy và hướng dẫn du lịch bản địa. Vị trí trung tâm, thuận tiện di chuyển đến các điểm tham quan nổi tiếng.', 'Quận Hoàn Kiếm', 20, '[\"WiFi\", \"Shared kitchen\", \"Common area\", \"Laundry\", \"Bicycle rental\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(82, 'Hanoi Old Quarter Hotel', 'Hải Phòng', 'Hanoi Old Quarter Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 23 Hang Hanh Street', 1616530.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(83, 'Sunrise Hanoi Hotel', 'Hải Phòng', 'Sunrise Hanoi Hotel, nằm ở Quận Hai Bà Trưng, được đánh giá Tuyệt vời, địa chỉ: 716 Bach Dang, Hai Ba Trung District', 652500.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hai Bà Trưng', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(84, 'Hanoi Golden Lotus Hotel & Spa', 'Hải Phòng', 'Hanoi Golden Lotus Hotel & Spa, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 19 Hang Bac', 840000.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(85, 'L\'amant de Hanoi Hotel - khách sạn Lamant de Hà Nội', 'Hải Phòng', 'L\'amant de Hanoi Hotel - khách sạn Lamant de Hà Nội, nằm ở , được đánh giá Rất tốt, địa chỉ: 72 Phố Nguyễn Hữu Huân', 1260000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(86, 'Golden Art Hotel', 'Hải Phòng', 'Golden Art Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 6A Hang But', 1222650.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(87, 'Peridot Gallery Classic Hotel', 'Hải Phòng', 'Peridot Gallery Classic Hotel, nằm ở , được đánh giá Xuất sắc, địa chỉ: 52 Bat Su, Hang Bo Ward, Hoan Kiem District', 2091600.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(88, 'San Premium Hotel', 'Hải Phòng', 'San Premium Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 36 - 38 Ha Trung, Hang Bong, Hoan Kiem', 1620000.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(89, 'La Siesta Classic Hang Thung', 'Hải Phòng', 'La Siesta Classic Hang Thung, nằm ở , được đánh giá Xuất sắc, địa chỉ: 21 Phố Hàng Thùng', 2752245.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(90, 'Dream Central Hotel & Spa - Hanoi Old Quarter', 'Hải Phòng', 'Dream Central Hotel & Spa - Hanoi Old Quarter, nằm ở , được đánh giá Rất tốt, địa chỉ: 53 Thuoc Bac', 1103600.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(91, 'Casa Valentina Hanoi Hotel', 'Hải Phòng', 'Casa Valentina Hanoi Hotel, nằm ở , được đánh giá Xuất sắc, địa chỉ: 49 Phố Hàng Gà', 1260000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(92, 'La Passion Hanoi Hotel & Spa', 'Hải Phòng', 'La Passion Hanoi Hotel & Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: Hàng Thùng 26', 2245320.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(93, 'Hanoi Media Hotel & Spa', 'Hải Phòng', 'Hanoi Media Hotel & Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 11 Hang Dau', 1787560.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(94, 'La Renta Premier Hotel & Spa Hanoi', 'Hải Phòng', 'La Renta Premier Hotel & Spa Hanoi, nằm ở , được đánh giá Tốt, địa chỉ: 23E Bat Dan', 1020000.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(95, 'Silk Path Hotel Hanoi', 'Hải Phòng', 'Silk Path Hotel Hanoi, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 195-199 Hang Bong Street', 1955813.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(96, 'BIG Apartment Ha Noi', 'Hải Phòng', 'BIG Apartment Ha Noi, nằm ở Cau Giay, được đánh giá Rất tốt, địa chỉ: ngõ 75 Trần Thái Tông Lô A19 D7 khu Đo thị mới Cầu Giấy', 732564.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Cau Giay', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(97, 'Bella Rosa Hotel & Travel', 'Hải Phòng', 'Bella Rosa Hotel & Travel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 21 Cau Go', 1365120.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(98, 'Hanoi Southgate Hotel & Spa', 'Hải Phòng', 'Hanoi Southgate Hotel & Spa, nằm ở , được đánh giá , địa chỉ: 32 Phố Cửa Nam', 1075000.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(99, 'Sunline Central Hotel', 'Hải Phòng', 'Sunline Central Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 18 Bao Khanh Lane, Hoan Kiem', 2150702.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(100, 'Alisa Hotel & Spa', 'Hải Phòng', 'Alisa Hotel & Spa, nằm ở , được đánh giá Rất tốt, địa chỉ: 7 Hàng Vôi', 1125180.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(101, 'The Lapis Hotel', 'Hải Phòng', 'The Lapis Hotel, nằm ở , được đánh giá Rất tốt, địa chỉ: 21 Tran Hung Dao St, Hoan Kiem Dist', 1969920.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(102, 'La Mejor Hotel & Sky Bar', 'Phú Quốc', 'La Mejor Hotel & Sky Bar, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 22 Ta Hien Street', 3115200.00, 'Khách sạn sở hữu sky bar tầng thượng với view toàn cảnh thành phố ngoạn mục, là điểm đến lý tưởng để thưởng thức cocktail và ngắm hoàng hôn. Không gian bar sang trọng với thiết kế hiện đại, bàn ghế được bố trí tối ưu để tận hưởng trọn vẹn khung cảnh. Menu cocktail đặc biệt được pha chế bởi bartender chuyên nghiệp, kết hợp cùng âm nhạc sôi động và không khí sầm uất. Phòng nghệ được thiết kế tinh tế với ban công riêng, giường king size êm ái và phòng tắm sang trọng. Dịch vụ phòng 24/7, minibar đa dạng và hệ thống giải trí hiện đại. Thích hợp cho các cặp đôi, nhóm bạn và các sự kiện đặc biệt.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Sky bar\", \"Restaurant\", \"Bar\", \"Spa\", \"Terrace\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(103, 'Amira Hotel Hanoi', 'Phú Quốc', 'Amira Hotel Hanoi, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 1 Ngõ Gạch, Hàng Buồm', 1760000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(104, 'GRAND CITITEL Hanoi Hotel & Spa', 'Phú Quốc', 'GRAND CITITEL Hanoi Hotel & Spa, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 13B Tong Dan, Trang Tien Ward, Hoan Kiem District', 2160000.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(105, 'Le Chanvre Hanoi Hotel & Spa', 'Phú Quốc', 'Le Chanvre Hanoi Hotel & Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 84-86 Hang Gai Str, Hoan Kiem Disctrict', 3175200.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 50, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved');
INSERT INTO `hotels` (`id`, `name`, `province`, `description`, `price`, `text`, `name_nearby_place`, `hotel_class`, `amenities`, `created_at`, `updated_at`, `user_id`, `status`) VALUES
(106, 'The Flower Boutique Hotel & Travel', 'Phú Quốc', 'The Flower Boutique Hotel & Travel, nằm ở Quận Ba Đình, được đánh giá Tuyệt vời, địa chỉ: 055 Nguyễn Trường Tộ', 1700000.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Ba Đình', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:06', '2025-10-09 20:17:06', NULL, 'approved'),
(107, 'The Sono Hanoi Hotel', 'Phú Quốc', 'The Sono Hanoi Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 56A Hàng Đậu, Đồng Xuân, Hoàn Kiếm', 1093500.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(108, 'Golden Legend Palace Hotel & Travel', 'Phú Quốc', 'Golden Legend Palace Hotel & Travel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 2 Nguyen Huu Huan Alley', 1150000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(109, 'Charmpearl Hotel & Suites', 'Phú Quốc', 'Charmpearl Hotel & Suites, nằm ở Quận Ba Đình, được đánh giá Tuyệt vời, địa chỉ: 25 Ngõ 36 Giang Văn Minh', 1555200.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Ba Đình', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(110, 'DE LA SOIE Hotel & Travel', 'Phú Quốc', 'DE LA SOIE Hotel & Travel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 111 Hàng Đào Hoàn Kiếm', 1210000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(111, 'Hanoi Harmonia Hotel & Spa', 'Phú Quốc', 'Hanoi Harmonia Hotel & Spa, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 98 Hang Gai, Hoan Kiem', 1539000.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(112, 'Silk Castle Hotel & Spa - Hanoi Old quarter', 'Phú Quốc', 'Silk Castle Hotel & Spa - Hanoi Old quarter, nằm ở , được đánh giá Rất tốt, địa chỉ: 52A Phố Cầu Gỗ', 1035000.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(113, 'JM Marvel Hotel & Spa', 'Phú Quốc', 'JM Marvel Hotel & Spa, nằm ở , được đánh giá Xuất sắc, địa chỉ: 16 Hang Da, Hoan Kiem', 3397350.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(114, 'Elegant Suites Central', 'Phú Quốc', 'Elegant Suites Central, nằm ở , được đánh giá Xuất sắc, địa chỉ: 19B Ng Xóm Hạ Hồi', 2493750.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(115, 'NT Elysian hotel', 'Phú Quốc', 'NT Elysian hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 13 Phố Hàng Chiếu', 940000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(116, '22Land 71 Hang Bong Hotel', 'Phú Quốc', '22Land 71 Hang Bong Hotel, nằm ở , được đánh giá Rất tốt, địa chỉ: 71 Hàng Bông', 1630737.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(117, 'Hanoi Center Silk Lullaby Hotel and Travel', 'Phú Quốc', 'Hanoi Center Silk Lullaby Hotel and Travel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 16 Phố Ngõ Trạm, Phường Hàng Bông, ', 1239556.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(118, 'Hanoi La Selva Central Hotel & Spa', 'Phú Quốc', 'Hanoi La Selva Central Hotel & Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 90 Cầu Gỗ', 1630125.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(119, 'San Hanoi Hotel & Spa', 'Phú Quốc', 'San Hanoi Hotel & Spa, nằm ở Cau Giay, được đánh giá Xuất sắc, địa chỉ: B2/D6 Ngõ 75 Phố Trần Thái Tông', 974400.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Cau Giay', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(120, 'Eli Rina Hotel', 'Phú Quốc', 'Eli Rina Hotel, nằm ở Quận Đống Đa, được đánh giá Tuyệt hảo, địa chỉ: Ngõ 115 Phố Nguyễn Khuyến', 1765575.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Đống Đa', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(121, 'Hanoi L\'Heritage Diamond Hotel & Spa', 'Phú Quốc', 'Hanoi L\'Heritage Diamond Hotel & Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 17 Nhà Chung Hàng Trống, Hoàn Kiếm , Hà Nội', 1984500.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(122, 'Minasi Grand Hotel', 'Phú Quốc', 'Minasi Grand Hotel, nằm ở Quận Hai Bà Trưng, được đánh giá Xuất sắc, địa chỉ: 61 Ngõ Huế', 1663481.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hai Bà Trưng', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(123, 'Hanoi Hotel Royal', 'Phú Quốc', 'Hanoi Hotel Royal, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 26 Phat Loc', 1551000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(124, 'Hong Ngoc Dynastie Boutique Hotel & Spa', 'Phú Quốc', 'Hong Ngoc Dynastie Boutique Hotel & Spa, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 30 - 34 Hang Manh', 1911000.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(125, 'Family Suite Hotel', 'Phú Quốc', 'Family Suite Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 39B Hang Hanh Street', 1691087.00, 'Khách sạn gia đình với không gian ấm cúng, được thiết kế đặc biệt cho các kỳ nghỉ cùng người thân. Phòng gia đình rộng rãi với diện tích từ 40m2, bao gồm phòng ngủ chính và phòng ngủ phụ cho trẻ em. Mỗi phòng đều có khu vực chơi cho trẻ, TV với kênh thiếu nhi và giường cũi theo yêu cầu. Khu vui chơi trẻ em trong nhà với đồ chơi an toàn, cầu tuột và khu vẽ tranh. Nhà hàng với thực đơn đa dạng, đáp ứng mọi khẩu vị từ trẻ nhỏ đến người lớn, bao gồm cả các món ăn kiêng và đồ ăn cho bé. Dịch vụ trông trẻ chuyên nghiệp, hồ bơi trẻ em riêng biệt và các hoạt động giải trí gia đình được tổ chức hàng tuần.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\", \"Laundry\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(126, '22Land Classic Suites', 'Phú Quốc', '22Land Classic Suites, nằm ở Cau Giay, được đánh giá Rất tốt, địa chỉ: No.35, Lane 75, Tran Thai Tong', 815480.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Cau Giay', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(127, '22Land Heritage Hotel & Retreat', 'Phú Quốc', '22Land Heritage Hotel & Retreat, nằm ở Cau Giay, được đánh giá Rất tốt, địa chỉ: Phường Dịch Vọng Hầu, Quận Cầu Giấy Số 5, Ngõ 82/1 Dịch Vọng Hậu', 1476300.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Cau Giay', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(128, 'La Sinfonía Citadel Hotel and Spa', 'Phú Quốc', 'La Sinfonía Citadel Hotel and Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 12-14 Dinh Ngang, Hoan Kiem', 2281192.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(129, 'Minerva Church Hotel', 'Phú Quốc', 'Minerva Church Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 9 Nha Tho', 2227500.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(130, 'Aquarius Premium Hotel', 'Phú Quốc', 'Aquarius Premium Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 61 Phố Đường Thành', 1511100.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(131, 'Minasi HanoiOi Lakeside Hotel', 'Phú Quốc', 'Minasi HanoiOi Lakeside Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 30 Bà Triệu', 2152086.00, 'Tận hưởng không gian yên bình với view hồ tuyệt đẹp ngay từ phòng nghỉ, nơi bạn có thể ngắm bình minh và hoàng hôn trên mặt hồ. Căn hộ được thiết kế như nhà riêng với đầy đủ tiện nghi: bếp đầy đủ dụng cụ nấu ăn, phòng khách rộng rãi với sofa thoải mái, ban công thoáng mát với bàn ghế thư giãn. Mỗi căn hộ đều có phòng ngủ riêng biệt với giường king size, tủ quần áo rộng rãi và phòng tắm hiện đại. Khu vực hồ bơi riêng được bao quanh bởi vườn cây xanh mát, tạo không gian thư giãn lý tưởng. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/24 và hỗ trợ đặt vé tham quan. Lý tưởng cho kỳ nghỉ gia đình hoặc công tác dài ngày.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Kitchenette\", \"Lake view\", \"Terrace\", \"Family rooms\", \"Laundry\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(132, 'Golden Sun Hotel', 'Phú Quốc', 'Golden Sun Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 33 Hang Quat Street, Hoan Kiem, Hanoi, Vietnam', 1451520.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(133, 'Hanoi La Cascada House & Travel', 'Đà Lạt', 'Hanoi La Cascada House & Travel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 9 Phố Gầm Cầu, Phường Đồng Xuân, , Hà Nội, Việt Nam', 918540.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(134, 'An Nguyen Boutique Hotel', 'Đà Lạt', 'An Nguyen Boutique Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 10 Hang Giay, Dong Xuan, Hoan Kiem', 877500.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(135, 'Grande Collection Hotel & Spa', 'Đà Lạt', 'Grande Collection Hotel & Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 46 - 48 Bat Su Street', 1785000.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(136, 'Astoria Hanoi Hotel & Travel', 'Đà Lạt', 'Astoria Hanoi Hotel & Travel, nằm ở , được đánh giá Xuất sắc, địa chỉ: 16 Ngõ Huyện', 1790100.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(137, 'Skylark Boutique Hotel', 'Đà Lạt', 'Skylark Boutique Hotel, nằm ở Quận Ba Đình, được đánh giá Tốt, địa chỉ: 15D-17 Phan Dinh Phung', 1020600.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Ba Đình', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(138, 'Silk Hanoi Moment Hotel & Spa - Hanoi Old Quarter', 'Đà Lạt', 'Silk Hanoi Moment Hotel & Spa - Hanoi Old Quarter, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 19 Phố Hàng Mành', 1240200.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(139, 'Thien Thai Hotel & Spa', 'Đà Lạt', 'Thien Thai Hotel & Spa, nằm ở Quận Ba Đình, được đánh giá Xuất sắc, địa chỉ: 45 Nguyen Truong To', 2400000.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Ba Đình', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(140, 'Golden Sail Hotel & Spa', 'Đà Lạt', 'Golden Sail Hotel & Spa, nằm ở , được đánh giá Rất tốt, địa chỉ: 55 Hang Buom, Hoan Kiem', 990000.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(141, 'La Passion Classic Hotel', 'Đà Lạt', 'La Passion Classic Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: No 1 Phan Dinh Phung street, Hoan Kiem district', 1312500.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(142, 'Hanoi Little Town Hotel', 'Đà Lạt', 'Hanoi Little Town Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 77 Hang Luoc Street', 1071574.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(143, 'The Little Hanoi - Fresh Home - Centered', 'Đà Lạt', 'The Little Hanoi - Fresh Home - Centered, nằm ở Cau Giay, được đánh giá Xuất sắc, địa chỉ: Số 2 Ngõ 72/12 phố Dương Quảng Hàm', 517942.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Cau Giay', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(144, 'La Palm Boutique Hotel', 'Đà Lạt', 'La Palm Boutique Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: No. 18, Dao Duy Tu Street, Hang Buom Ward, Hoan Kiem District, Hanoi, Vietnam', 1306013.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:07', '2025-10-09 20:17:07', NULL, 'approved'),
(145, 'Blue Hanoi Inn Hotel', 'Đà Lạt', 'Blue Hanoi Inn Hotel, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 12B Chan Cam', 1050000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(146, 'Dream Premium Hotel & Spa', 'Đà Lạt', 'Dream Premium Hotel & Spa, nằm ở , được đánh giá Rất tốt, địa chỉ: 30 Phố Cửa Nam', 1164670.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(147, 'Westlake Pearl Suites & Spa 70 Xuan Dieu - By Pegasy Group', 'Đà Lạt', 'Westlake Pearl Suites & Spa 70 Xuan Dieu - By Pegasy Group, nằm ở Quận Tây Hồ, được đánh giá Tuyệt hảo, địa chỉ: 70 Đ. Xuân Diệu', 1120000.00, 'Tọa lạc tại vị trí đắc địa với tầm nhìn tuyệt đẹp ra thành phố, khách sạn cung cấp các suite rộng rãi được thiết kế sang trọng và dịch vụ spa đẳng cấp quốc tế. Mỗi phòng suite được trang bị phòng tắm riêng với bồn tắm massage, phòng khách riêng biệt và ban công rộng với view toàn cảnh. Hồ bơi vô cực ngoài trời được thiết kế tinh xảo, phòng tập gym hiện đại với đầy đủ thiết bị và nhà hàng ẩm thực đa dạng mang đến trải nghiệm nghỉ dưỡng trọn vẹn. Đội ngũ nhân viên chuyên nghiệp luôn sẵn sàng phục vụ 24/7, cung cấp dịch vụ đưa đón tận nơi và hỗ trợ đặt tour du lịch. Không gian kiến trúc kết hợp hài hòa giữa nét hiện đại và truyền thống, tạo nên một điểm đến lý tưởng cho cả du lịch và công tác.', 'Quận Tây Hồ', 40, '[\"WiFi\", \"Spa\", \"Swimming pool\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Kitchenette\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(148, 'Midori Boutique Hotel', 'Đà Lạt', 'Midori Boutique Hotel, nằm ở Quận Hai Bà Trưng, được đánh giá Tuyệt hảo, địa chỉ: 43 Trieu Viet Vuong Street', 2187000.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hai Bà Trưng', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(149, 'An Nguyen Lakeside Residence', 'Đà Lạt', 'An Nguyen Lakeside Residence, nằm ở Quận Ba Đình, được đánh giá Xuất sắc, địa chỉ: 45 Phố Trúc Bạch', 1440000.00, 'Tận hưởng không gian yên bình với view hồ tuyệt đẹp ngay từ phòng nghỉ, nơi bạn có thể ngắm bình minh và hoàng hôn trên mặt hồ. Căn hộ được thiết kế như nhà riêng với đầy đủ tiện nghi: bếp đầy đủ dụng cụ nấu ăn, phòng khách rộng rãi với sofa thoải mái, ban công thoáng mát với bàn ghế thư giãn. Mỗi căn hộ đều có phòng ngủ riêng biệt với giường king size, tủ quần áo rộng rãi và phòng tắm hiện đại. Khu vực hồ bơi riêng được bao quanh bởi vườn cây xanh mát, tạo không gian thư giãn lý tưởng. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/24 và hỗ trợ đặt vé tham quan. Lý tưởng cho kỳ nghỉ gia đình hoặc công tác dài ngày.', 'Quận Ba Đình', 0, '[\"WiFi\", \"Kitchenette\", \"Lake view\", \"Terrace\", \"Family rooms\", \"Laundry\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(150, 'EVEREST HOTEL', 'Đà Lạt', 'EVEREST HOTEL, nằm ở Quận Thanh Xuân, được đánh giá Tuyệt vời, địa chỉ: Nguyễn Ngọc Nại 44', 897750.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Thanh Xuân', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(151, 'Family Hanoi Hotel', 'Đà Lạt', 'Family Hanoi Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 39C Hang Hanh Street, Hoan Kiem', 2086651.00, 'Khách sạn gia đình với không gian ấm cúng, được thiết kế đặc biệt cho các kỳ nghỉ cùng người thân. Phòng gia đình rộng rãi với diện tích từ 40m2, bao gồm phòng ngủ chính và phòng ngủ phụ cho trẻ em. Mỗi phòng đều có khu vực chơi cho trẻ, TV với kênh thiếu nhi và giường cũi theo yêu cầu. Khu vui chơi trẻ em trong nhà với đồ chơi an toàn, cầu tuột và khu vẽ tranh. Nhà hàng với thực đơn đa dạng, đáp ứng mọi khẩu vị từ trẻ nhỏ đến người lớn, bao gồm cả các món ăn kiêng và đồ ăn cho bé. Dịch vụ trông trẻ chuyên nghiệp, hồ bơi trẻ em riêng biệt và các hoạt động giải trí gia đình được tổ chức hàng tuần.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\", \"Laundry\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(152, 'Hanoi Kingly Hotel', 'Đà Lạt', 'Hanoi Kingly Hotel, nằm ở , được đánh giá Rất tốt, địa chỉ: 8A Ly Thai To, Hoan Kiem', 2318400.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(153, 'Parklane Central Hanoi Hotel', 'Đà Lạt', 'Parklane Central Hanoi Hotel, nằm ở , được đánh giá Tuyệt vời, địa chỉ: Số 4 Phố Tố Tịch, phường Hàng Gai, ', 992612.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(154, 'Gatsby Central Hotel Hanoi', 'Đà Lạt', 'Gatsby Central Hotel Hanoi, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 69 Hàng Thiếc Street, Hoàn Kiếm District', 1040000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(155, 'iRest Signature Ba Dinh Lakeside', 'Đà Lạt', 'iRest Signature Ba Dinh Lakeside, nằm ở Quận Ba Đình, được đánh giá Xuất sắc, địa chỉ: 62 Phố Phạm Huy Thông', 765703.00, 'Tận hưởng không gian yên bình với view hồ tuyệt đẹp ngay từ phòng nghỉ, nơi bạn có thể ngắm bình minh và hoàng hôn trên mặt hồ. Căn hộ được thiết kế như nhà riêng với đầy đủ tiện nghi: bếp đầy đủ dụng cụ nấu ăn, phòng khách rộng rãi với sofa thoải mái, ban công thoáng mát với bàn ghế thư giãn. Mỗi căn hộ đều có phòng ngủ riêng biệt với giường king size, tủ quần áo rộng rãi và phòng tắm hiện đại. Khu vực hồ bơi riêng được bao quanh bởi vườn cây xanh mát, tạo không gian thư giãn lý tưởng. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/24 và hỗ trợ đặt vé tham quan. Lý tưởng cho kỳ nghỉ gia đình hoặc công tác dài ngày.', 'Quận Ba Đình', 30, '[\"WiFi\", \"Kitchenette\", \"Lake view\", \"Terrace\", \"Family rooms\", \"Laundry\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(156, 'TrangTrang Luxury Hotel', 'Đà Lạt', 'TrangTrang Luxury Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 15 Phố Hàng Dầu', 2444000.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(157, 'Luxor Boutique Hotel', 'Đà Lạt', 'Luxor Boutique Hotel, nằm ở Quận Hai Bà Trưng, được đánh giá Tuyệt vời, địa chỉ: 73 To Hien Thanh', 1284416.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hai Bà Trưng', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved');
INSERT INTO `hotels` (`id`, `name`, `province`, `description`, `price`, `text`, `name_nearby_place`, `hotel_class`, `amenities`, `created_at`, `updated_at`, `user_id`, `status`) VALUES
(158, 'Hanoi Emotion Hotel', 'Đà Lạt', 'Hanoi Emotion Hotel, nằm ở Quận Đống Đa, được đánh giá Rất tốt, địa chỉ: 26 Hang Bot Street', 720000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Đống Đa', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(159, '22Land Moon West Lake', 'Đà Lạt', '22Land Moon West Lake, nằm ở Quận Tây Hồ, được đánh giá Rất tốt, địa chỉ: 185 Trích Sài', 734400.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Tây Hồ', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(160, 'Kingdom Hotel Hanoi', 'Đà Lạt', 'Kingdom Hotel Hanoi, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 64 Phố Đào Duy Từ', 1108080.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(161, 'Spring Hotel Hanoi', 'Đà Lạt', 'Spring Hotel Hanoi, nằm ở Cau Giay, được đánh giá Rất tốt, địa chỉ: 100 Dich Vong Hau Street, Cau Giay District', 926100.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Cau Giay', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(162, 'Hotel du Monde', 'Đà Lạt', 'Hotel du Monde, nằm ở Quận Long Biên, được đánh giá Rất tốt, địa chỉ: No 89, Hoang Nhu Tiep Street Long Bien District', 1347840.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Long Biên', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(163, 'Solaria Hanoi Hotel', 'Hà Nội', 'Solaria Hanoi Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 22, Bao Khanh Street, Hoan Kiem District', 2960550.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(164, 'PALAGO BOUTIQUE HOTEL', 'Hoàn Kiếm', 'PALAGO BOUTIQUE HOTEL, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 10 Phố Bát Đàn', 2754000.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(165, '22Housing luxury Hotel & Residence 39 Linh Lang', 'Hà Nội', '22Housing luxury Hotel & Residence 39 Linh Lang, nằm ở Quận Ba Đình, được đánh giá Rất tốt, địa chỉ: 39 Linh Lang', 1036800.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Ba Đình', 0, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(166, 'Westlake Emerald Suites', 'Hà Nội', 'Westlake Emerald Suites, nằm ở Quận Tây Hồ, được đánh giá Tốt, địa chỉ: 15 Đường Tây Hồ Quảng An, Tây Hồ, Hà Nội.', 633728.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Tây Hồ', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(167, 'Madelise Stardust Hotel & Travel', 'Hà Nội', 'Madelise Stardust Hotel & Travel, nằm ở , được đánh giá Rất tốt, địa chỉ: 11 Phố Nguyễn Thái Học', 900000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(168, 'Hanoi La Selva Hotel', 'Hà Nội', 'Hanoi La Selva Hotel, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 57 Lo Su Street', 1630125.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(169, 'Amanda Boutique Hotel & Travel', 'Hoàn Kiếm', 'Amanda Boutique Hotel & Travel, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 62E Phố Cầu Gỗ', 803358.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(170, 'Lotte Hotel Hanoi', 'Hà Nội', 'Lotte Hotel Hanoi, nằm ở Quận Ba Đình, được đánh giá Tuyệt hảo, địa chỉ: 54 Lieu Giai Street', 4394250.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Ba Đình', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(171, 'Hanoi Pearl Hotel', 'Hà Nội', 'Hanoi Pearl Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: Number 6 - Bao Khanh lane', 2660505.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(172, 'Phoenix Palace Hotel Hanoi', 'Hà Nội', 'Phoenix Palace Hotel Hanoi, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 27 Phu Doan Street', 1371825.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(173, 'Mai Hotel', 'Hà Nội', 'Mai Hotel, nằm ở Quận Đống Đa, được đánh giá Tuyệt vời, địa chỉ: 39 Phố Đặng Văn Ngữ 39 Đặng Văn Ngữ', 748800.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Đống Đa', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(174, 'ĐỨC TRỌNG HOTEL', 'Hà Nội', 'ĐỨC TRỌNG HOTEL, nằm ở Quận Đống Đa, được đánh giá Tốt, địa chỉ: 38 Phố Vọng Số Nhà 38 Phố Vọng Phường Phương MMai, Quận ĐốnĐống Đa, Hà Nội', 472500.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Đống Đa', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(175, 'Pan Pacific Hanoi', 'Hà Nội', 'Pan Pacific Hanoi, nằm ở Quận Ba Đình, được đánh giá Rất tốt, địa chỉ: 1 Thanh Nien Road', 4462617.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Ba Đình', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(176, 'An Nguyen Building', 'Hà Nội', 'An Nguyen Building, nằm ở Quận Ba Đình, được đánh giá Tuyệt hảo, địa chỉ: 59 Nguyen Khac Hieu, Truc Bach, Ba Dinh', 820000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Ba Đình', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(177, 'Madelise Grand Hotel', 'Hoàn Kiếm', 'Madelise Grand Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 3A hang mam, hoan kiem , hanoi', 1360125.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(178, 'Babylon Grand Hotel & Spa', 'Hà Nội', 'Babylon Grand Hotel & Spa, nằm ở Quận Ba Đình, được đánh giá Rất tốt, địa chỉ: 57 Pham Hong Thai', 1316250.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Ba Đình', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(179, 'Hanoi Golden Sunshine Villa Hotel and Travel', 'Hà Nội', 'Hanoi Golden Sunshine Villa Hotel and Travel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 68 Hang Trong - Hoan Kiem', 1500000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(180, 'Mövenpick Hotel Hanoi Centre', 'Hà Nội', 'Mövenpick Hotel Hanoi Centre, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 83A Ly Thuong Kiet Street', 3980340.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(181, 'Affa Boutique Hotel', 'Hoàn Kiếm', 'Affa Boutique Hotel, nằm ở , được đánh giá Tốt, địa chỉ: Tràng Thi 17', 1017586.80, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(182, 'Hanoi Riverview Boutique Hotel & Apartment', 'Nha Trang', 'Hanoi Riverview Boutique Hotel & Apartment, nằm ở Quận Tây Hồ, được đánh giá Tuyệt hảo, địa chỉ: 25 Ngách 264/21 Đường Âu Cơ', 3454545.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Tây Hồ', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(183, 'iRest Orange Tay Ho Lakeside Apartment', 'Nha Trang', 'iRest Orange Tay Ho Lakeside Apartment, nằm ở Quận Tây Hồ, được đánh giá Tuyệt hảo, địa chỉ: 196 Phố Vũ Miên', 875000.00, 'Tận hưởng không gian yên bình với view hồ tuyệt đẹp ngay từ phòng nghỉ, nơi bạn có thể ngắm bình minh và hoàng hôn trên mặt hồ. Căn hộ được thiết kế như nhà riêng với đầy đủ tiện nghi: bếp đầy đủ dụng cụ nấu ăn, phòng khách rộng rãi với sofa thoải mái, ban công thoáng mát với bàn ghế thư giãn. Mỗi căn hộ đều có phòng ngủ riêng biệt với giường king size, tủ quần áo rộng rãi và phòng tắm hiện đại. Khu vực hồ bơi riêng được bao quanh bởi vườn cây xanh mát, tạo không gian thư giãn lý tưởng. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/24 và hỗ trợ đặt vé tham quan. Lý tưởng cho kỳ nghỉ gia đình hoặc công tác dài ngày.', 'Quận Tây Hồ', 0, '[\"WiFi\", \"Kitchenette\", \"Lake view\", \"Terrace\", \"Family rooms\", \"Laundry\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(184, 'Soleil Boutique Hotel Hanoi', 'Nha Trang', 'Soleil Boutique Hotel Hanoi, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 211 Hàng Bông Street, Hoàn Kiếm District', 3520890.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:08', '2025-10-09 20:17:08', NULL, 'approved'),
(185, '22Land Residence Hotel & Spa Hanoi', 'Nha Trang', '22Land Residence Hotel & Spa Hanoi, nằm ở Cau Giay, được đánh giá Rất tốt, địa chỉ: 2 Nguyễn Đình Hoàn', 908438.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Cau Giay', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(186, 'Rosa Hanoi Hotel', 'Nha Trang', 'Rosa Hanoi Hotel, nằm ở Cau Giay, được đánh giá Tuyệt hảo, địa chỉ: Số 4 ,Trung Yên 10A, lô 4D', 497250.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Cau Giay', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(187, 'Lucky Central Hotel & Travel', 'Nha Trang', 'Lucky Central Hotel & Travel, nằm ở , được đánh giá Rất tốt, địa chỉ: 12 Hàng Trống, P. Hàng Trống', 910000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(188, 'Lucky 2 Hotel & Travel', 'Nha Trang', 'Lucky 2 Hotel & Travel, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 46 Hang Hom Street', 845000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(189, 'Golden Rooster Hotel', 'Nha Trang', 'Golden Rooster Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 17B Hang Ga, Hang Bo, Hoan Kiem', 1190000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(190, 'Hanoi Golden Hostel', 'Nha Trang', 'Hanoi Golden Hostel, nằm ở , được đánh giá Rất tốt, địa chỉ: 51 Nguyen Sieu Street - Hoan Kiem District', 806400.00, 'Không gian trẻ trung, năng động dành cho du khách ba lô với mức giá hợp lý. Phòng dorm sạch sẽ được chia thành các capsule riêng tư với rèm che, ổ khóa cá nhân và đèn đọc sách riêng. Mỗi capsule đều có ổ cắm điện, kệ để đồ và không gian đủ rộng để nghỉ ngơi thoải mái. Khu vực bếp chung được trang bị đầy đủ dụng cụ nấu ăn, tủ lạnh và máy giặt tự động. Phòng sinh hoạt cộng đồng rộng rãi với TV, kệ sách và bàn bi-a, tạo cơ hội kết nối với du khách từ khắp nơi trên thế giới. Dịch vụ đặt tour giá rẻ, thuê xe máy và hướng dẫn du lịch bản địa. Vị trí trung tâm, thuận tiện di chuyển đến các điểm tham quan nổi tiếng.', 'Quận Hoàn Kiếm', 20, '[\"WiFi\", \"Shared kitchen\", \"Common area\", \"Laundry\", \"Bicycle rental\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(191, 'LIVIE Hanoi Ham Long', 'Nha Trang', 'LIVIE Hanoi Ham Long, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 42a Phố Hàm Long Hoàn Kiếm', 971999.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(192, 'The Euphoria', 'Nha Trang', 'The Euphoria, nằm ở Quận Tây Hồ, được đánh giá Tuyệt hảo, địa chỉ: The Euphoria 20', 683820.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Tây Hồ', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(193, 'Lucky 3 Hotel & Travel', 'Nha Trang', 'Lucky 3 Hotel & Travel, nằm ở , được đánh giá Rất tốt, địa chỉ: 81 Hang Bong Street', 988000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(194, 'Atlanta Residences', 'Nha Trang', 'Atlanta Residences, nằm ở Quận Hai Bà Trưng, được đánh giá Tuyệt hảo, địa chỉ: 49 Hang Chuoi', 1923801.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Quận Hai Bà Trưng', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(195, 'The La Renta Hotel & Spa', 'Nha Trang', 'The La Renta Hotel & Spa, nằm ở , được đánh giá Rất tốt, địa chỉ: 14 Phố Lương Văn Can', 600000.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(196, 'Westlake Tay Ho Hotel 696 Lạc Long Quân', 'Nha Trang', 'Westlake Tay Ho Hotel 696 Lạc Long Quân, nằm ở Quận Tây Hồ, được đánh giá Dễ chịu, địa chỉ: 696 Lac Long Quan Str, Nhat Tan Ward, Tay Ho District', 360450.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Tây Hồ', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(197, 'TrangTrang Premium Hotel & Sky Bar', 'Nha Trang', 'TrangTrang Premium Hotel & Sky Bar, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 15B Ngõ Cầu Gỗ, Phường Hàng Bạc, Hoàn Kiếm', 1055500.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(198, '22 Land Hotel', 'Nha Trang', '22 Land Hotel, nằm ở Quận Ba Đình, được đánh giá Xuất sắc, địa chỉ: 152 P. Nguyễn Thái Học 9', 1623232.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Ba Đình', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(199, 'The Little\'N Homestay Ha Noi 59', 'Nha Trang', 'The Little\'N Homestay Ha Noi 59, nằm ở Cau Giay, được đánh giá Tuyệt vời, địa chỉ: 80 Ngõ 59 Phạm Văn Đồng', 402944.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Cau Giay', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(200, 'O\'Gallery Premier Hotel & Spa', 'Nha Trang', 'O\'Gallery Premier Hotel & Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 122 Hang Bong', 2449296.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(201, 'Melia Hanoi', 'Nha Trang', 'Melia Hanoi, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 44B Ly Thuong Kiet Street', 3894705.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(202, 'GrandView Hotel & Residence Hanoi', 'Nha Trang', 'GrandView Hotel & Residence Hanoi, nằm ở Cau Giay, được đánh giá Xuất sắc, địa chỉ: 369 Đường Nguyễn Khang', 2027250.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Cau Giay', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(203, 'Aviary Hanoi Hotel & Travel', 'Nha Trang', 'Aviary Hanoi Hotel & Travel, nằm ở , được đánh giá Tuyệt vời, địa chỉ: SN 19 ngo Trung Yen, P. Hang Bac, Q. Hoan Kiem', 969607.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(204, 'Bonjour D\'An Nam Hotel', 'Nha Trang', 'Bonjour D\'An Nam Hotel, nằm ở , được đánh giá Rất tốt, địa chỉ: 32 Phố Đào Duy Từ', 1377000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(205, 'Hanoi Fiesta Central Hotel and Spa', 'Nha Trang', 'Hanoi Fiesta Central Hotel and Spa, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 18 Hàng Đường', 2389500.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(206, 'Tranquility Stay Old Quarter', 'Nha Trang', 'Tranquility Stay Old Quarter, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 86 Phố Hàng Buồm The second floor', 994500.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(207, 'The Q Hotel', 'Nha Trang', 'The Q Hotel, nằm ở Quận Ba Đình, được đánh giá Tuyệt vời, địa chỉ: 87 Nguyễn Trường Tộ Truc Bach Ward, Ba Dinh District, Hanoi', 17010000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Ba Đình', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(208, 'Lotusama Central Hanoi Hotel', 'Nha Trang', 'Lotusama Central Hanoi Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 37 Phố Hàng Gà', 1331618.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(209, 'Crescendo Apartment Quang Khanh', 'Nha Trang', 'Crescendo Apartment Quang Khanh, nằm ở Quận Tây Hồ, được đánh giá Tuyệt hảo, địa chỉ: 13 Phố Quảng Khánh', 1023750.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Quận Tây Hồ', 40, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(210, 'Poonsa Hanoi - The Ordinary Living', 'Nha Trang', 'Poonsa Hanoi - The Ordinary Living, nằm ở Cau Giay, được đánh giá Rất tốt, địa chỉ: Lot D2/D6, No. 05 Tho Thap Street, Dich Vong Hau Ward, Cau Giay District', 724337.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Cau Giay', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved');
INSERT INTO `hotels` (`id`, `name`, `province`, `description`, `price`, `text`, `name_nearby_place`, `hotel_class`, `amenities`, `created_at`, `updated_at`, `user_id`, `status`) VALUES
(211, 'Pan House', 'Nha Trang', 'Pan House, nằm ở Quận Tây Hồ, được đánh giá Tuyệt vời, địa chỉ: 2 Phố Võng Thị', 525000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Tây Hồ', 20, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(212, '22Land Legend Hotel & Residence', 'Nha Trang', '22Land Legend Hotel & Residence, nằm ở Cau Giay, được đánh giá Tuyệt hảo, địa chỉ: 15 Phố Duy Tân', 1505000.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Cau Giay', 40, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(213, 'Anise Hotel & Spa Hanoi', 'Nha Trang', 'Anise Hotel & Spa Hanoi, nằm ở Quận Ba Đình, được đánh giá Tuyệt vời, địa chỉ: 22 Quan Thanh Street', 1607200.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Ba Đình', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(214, 'Atlantis Apartment Nguyen Thai Hoc', 'Nha Trang', 'Atlantis Apartment Nguyen Thai Hoc, nằm ở Quận Ba Đình, được đánh giá Tốt, địa chỉ: 123 Phố Nguyễn Thái Học', 507465.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Quận Ba Đình', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(215, 'Hanoi Capsule Station Hostel', 'Nha Trang', 'Hanoi Capsule Station Hostel, nằm ở , được đánh giá Rất tốt, địa chỉ: 22 Tran Nhat Duat street, Dong Xuan ward, Hoan Kiem District', 270000.00, 'Không gian trẻ trung, năng động dành cho du khách ba lô với mức giá hợp lý. Phòng dorm sạch sẽ được chia thành các capsule riêng tư với rèm che, ổ khóa cá nhân và đèn đọc sách riêng. Mỗi capsule đều có ổ cắm điện, kệ để đồ và không gian đủ rộng để nghỉ ngơi thoải mái. Khu vực bếp chung được trang bị đầy đủ dụng cụ nấu ăn, tủ lạnh và máy giặt tự động. Phòng sinh hoạt cộng đồng rộng rãi với TV, kệ sách và bàn bi-a, tạo cơ hội kết nối với du khách từ khắp nơi trên thế giới. Dịch vụ đặt tour giá rẻ, thuê xe máy và hướng dẫn du lịch bản địa. Vị trí trung tâm, thuận tiện di chuyển đến các điểm tham quan nổi tiếng.', 'Quận Hoàn Kiếm', 0, '[\"WiFi\", \"Shared kitchen\", \"Common area\", \"Laundry\", \"Bicycle rental\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(216, 'Eli Suites', 'Nha Trang', 'Eli Suites, nằm ở Quận Đống Đa, được đánh giá Xuất sắc, địa chỉ: 115c Ngõ 115 Phố Nguyễn Khuyến', 2153500.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Đống Đa', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(217, 'Somerset Hoa Binh Hanoi', 'Nha Trang', 'Somerset Hoa Binh Hanoi, nằm ở Cau Giay, được đánh giá Tuyệt vời, địa chỉ: 106 Hoang Quoc Viet', 2041200.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Cau Giay', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(218, 'My Linh Hotel', 'Nha Trang', 'My Linh Hotel, nằm ở Quận Hai Bà Trưng, được đánh giá Tàm tạm, địa chỉ: 66 Bui Thi Xuan, Hai Ba Trung', 935190.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hai Bà Trưng', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(219, 'Minasi Premium Hotel', 'Nha Trang', 'Minasi Premium Hotel, nằm ở Quận Ba Đình, được đánh giá Tuyệt hảo, địa chỉ: 57 Phố Nguyễn Trường Tộ 57', 2112000.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Ba Đình', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(220, 'Infinity HaNoi Hotel & Travel', 'Nha Trang', 'Infinity HaNoi Hotel & Travel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 49 Phố Bát Đàn Toà Nhà', 867000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(221, 'Hanoi Nostalgia Hotel & Spa', 'Nha Trang', 'Hanoi Nostalgia Hotel & Spa, nằm ở , được đánh giá Rất tốt, địa chỉ: 15, Luong Ngoc Quyen, Hoan Kiem ', 2250000.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(222, 'MOONLIT Suites Hotel by Luxe Paradise', 'Nha Trang', 'MOONLIT Suites Hotel by Luxe Paradise, nằm ở Quận Tây Hồ, được đánh giá Tuyệt vời, địa chỉ: 7 Ngõ 275 Âu Cơ', 613700.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Tây Hồ', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(223, 'Mimosa Homestay Hanoi', 'Nha Trang', 'Mimosa Homestay Hanoi, nằm ở , được đánh giá Rất tốt, địa chỉ: 5A Phố Đinh Liệt', 810000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:09', '2025-10-09 20:17:09', NULL, 'approved'),
(224, 'TrangTrang Classy Hotel', 'Nha Trang', 'TrangTrang Classy Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 6 Phố Lương Ngọc Quyến', 944500.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(225, 'Peridot Grand Luxury Boutique Hotel', 'Nha Trang', 'Peridot Grand Luxury Boutique Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 33 Đường Thành', 5384870.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(226, 'V House 6 Serviced Apartment', 'Nha Trang', 'V House 6 Serviced Apartment, nằm ở Cau Giay, được đánh giá Rất tốt, địa chỉ: 40, Lane 171, Nguyen Ngoc Vu, Cau Giay', 540000.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Cau Giay', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(227, 'Ficus Suites', 'Nha Trang', 'Ficus Suites, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 8 Ly Nam De, Hoan Kiem', 905850.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(228, 'Crescendo Urban Stay - STAY 24h', 'Nha Trang', 'Crescendo Urban Stay - STAY 24h, nằm ở Quận Tây Hồ, được đánh giá Rất tốt, địa chỉ: 339 Đường Âu Cơ', 732000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Tây Hồ', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(229, 'Myrcella Urban Studio', 'Nha Trang', 'Myrcella Urban Studio, nằm ở Quận Ba Đình, được đánh giá Tuyệt hảo, địa chỉ: 33 Ngõ 12 Phố Đào Tấn', 1503000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Ba Đình', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(230, 'Hôtel du Parc Hanoï', 'Nha Trang', 'Hôtel du Parc Hanoï, nằm ở Quận Hai Bà Trưng, được đánh giá Tuyệt vời, địa chỉ: 84 Tran Nhan Tong Street', 2911619.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hai Bà Trưng', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(231, 'Tung Trang Hotel', 'Nha Trang', 'Tung Trang Hotel, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 13 Ngo Tam Thuong (Between 38-40 Hang Bong Street)', 768768.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 20, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(232, 'La Sinfonía del Rey Hotel & Spa', 'Hồ Chí Minh', 'La Sinfonía del Rey Hotel & Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 33-35 Hang Dau, Hoan Kiem', 3063633.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(233, 'Hai Bay Hotel & Restaurant', 'Hồ Chí Minh', 'Hai Bay Hotel & Restaurant, nằm ở , được đánh giá Rất tốt, địa chỉ: 27 Hang Bong Street, Hoan Kiem District', 1877850.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(234, 'Railway Apartment & Spa', 'Hồ Chí Minh', 'Railway Apartment & Spa, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 1D Ngõ Trạm', 2082500.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Quận Hoàn Kiếm', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(235, 'Hanoi Capital Premium Hotel', 'Hồ Chí Minh', 'Hanoi Capital Premium Hotel, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 56 Phố Ấu Triệu', 1500000.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(236, 'Hanoi Le Jardin Hotel & Spa', 'Hồ Chí Minh', 'Hanoi Le Jardin Hotel & Spa, nằm ở Quận Ba Đình, được đánh giá Tuyệt hảo, địa chỉ: 46A Nguyen Truong To', 2000000.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Ba Đình', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(237, 'Five Star Westlake 1st-4th Floors Hotel & Serviced Apartment', 'Hồ Chí Minh', 'Five Star Westlake 1st-4th Floors Hotel & Serviced Apartment, nằm ở Quận Tây Hồ, được đánh giá Tuyệt hảo, địa chỉ: 164b Đường Hoàng Hoa Thám, Tây Hồ', 2100000.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Quận Tây Hồ', 50, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(238, 'Hanoi Solo Hostel', 'Hồ Chí Minh', 'Hanoi Solo Hostel, nằm ở , được đánh giá Rất tốt, địa chỉ: 35 Ma May Str', 643500.00, 'Không gian trẻ trung, năng động dành cho du khách ba lô với mức giá hợp lý. Phòng dorm sạch sẽ được chia thành các capsule riêng tư với rèm che, ổ khóa cá nhân và đèn đọc sách riêng. Mỗi capsule đều có ổ cắm điện, kệ để đồ và không gian đủ rộng để nghỉ ngơi thoải mái. Khu vực bếp chung được trang bị đầy đủ dụng cụ nấu ăn, tủ lạnh và máy giặt tự động. Phòng sinh hoạt cộng đồng rộng rãi với TV, kệ sách và bàn bi-a, tạo cơ hội kết nối với du khách từ khắp nơi trên thế giới. Dịch vụ đặt tour giá rẻ, thuê xe máy và hướng dẫn du lịch bản địa. Vị trí trung tâm, thuận tiện di chuyển đến các điểm tham quan nổi tiếng.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Shared kitchen\", \"Common area\", \"Laundry\", \"Bicycle rental\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(239, 'Hotel Omina Hanoi Travel', 'Hồ Chí Minh', 'Hotel Omina Hanoi Travel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 2B Phố Hàng Gà', 1320000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(240, 'Somerset Grand Hanoi', 'Hồ Chí Minh', 'Somerset Grand Hanoi, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 49 Hai Ba Trung Street', 3214890.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 50, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(241, 'Carillon Boutique Hotel', 'Hồ Chí Minh', 'Carillon Boutique Hotel, nằm ở , được đánh giá Xuất sắc, địa chỉ: 35 Hàng Đồng', 1359954.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(242, 'Novotel Suites Hanoi', 'Hồ Chí Minh', 'Novotel Suites Hanoi, nằm ở Cau Giay, được đánh giá Tuyệt vời, địa chỉ: 5 Duy Tan Street Cau Giay District', 3132675.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Cau Giay', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(243, 'Nature Hanoi Hotel', 'Hồ Chí Minh', 'Nature Hanoi Hotel, nằm ở Cau Giay, được đánh giá Tuyệt vời, địa chỉ: 60 Ngõ 75 Phố Trần Thái Tông', 718497.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Cau Giay', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(244, 'TrangTrang Boutique Hotel', 'Hồ Chí Minh', 'TrangTrang Boutique Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 104 Ma May Str, Hoan Kiem District', 733480.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(245, 'Hanoi Secret Garden', 'Hồ Chí Minh', 'Hanoi Secret Garden, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 182 Hàng Bông', 1020000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(246, 'Hotel De La Seine', 'Hồ Chí Minh', 'Hotel De La Seine, nằm ở Quận Đống Đa, được đánh giá Tuyệt hảo, địa chỉ: 47 Nguyễn Như Đổ', 1251591.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Đống Đa', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(247, 'Centraltique Downtown - Bespoke Colonial House Near Hoan Kiem Lake', 'Hồ Chí Minh', 'Centraltique Downtown - Bespoke Colonial House Near Hoan Kiem Lake, nằm ở , được đánh giá Rất tốt, địa chỉ: 32 Hàng Bồ', 570000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(248, 'Diamond Westlake Suites', 'Hồ Chí Minh', 'Diamond Westlake Suites, nằm ở Quận Tây Hồ, được đánh giá Rất tốt, địa chỉ: 96 To Ngoc Van Street, Quang An ', 1815840.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Tây Hồ', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(249, 'REY Hotel Hanoi', 'Hồ Chí Minh', 'REY Hotel Hanoi, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 14 Phố Lý Nam Đế', 2550000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(250, 'Bridge Lakeside Room For Rent Hanoi', 'Hồ Chí Minh', 'Bridge Lakeside Room For Rent Hanoi, nằm ở Quận Ba Đình, được đánh giá Dễ chịu, địa chỉ: 24 Nguyễn Chí Thanh', 648000.00, 'Tận hưởng không gian yên bình với view hồ tuyệt đẹp ngay từ phòng nghỉ, nơi bạn có thể ngắm bình minh và hoàng hôn trên mặt hồ. Căn hộ được thiết kế như nhà riêng với đầy đủ tiện nghi: bếp đầy đủ dụng cụ nấu ăn, phòng khách rộng rãi với sofa thoải mái, ban công thoáng mát với bàn ghế thư giãn. Mỗi căn hộ đều có phòng ngủ riêng biệt với giường king size, tủ quần áo rộng rãi và phòng tắm hiện đại. Khu vực hồ bơi riêng được bao quanh bởi vườn cây xanh mát, tạo không gian thư giãn lý tưởng. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/24 và hỗ trợ đặt vé tham quan. Lý tưởng cho kỳ nghỉ gia đình hoặc công tác dài ngày.', 'Quận Ba Đình', 30, '[\"WiFi\", \"Kitchenette\", \"Lake view\", \"Terrace\", \"Family rooms\", \"Laundry\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(251, 'Tunger Premium Hotel & Travel', 'Hồ Chí Minh', 'Tunger Premium Hotel & Travel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 15b Phố Hàng Dầu', 1111000.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(252, 'Hanoi Allure Hotel', 'Hồ Chí Minh', 'Hanoi Allure Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 52 Dao Duy Tu, Hoan Kiem District, Hanoi', 3124786.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(253, 'Margaery Boutique Apartment & Skyon9 Rooftop Bar', 'Hồ Chí Minh', 'Margaery Boutique Apartment & Skyon9 Rooftop Bar, nằm ở Quận Tây Hồ, được đánh giá Rất tốt, địa chỉ: 134 Phố Từ Hoa', 1041984.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Tây Hồ', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(254, 'La Ava’s Home', 'Hồ Chí Minh', 'La Ava’s Home, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: Nhà Chung 15A Nha Chung Alley', 720000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(255, 'Hanoi Hotel', 'Hồ Chí Minh', 'Hanoi Hotel, nằm ở Quận Ba Đình, được đánh giá Rất tốt, địa chỉ: D8 Giang Vo Street', 1861200.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Ba Đình', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(256, 'Lake View Hotel', 'Hồ Chí Minh', 'Lake View Hotel, nằm ở Quận Tây Hồ, được đánh giá Rất tốt, địa chỉ: 65 Phố Trích Sài', 891000.00, 'Tận hưởng không gian yên bình với view hồ tuyệt đẹp ngay từ phòng nghỉ, nơi bạn có thể ngắm bình minh và hoàng hôn trên mặt hồ. Căn hộ được thiết kế như nhà riêng với đầy đủ tiện nghi: bếp đầy đủ dụng cụ nấu ăn, phòng khách rộng rãi với sofa thoải mái, ban công thoáng mát với bàn ghế thư giãn. Mỗi căn hộ đều có phòng ngủ riêng biệt với giường king size, tủ quần áo rộng rãi và phòng tắm hiện đại. Khu vực hồ bơi riêng được bao quanh bởi vườn cây xanh mát, tạo không gian thư giãn lý tưởng. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/24 và hỗ trợ đặt vé tham quan. Lý tưởng cho kỳ nghỉ gia đình hoặc công tác dài ngày.', 'Quận Tây Hồ', 30, '[\"WiFi\", \"Kitchenette\", \"Lake view\", \"Terrace\", \"Family rooms\", \"Laundry\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(257, 'Hanoi Sunshine Hotel', 'Hồ Chí Minh', 'Hanoi Sunshine Hotel, nằm ở , được đánh giá Tốt, địa chỉ: 18 Phố Hàng Hòm', 1494000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(258, 'Hanoi Backpackers Hostel & Rooftop bar', 'Hồ Chí Minh', 'Hanoi Backpackers Hostel & Rooftop bar, nằm ở , được đánh giá Tốt, địa chỉ: 1 Ngõ Hài Tượng Phố Tạ Hiện, Phường Hàng Bạc, ', 1448916.00, 'Không gian trẻ trung, năng động dành cho du khách ba lô với mức giá hợp lý. Phòng dorm sạch sẽ được chia thành các capsule riêng tư với rèm che, ổ khóa cá nhân và đèn đọc sách riêng. Mỗi capsule đều có ổ cắm điện, kệ để đồ và không gian đủ rộng để nghỉ ngơi thoải mái. Khu vực bếp chung được trang bị đầy đủ dụng cụ nấu ăn, tủ lạnh và máy giặt tự động. Phòng sinh hoạt cộng đồng rộng rãi với TV, kệ sách và bàn bi-a, tạo cơ hội kết nối với du khách từ khắp nơi trên thế giới. Dịch vụ đặt tour giá rẻ, thuê xe máy và hướng dẫn du lịch bản địa. Vị trí trung tâm, thuận tiện di chuyển đến các điểm tham quan nổi tiếng.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Shared kitchen\", \"Common area\", \"Laundry\", \"Bicycle rental\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(259, 'Thien Phu Garden Hotel', 'Hồ Chí Minh', 'Thien Phu Garden Hotel, nằm ở Quận Long Biên, được đánh giá Tốt, địa chỉ: No.8 Alley 22 Phu Vien, Bo De, Long Bien Hanoi', 363165.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Long Biên', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(260, 'Eclipse Legend Hotel', 'Hồ Chí Minh', 'Eclipse Legend Hotel, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 38 P. Hàng Vôi 7', 1033200.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(261, 'Hanoi Banana Hostel', 'Hồ Chí Minh', 'Hanoi Banana Hostel, nằm ở , được đánh giá Rất tốt, địa chỉ: 38 Hàng Giầy Hàng Buồm, Hoàn Kiếm', 1152000.00, 'Không gian trẻ trung, năng động dành cho du khách ba lô với mức giá hợp lý. Phòng dorm sạch sẽ được chia thành các capsule riêng tư với rèm che, ổ khóa cá nhân và đèn đọc sách riêng. Mỗi capsule đều có ổ cắm điện, kệ để đồ và không gian đủ rộng để nghỉ ngơi thoải mái. Khu vực bếp chung được trang bị đầy đủ dụng cụ nấu ăn, tủ lạnh và máy giặt tự động. Phòng sinh hoạt cộng đồng rộng rãi với TV, kệ sách và bàn bi-a, tạo cơ hội kết nối với du khách từ khắp nơi trên thế giới. Dịch vụ đặt tour giá rẻ, thuê xe máy và hướng dẫn du lịch bản địa. Vị trí trung tâm, thuận tiện di chuyển đến các điểm tham quan nổi tiếng.', 'Quận Hoàn Kiếm', 0, '[\"WiFi\", \"Shared kitchen\", \"Common area\", \"Laundry\", \"Bicycle rental\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(262, 'The Silk Boutique Hotel & Spa - Old Quarter City Center', 'Hồ Chí Minh', 'The Silk Boutique Hotel & Spa - Old Quarter City Center, nằm ở , được đánh giá Rất tốt, địa chỉ: 15E Phố Hàng Cân', 1256850.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(263, 'MK Premier Boutique Hotel', 'Hồ Chí Minh', 'MK Premier Boutique Hotel, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 72 – 74 Hang Buom Street', 1840625.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved');
INSERT INTO `hotels` (`id`, `name`, `province`, `description`, `price`, `text`, `name_nearby_place`, `hotel_class`, `amenities`, `created_at`, `updated_at`, `user_id`, `status`) VALUES
(264, 'Hoàng Gia Hotel Nhân Hòa', 'Hồ Chí Minh', 'Hoàng Gia Hotel Nhân Hòa, nằm ở Quận Thanh Xuân, được đánh giá Tuyệt vời, địa chỉ: Số 18 Ngõ 116 Phố Nhân Hòa, Phường Nhân Chính, Quận Thanh Xuân, Hà Nội Phường Nhân Chính, Quận Thanh Xuân, Hà Nội', 620500.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Thanh Xuân', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:10', '2025-10-09 20:17:10', NULL, 'approved'),
(265, 'Hanoi Golden Hotel', 'Hồ Chí Minh', 'Hanoi Golden Hotel, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 12 Ngo Gach, Hang Buom, Hoan Kiem', 576810.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 20, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(266, 'Hanoi Moon Cactus', 'Hồ Chí Minh', 'Hanoi Moon Cactus, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: alley 24B, Ly Quoc Su street', 1346400.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(267, 'Hương Linh Apartment', 'Hồ Chí Minh', 'Hương Linh Apartment, nằm ở Quận Thanh Xuân, được đánh giá Tuyệt vời, địa chỉ: 61 Phố Phương Liệt', 550000.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Quận Thanh Xuân', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(268, 'Azen Lakeside Hotel & Travel', 'Hồ Chí Minh', 'Azen Lakeside Hotel & Travel, nằm ở Quận Ba Đình, được đánh giá Xuất sắc, địa chỉ: 37 Phó Đức Chính', 809676.00, 'Tận hưởng không gian yên bình với view hồ tuyệt đẹp ngay từ phòng nghỉ, nơi bạn có thể ngắm bình minh và hoàng hôn trên mặt hồ. Căn hộ được thiết kế như nhà riêng với đầy đủ tiện nghi: bếp đầy đủ dụng cụ nấu ăn, phòng khách rộng rãi với sofa thoải mái, ban công thoáng mát với bàn ghế thư giãn. Mỗi căn hộ đều có phòng ngủ riêng biệt với giường king size, tủ quần áo rộng rãi và phòng tắm hiện đại. Khu vực hồ bơi riêng được bao quanh bởi vườn cây xanh mát, tạo không gian thư giãn lý tưởng. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/24 và hỗ trợ đặt vé tham quan. Lý tưởng cho kỳ nghỉ gia đình hoặc công tác dài ngày.', 'Quận Ba Đình', 40, '[\"WiFi\", \"Kitchenette\", \"Lake view\", \"Terrace\", \"Family rooms\", \"Laundry\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(269, 'Era Apartment - Chùa Láng', 'Hồ Chí Minh', 'Era Apartment - Chùa Láng, nằm ở Quận Đống Đa, được đánh giá Rất tốt, địa chỉ: 3 ngách 91 Ngõ 850 Đường Láng', 382290.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Quận Đống Đa', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(270, 'Era Apartment Khuc Thua Du', 'Hồ Chí Minh', 'Era Apartment Khuc Thua Du, nằm ở Cau Giay, được đánh giá Rất tốt, địa chỉ: Ngõ 59 Phố Khúc Thừa Dụ Số 11A, Ngách 1', 371013.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Cau Giay', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(271, 'VNAHOMES APARTHOTEL', 'Hồ Chí Minh', 'VNAHOMES APARTHOTEL, nằm ở Quận Tây Hồ, được đánh giá Tuyệt vời, địa chỉ: 30 Phố Võng Thị Phường Bưởi Quận Tây Hồ', 956387.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Tây Hồ', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(272, 'Grand Mercure Hanoi', 'Hồ Chí Minh', 'Grand Mercure Hanoi, nằm ở Quận Đống Đa, được đánh giá Tuyệt hảo, địa chỉ: 9 Cat Linh Quoc Tu Giam Dong Da', 3912300.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Đống Đa', 50, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(273, 'Crescendo Boutique Studio', 'Hồ Chí Minh', 'Crescendo Boutique Studio, nằm ở Quận Tây Hồ, được đánh giá Rất tốt, địa chỉ: 29 Ngõ 45 Đường Tô Ngọc Vân', 810000.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Tây Hồ', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(274, 'Amazing stay-apartment homestay, quiet and cozy place LTT Thanh Xuân', 'Hồ Chí Minh', 'Amazing stay-apartment homestay, quiet and cozy place LTT Thanh Xuân, nằm ở Quận Thanh Xuân, được đánh giá Xuất sắc, địa chỉ: số 16 ngõ 106 Lê Trọng Tấn Thanh Xuân', 441000.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Quận Thanh Xuân', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(275, 'Sakamoto 2 Apartments Kim Ma by XÔI Residences', 'Hồ Chí Minh', 'Sakamoto 2 Apartments Kim Ma by XÔI Residences, nằm ở Quận Ba Đình, được đánh giá Tuyệt hảo, địa chỉ: Ng. 535 P. Kim Mã', 1192950.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Quận Ba Đình', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(276, 'Maison d\'Hanoi Hotel', 'Hồ Chí Minh', 'Maison d\'Hanoi Hotel, nằm ở , được đánh giá Tốt, địa chỉ: 46 Nguyen Van To, Hoan Kiem', 497250.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 20, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(277, 'The Bloom Classic - Hotel and Bistro', 'Hồ Chí Minh', 'The Bloom Classic - Hotel and Bistro, nằm ở Cau Giay, được đánh giá Tuyệt vời, địa chỉ: No 58, Truong Cong Giai Street, Cau Giay District', 11955131.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Cau Giay', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(278, 'Madelise Hanoi View Hotel', 'Hồ Chí Minh', 'Madelise Hanoi View Hotel, nằm ở Quận Đống Đa, được đánh giá Xuất sắc, địa chỉ: 48 B Ngõ Ngô Sỹ Liên Thanh Xuân', 1012500.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Đống Đa', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(279, 'Sofitel Legend Metropole Hanoi', 'Hồ Chí Minh', 'Sofitel Legend Metropole Hanoi, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 15 Ngo Quyen Street', 10169148.40, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(280, 'Mai Charming Hotel and Spa', 'Hồ Chí Minh', 'Mai Charming Hotel and Spa, nằm ở , được đánh giá Rất tốt, địa chỉ: 29 Hang Bong', 3150000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(281, 'Coco Hotel Cau Giay', 'Hồ Chí Minh', 'Coco Hotel Cau Giay, nằm ở Cau Giay, được đánh giá Rất tốt, địa chỉ: 5 Tran Duy Hung street,Trung Hoa, Cau Giay District', 540000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Cau Giay', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(282, 'The Literature\'N Central Hotel and Travel Ha Noi 177', 'Huế', 'The Literature\'N Central Hotel and Travel Ha Noi 177, nằm ở Quận Đống Đa, được đánh giá Tuyệt vời, địa chỉ: 177 Phố Tôn Đức Thắng', 641725.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Đống Đa', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(283, 'The Hanoi Club Hotel & Residences', 'Huế', 'The Hanoi Club Hotel & Residences, nằm ở Quận Tây Hồ, được đánh giá Rất tốt, địa chỉ: 76 Yen Phu Street', 3075000.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Quận Tây Hồ', 40, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(284, 'LUMI Hotel & Apartment', 'Huế', 'LUMI Hotel & Apartment, nằm ở Quận Ba Đình, được đánh giá Tuyệt vời, địa chỉ: Số 09 ngõ 60 Linh Lang, tổ 18 Cống Vị Ba Đình', 731025.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Quận Ba Đình', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(285, '22Land Hotel & Residence', 'Huế', '22Land Hotel & Residence, nằm ở Cau Giay, được đánh giá Tuyệt vời, địa chỉ: 50 Phố Trương Công Giai Cầu Giấy', 1215000.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Cau Giay', 40, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(286, 'Sakura Hotel 3', 'Huế', 'Sakura Hotel 3, nằm ở Quận Ba Đình, được đánh giá Tốt, địa chỉ: 609 Kim Ma, Ba Dinh', 1485000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Ba Đình', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(287, 'InterContinental Hanoi Westlake by IHG', 'Huế', 'InterContinental Hanoi Westlake by IHG, nằm ở Quận Tây Hồ, được đánh giá Tuyệt vời, địa chỉ: 5 Tu Hoa Street, Tay Ho District', 6045509.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Tây Hồ', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(288, 'Hanoi Shouten - Staycation', 'Huế', 'Hanoi Shouten - Staycation, nằm ở Quận Ba Đình, được đánh giá Xuất sắc, địa chỉ: 160 Phố Trấn Vũ', 1343722.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Ba Đình', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(289, 'Hanoi de Garden Boutique Hotel & Spa', 'Huế', 'Hanoi de Garden Boutique Hotel & Spa, nằm ở , được đánh giá Xuất sắc, địa chỉ: 8 Phố Chả Cá', 1986600.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(290, 'Grand Vista Hanoi', 'Huế', 'Grand Vista Hanoi, nằm ở Quận Ba Đình, được đánh giá Tuyệt vời, địa chỉ: 146 Giảng Võ', 2111592.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Ba Đình', 50, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(291, 'Grand Dragon Hotel Hanoi', 'Huế', 'Grand Dragon Hotel Hanoi, nằm ở Quận Thanh Xuân, được đánh giá Rất tốt, địa chỉ: 21 Le Van Luong Street, Nhan Chinh Ward, Thanh Xuan District, Hanoi City, Vietnam', 907800.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Thanh Xuân', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(292, 'Queen Cafe Hotel & Pub', 'Huế', 'Queen Cafe Hotel & Pub, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 23 Phố Mã Mây, Hàng Buồm, Hoàn Kiễm, Hà Nội Số 23 Mã Mây', 1170000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(293, 'Quiet Hoang Quoc Viet Hotel & apartment', 'Huế', 'Quiet Hoang Quoc Viet Hotel & apartment, nằm ở Cau Giay, được đánh giá Tốt, địa chỉ: 17, alley 123, Hoang Quoc Viet street, Cau Giay', 600000.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Cau Giay', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(294, 'Love St - Hanoi Hotel', 'Huế', 'Love St - Hanoi Hotel, nằm ở Quận Tây Hồ, được đánh giá Tuyệt vời, địa chỉ: 29A , Alley 399, Au Co Streeet', 903000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Tây Hồ', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(295, 'Roygent Parks Hanoi', 'Huế', 'Roygent Parks Hanoi, nằm ở Cau Giay, được đánh giá Tuyệt vời, địa chỉ: 289 Khuat Duy Tien, Dai Mo Ward', 2448000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Cau Giay', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(296, 'Serenity Villa Hotel', 'Huế', 'Serenity Villa Hotel, nằm ở , được đánh giá Rất tốt, địa chỉ: 28 Ngo Huyen Street', 846450.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(297, 'Keypad Hotel - Nhân Hòa', 'Huế', 'Keypad Hotel - Nhân Hòa, nằm ở Quận Thanh Xuân, được đánh giá Tuyệt vời, địa chỉ: Số 80 Ngõ 116 Phố Nhân Hòa', 765000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Thanh Xuân', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(298, 'The Pilgrim Hotel', 'Huế', 'The Pilgrim Hotel, nằm ở , được đánh giá Rất tốt, địa chỉ: 52 Ấu Triệu', 870000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(299, 'La Santé Hotel & Spa', 'Huế', 'La Santé Hotel & Spa, nằm ở Quận Ba Đình, được đánh giá Tuyệt hảo, địa chỉ: 42 Chau Long street, Ba Dinh district', 1381050.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Ba Đình', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(300, 'Evelyn Indochine Chic in Central Hanoi', 'Huế', 'Evelyn Indochine Chic in Central Hanoi, nằm ở , được đánh giá Xuất sắc, địa chỉ: 16 Ngõ 26 Phố Hàng Bài', 948525.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(301, 'Mely Hotel Hà Nội', 'Huế', 'Mely Hotel Hà Nội, nằm ở Quận Thanh Xuân, được đánh giá Tốt, địa chỉ: 21-23 Nhan Hoa - Thanh Xuan', 367200.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Thanh Xuân', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(302, 'Au Coeur d\'Hanoi Boutique Hotel', 'Huế', 'Au Coeur d\'Hanoi Boutique Hotel, nằm ở , được đánh giá Rất tốt, địa chỉ: 62 Hang Be', 1239300.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(303, 'Super Candle Hotel', 'Huế', 'Super Candle Hotel, nằm ở Quận Ba Đình, được đánh giá Rất tốt, địa chỉ: 287 Doi Can', 1575000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Ba Đình', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(304, 'Bao Son International Hotel', 'Huế', 'Bao Son International Hotel, nằm ở Quận Đống Đa, được đánh giá Tuyệt vời, địa chỉ: 50 Nguyen Chi Thanh Street', 2287937.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Đống Đa', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(305, 'Era Cozy Apartment', 'Huế', 'Era Cozy Apartment, nằm ở Cau Giay, được đánh giá Tốt, địa chỉ: Ngõ 77 Phố Yên Hòa Số 2', 359736.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Cau Giay', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:11', '2025-10-09 20:17:11', NULL, 'approved'),
(306, 'Hanoi La Storia Hotel', 'Huế', 'Hanoi La Storia Hotel, nằm ở , được đánh giá Rất tốt, địa chỉ: 45 Hang Dong street, Hoan Kiem district', 1077797.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(307, 'Hanoi Amber Hotel', 'Huế', 'Hanoi Amber Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 8/50 Dao Duy Tu Street', 984546.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(308, 'The Urban Tranquil', 'Huế', 'The Urban Tranquil, nằm ở Quận Tây Hồ, được đánh giá Xuất sắc, địa chỉ: 39 Phố Trích Sài', 824850.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Tây Hồ', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(309, 'La Selva Premium Hotel', 'Huế', 'La Selva Premium Hotel, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: 1A Phố Cầu Gỗ', 1701000.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(310, 'Spring Home Hà Nội', 'Huế', 'Spring Home Hà Nội, nằm ở , được đánh giá Rất tốt, địa chỉ: 77 Phố Hàng Chiếu', 612000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(311, 'Jacayl Hotel - Cầu Giấy', 'Huế', 'Jacayl Hotel - Cầu Giấy, nằm ở Cau Giay, được đánh giá Tốt, địa chỉ: 31 Phố Trương Công Giai', 975116.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Cau Giay', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(312, 'Era Apartment Xuân Thuỷ', 'Huế', 'Era Apartment Xuân Thuỷ, nằm ở Cau Giay, được đánh giá Rất tốt, địa chỉ: Ngõ 181 Đường Xuân Thủy Số 19-21', 382290.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Cau Giay', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(313, 'Hanoi Ben\'s Apartment and Hotel', 'Huế', 'Hanoi Ben\'s Apartment and Hotel, nằm ở Quận Hai Bà Trưng, được đánh giá Tuyệt vời, địa chỉ: số 08 ngõ 76 trần xuân soạn', 714000.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Quận Hai Bà Trưng', 30, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(314, 'COSY HOUSE - CENTER\'S TAY HO - CLOSE THE LAKE', 'Huế', 'COSY HOUSE - CENTER\'S TAY HO - CLOSE THE LAKE, nằm ở Quận Tây Hồ, được đánh giá Tuyệt vời, địa chỉ: Ngõ 6 Đường Tây Hồ', 451944.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Tây Hồ', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(315, 'Au Coeur d\'Hanoi Apartment', 'Huế', 'Au Coeur d\'Hanoi Apartment, nằm ở , được đánh giá Rất tốt, địa chỉ: 82H, Tho Nhuom, Hoan Kiem', 1270500.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Quận Hoàn Kiếm', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(316, 'Old Town Palace Guest House', 'Huế', 'Old Town Palace Guest House, nằm ở , được đánh giá Tốt, địa chỉ: 30 Lane Tam Thuong, Hang Bong Ward, Hoan Kiem District', 690000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved');
INSERT INTO `hotels` (`id`, `name`, `province`, `description`, `price`, `text`, `name_nearby_place`, `hotel_class`, `amenities`, `created_at`, `updated_at`, `user_id`, `status`) VALUES
(317, 'Adonis Hotel', 'Huế', 'Adonis Hotel, nằm ở Quận Hai Bà Trưng, được đánh giá Tuyệt vời, địa chỉ: 55 Quang Trung Street, Hai Ba Trung District, Hanoi, Vietnam', 1137150.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hai Bà Trưng', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(318, 'Hotel de l\'Opera Hanoi - MGallery', 'Huế', 'Hotel de l\'Opera Hanoi - MGallery, nằm ở , được đánh giá Rất tốt, địa chỉ: 29 Trang Tien Street', 5145865.20, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(319, 'ELB Stay I Self Check In', 'Huế', 'ELB Stay I Self Check In, nằm ở , được đánh giá Tuyệt hảo, địa chỉ: ELB Stay 11 ngõ 463 đường Hồng Hà ,Phúc Tân, Hoàn Kiếm, Hà Nội', 529000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(320, 'Hanoi Paon Hotel & Spa', 'Huế', 'Hanoi Paon Hotel & Spa, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 27 Hang Thung Str, Hoan Kiem District', 2894080.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(321, 'The Urban Quarter Hanoi', 'Huế', 'The Urban Quarter Hanoi, nằm ở Quận Đống Đa, được đánh giá Tuyệt hảo, địa chỉ: 24 Đường Lê Duẩn, Văn Miếu', 712800.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Đống Đa', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(322, 'Sao Mai Boutique Hotel', 'Huế', 'Sao Mai Boutique Hotel, nằm ở Quận Đống Đa, được đánh giá Tuyệt hảo, địa chỉ: 23 Ngõ Thông Phong', 1713600.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Quận Đống Đa', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(323, 'Aloha Home & Apartment Ba Dinh', 'Huế', 'Aloha Home & Apartment Ba Dinh, nằm ở Quận Ba Đình, được đánh giá Tuyệt vời, địa chỉ: 1 Ngõ 266 Đội Cấn', 406125.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Quận Ba Đình', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(324, 'Hai Duong Apartments 70 Van Kiep', 'Huế', 'Hai Duong Apartments 70 Van Kiep, nằm ở Quận Hai Bà Trưng, được đánh giá Tốt, địa chỉ: 70 Vạn Kiếp', 396900.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Quận Hai Bà Trưng', 20, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(325, 'Holiday Suites Hotel & Spa', 'Huế', 'Holiday Suites Hotel & Spa, nằm ở , được đánh giá Rất tốt, địa chỉ: 5 Nguyen Sieu', 719100.00, 'Tọa lạc tại vị trí đắc địa với tầm nhìn tuyệt đẹp ra thành phố, khách sạn cung cấp các suite rộng rãi được thiết kế sang trọng và dịch vụ spa đẳng cấp quốc tế. Mỗi phòng suite được trang bị phòng tắm riêng với bồn tắm massage, phòng khách riêng biệt và ban công rộng với view toàn cảnh. Hồ bơi vô cực ngoài trời được thiết kế tinh xảo, phòng tập gym hiện đại với đầy đủ thiết bị và nhà hàng ẩm thực đa dạng mang đến trải nghiệm nghỉ dưỡng trọn vẹn. Đội ngũ nhân viên chuyên nghiệp luôn sẵn sàng phục vụ 24/7, cung cấp dịch vụ đưa đón tận nơi và hỗ trợ đặt tour du lịch. Không gian kiến trúc kết hợp hài hòa giữa nét hiện đại và truyền thống, tạo nên một điểm đến lý tưởng cho cả du lịch và công tác.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Spa\", \"Swimming pool\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Kitchenette\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(326, 'Spoon Hotel', 'Huế', 'Spoon Hotel, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 19 Nguyen Van To, Hoan Kiem', 1134000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(327, 'Queen Cafe Hotel', 'Huế', 'Queen Cafe Hotel, nằm ở , được đánh giá Xuất sắc, địa chỉ: 41 Phố Lý Nam Đế', 1152000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(328, 'My House Hotel Hanoi', 'Huế', 'My House Hotel Hanoi, nằm ở Quận Hai Bà Trưng, được đánh giá Rất tốt, địa chỉ: 350 Trần Khát Chân', 489600.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hai Bà Trưng', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(329, 'Louisland Hanoi Hotel', 'Huế', 'Louisland Hanoi Hotel, nằm ở Cau Giay, được đánh giá Rất tốt, địa chỉ: 23 Nguyễn Ngọc Vũ Trung Hòa, Cầu Giấy, Hà Nội', 619920.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Cau Giay', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(330, 'Hanoi Grand Hotel and Travel', 'Huế', 'Hanoi Grand Hotel and Travel, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 11 Hàng Mắm', 1260000.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(331, 'Era Apartment Tran Thai Tong', 'Huế', 'Era Apartment Tran Thai Tong, nằm ở Cau Giay, được đánh giá Rất tốt, địa chỉ: 1 Ngõ 35 Trần Thái Tông Số 17C', 382290.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Cau Giay', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(332, 'Hanoi Street Hotel', 'Huế', 'Hanoi Street Hotel, nằm ở , được đánh giá Rất tốt, địa chỉ: 1 Cam Chi, Hang Bong Street', 891000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 10, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(333, 'Sophie hotel', 'Hoàn Kiếm', 'Sophie hotel, nằm ở , được đánh giá Tốt, địa chỉ: 2b Ngõ Thọ Xương', 550000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 10, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(334, 'Apricot Hotel', 'Hà Nội', 'Apricot Hotel, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 136 Hang Trong', 4575312.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(335, 'Nam Cường X Hotel', 'Cầu Giấy', 'Nam Cường X Hotel, nằm ở Cau Giay, được đánh giá Rất tốt, địa chỉ: 57 Phố Trần Quốc Vượng, Dịch Vọng Hậu', 405000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Cau Giay', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(336, 'Granda Legend Apartment', 'Hà Nội', 'Granda Legend Apartment, nằm ở Cau Giay, được đánh giá Rất tốt, địa chỉ: No. 5, Lane 100/7, Hoang Quoc Viet Street, Cau Giay', 545280.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Cau Giay', 0, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(337, 'Prince II Hotel', 'Hà Nội', 'Prince II Hotel, nằm ở , được đánh giá Rất tốt, địa chỉ: 42B Hang Giay Street', 662160.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 20, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(338, 'The Cosy Inn Hanoi', 'Hà Nội', 'The Cosy Inn Hanoi, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 22 Phố Lương Ngọc Quyến 22/22', 1084011.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(339, 'Clover Hanoi Hotel - City Center', 'Hà Nội', 'Clover Hanoi Hotel - City Center, nằm ở Quận Đống Đa, được đánh giá Tuyệt hảo, địa chỉ: 50 Phố Tôn Đức Thắng', 780000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Đống Đa', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(340, 'Luxe Paradise Premium Hotel Pham Hong Thai', 'Ba Đình', 'Luxe Paradise Premium Hotel Pham Hong Thai, nằm ở Quận Ba Đình, được đánh giá Tuyệt vời, địa chỉ: 75 Phố Phạm Hồng Thái', 1552000.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Quận Ba Đình', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(341, 'Dinh Elegant Hanoi Hotel', 'Hà Nội', 'Dinh Elegant Hanoi Hotel, nằm ở Cau Giay, được đánh giá Rất tốt, địa chỉ: 4, Group 15D, Trung Yen, Trung Hoa, Cau Giay', 886498.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Cau Giay', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:12', '2025-10-09 20:17:12', NULL, 'approved'),
(342, 'Moon Hotel 26 Do Quang', 'Cầu Giấy', 'Moon Hotel 26 Do Quang, nằm ở Cau Giay, được đánh giá Tuyệt vời, địa chỉ: 9 Ngách 26/1 Phố Đỗ Quang', 623700.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Cau Giay', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(343, 'Sumitomo10 Apartment - Lane 12 Dao Tan street', 'Ba Đình', 'Sumitomo10 Apartment - Lane 12 Dao Tan street, nằm ở Quận Ba Đình, được đánh giá Rất tốt, địa chỉ: 66 Ngõ 12 Phố Đào Tấn', 945000.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Quận Ba Đình', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(344, 'Ping Diamond Hotel Hanoi', 'Cầu Giấy', 'Ping Diamond Hotel Hanoi, nằm ở Cau Giay, được đánh giá Tuyệt vời, địa chỉ: 76 Trần Thái Tông', 1032240.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Cau Giay', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(345, 'Bespoke Trendy Hotel Hanoi', 'Hà Nội', 'Bespoke Trendy Hotel Hanoi, nằm ở , được đánh giá Xuất sắc, địa chỉ: 12 Nguyen Quang Bich, Hoan Kiem', 3420000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(346, 'Ancient Lane Hotel', 'Hà Nội', 'Ancient Lane Hotel, nằm ở , được đánh giá Rất tốt, địa chỉ: 2 Ngõ Tạm Thương Hang Gai, Hoan Kiem District', 450000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 20, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(347, 'Madelise Amica Hotel and Travel', 'Hà Nội', 'Madelise Amica Hotel and Travel, nằm ở , được đánh giá Tuyệt vời, địa chỉ: 33 A Hàng Điếu', 1336500.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hoàn Kiếm', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(348, 'THE MIRA HOMESTAY - Vinhomes Times City', 'Hai Bà Trưng', 'THE MIRA HOMESTAY - Vinhomes Times City, nằm ở Quận Hai Bà Trưng, được đánh giá , địa chỉ: 458 P. Minh Khai', 1080000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hai Bà Trưng', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(349, 'AJISAI Hotel', 'Ba Đình', 'AJISAI Hotel, nằm ở Quận Ba Đình, được đánh giá Tuyệt hảo, địa chỉ: 18 Ngõ 20A Núi Trúc 18 phòng, 10 tầng', 1134000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Ba Đình', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(350, 'Mercy Hotel', 'Hà Nội', 'Mercy Hotel, nằm ở Quận Hai Bà Trưng, được đánh giá Tốt, địa chỉ: 310 Lạc Trung, Vĩnh Tuy, Hai Bà Trưng', 1300000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Quận Hai Bà Trưng', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(351, 'Hanoi Memory Premier Hotel & Spa', 'Hoàn Kiếm', 'Hanoi Memory Premier Hotel & Spa, nằm ở , được đánh giá Tàm tạm, địa chỉ: 52 Phố Mã Mây 52 Mã Mây, , Hà Nội, Phố Cổ, Hà Nội, Việt Nam', 1176000.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Quận Hoàn Kiếm', 30, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(352, 'Lakeview Residence Hotel', 'Tây Hồ', 'Lakeview Residence Hotel, nằm ở Quận Tây Hồ, được đánh giá Rất tốt, địa chỉ: 51 Phố Trích Sài', 789012.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Quận Tây Hồ', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(353, 'Branda Apartment & Hotel', 'Hà Nội', 'Branda Apartment & Hotel, nằm ở Quận Long Biên, được đánh giá Tuyệt vời, địa chỉ: 141 Phố Hồng Tiến', 4114800.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Quận Long Biên', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(354, 'Santori Hotel And Spa', 'Đà Nẵng', 'Santori Hotel And Spa, nằm ở Sông Hàn, được đánh giá Rất tốt, địa chỉ: Lô 119-120 khu Euro Village, Đ. Trần Hưng Đạo, An Hải Tây, Sơn Trà, Đà Nẵng', 599352.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Sông Hàn', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(355, 'Cozy Danang Boutique Hotel', 'Hai Chau', 'Cozy Danang Boutique Hotel, nằm ở Trung tâm Thành phố Đà Nẵng, được đánh giá Tuyệt hảo, địa chỉ: 37 Co Giang', 1600000.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Trung tâm Thành phố Đà Nẵng', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(356, 'Star City Riverside Hotel By Haviland', 'Danang', 'Star City Riverside Hotel By Haviland, nằm ở Sông Hàn, được đánh giá Tuyệt vời, địa chỉ: 147 Trần Hưng Đạo, Nại Hiên Đông, Sơn Trà, Đà Nẵng', 332500.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Sông Hàn', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(357, 'Seahorse Signature Danang Hotel by Haviland', 'Đà Nẵng', 'Seahorse Signature Danang Hotel by Haviland, nằm ở Trung tâm Thành phố Đà Nẵng, được đánh giá Tuyệt hảo, địa chỉ: 05 Huỳnh Thúc Kháng', 1077300.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Trung tâm Thành phố Đà Nẵng', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(358, 'Novotel Danang Premier Han River', 'Đà Nẵng', 'Novotel Danang Premier Han River, nằm ở Sông Hàn, được đánh giá Tuyệt vời, địa chỉ: 36 Bach Dang', 2226609.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Sông Hàn', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(359, 'Elite Luxury Hotel', 'Đà Nẵng', 'Elite Luxury Hotel, nằm ở Trung tâm Thành phố Đà Nẵng, được đánh giá Tuyệt vời, địa chỉ: 92 Phan Chau Trinh', 745200.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Trung tâm Thành phố Đà Nẵng', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(360, 'Grand Citiview Da Nang Hotel', 'Đà Nẵng', 'Grand Citiview Da Nang Hotel, nằm ở Sông Hàn, được đánh giá Rất tốt, địa chỉ: 532, Street 2/9, Hoa Cuong Nam Ward,Hai Chau District', 928800.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Sông Hàn', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(361, 'Crowne Plaza Danang City Centre by IHG', 'Đà Nẵng', 'Crowne Plaza Danang City Centre by IHG, nằm ở Sông Hàn, được đánh giá Tuyệt hảo, địa chỉ: 17 Quang Trung, Hai Chau 1 Ward, Hai Chau District', 2061947.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Sông Hàn', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(362, 'Happy Day Riverside Hotel & Spa Danang', 'Đà Nẵng', 'Happy Day Riverside Hotel & Spa Danang, nằm ở Sông Hàn, được đánh giá Tuyệt vời, địa chỉ: 160 Bach Dang', 466830.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Sông Hàn', 30, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(363, 'Bona Hostel', 'Sơn Trà', 'Bona Hostel, nằm ở Sông Hàn, được đánh giá Tốt, địa chỉ: 100b Cao Bá Quát', 302940.00, 'Không gian trẻ trung, năng động dành cho du khách ba lô với mức giá hợp lý. Phòng dorm sạch sẽ được chia thành các capsule riêng tư với rèm che, ổ khóa cá nhân và đèn đọc sách riêng. Mỗi capsule đều có ổ cắm điện, kệ để đồ và không gian đủ rộng để nghỉ ngơi thoải mái. Khu vực bếp chung được trang bị đầy đủ dụng cụ nấu ăn, tủ lạnh và máy giặt tự động. Phòng sinh hoạt cộng đồng rộng rãi với TV, kệ sách và bàn bi-a, tạo cơ hội kết nối với du khách từ khắp nơi trên thế giới. Dịch vụ đặt tour giá rẻ, thuê xe máy và hướng dẫn du lịch bản địa. Vị trí trung tâm, thuận tiện di chuyển đến các điểm tham quan nổi tiếng.', 'Sông Hàn', 0, '[\"WiFi\", \"Shared kitchen\", \"Common area\", \"Laundry\", \"Bicycle rental\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(364, 'Doha Central Bliss Danang Hotel by Haviland', 'Đà Nẵng', 'Doha Central Bliss Danang Hotel by Haviland, nằm ở Trung tâm Thành phố Đà Nẵng, được đánh giá Tuyệt hảo, địa chỉ: 193 Nguyen Van Linh', 399000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Trung tâm Thành phố Đà Nẵng', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(365, 'Sun River Hotel', 'Đà Nẵng', 'Sun River Hotel, nằm ở Sông Hàn, được đánh giá Rất tốt, địa chỉ: 134-136 Bach Dang, Hai Chau', 735300.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Sông Hàn', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(366, 'Oday Stay Boutique Hotel Da Nang - 2 Minutes to Dragon Bridge', 'Sơn Trà', 'Oday Stay Boutique Hotel Da Nang - 2 Minutes to Dragon Bridge, nằm ở Sông Hàn, được đánh giá Tuyệt hảo, địa chỉ: 477 Tran Hung Dao', 900200.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Sông Hàn', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(367, 'Dong Duong Hotel & Suites - City Central - Afternoon Tea Inclusive', 'Hải Châu', 'Dong Duong Hotel & Suites - City Central - Afternoon Tea Inclusive, nằm ở Trung tâm Thành phố Đà Nẵng, được đánh giá Tuyệt vời, địa chỉ: 62 Thai Phien', 850000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Trung tâm Thành phố Đà Nẵng', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(368, 'Quoc Cuong Hotel & Apartment Danang by Haviland', 'Đà Nẵng', 'Quoc Cuong Hotel & Apartment Danang by Haviland, nằm ở Trung tâm Thành phố Đà Nẵng, được đánh giá Rất tốt, địa chỉ: 322 Hoàng Diệu, Bình Hiên, Hải Châu', 430920.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Trung tâm Thành phố Đà Nẵng', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved'),
(369, 'POSIKI Hotel & Dorm - Danang Dragon Bridge', 'Đà Nẵng', 'POSIKI Hotel & Dorm - Danang Dragon Bridge, nằm ở Sông Hàn, được đánh giá Tốt, địa chỉ: 215 Trần Phú, phường Phước Ninh, quận Hải Châu', 199784.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Sông Hàn', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:13', '2025-10-09 20:17:13', NULL, 'approved');
INSERT INTO `hotels` (`id`, `name`, `province`, `description`, `price`, `text`, `name_nearby_place`, `hotel_class`, `amenities`, `created_at`, `updated_at`, `user_id`, `status`) VALUES
(370, 'Grand Mercure Danang', 'Đà Nẵng', 'Grand Mercure Danang, nằm ở Sông Hàn, được đánh giá Tuyệt vời, địa chỉ: Lot A1, Green Island, Hoa Cuong Bac Ward', 1877904.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Sông Hàn', 50, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(371, 'Sujet Residence Da Nang by Haviland', 'Đà Nẵng', 'Sujet Residence Da Nang by Haviland, nằm ở Sông Hàn, được đánh giá Tuyệt hảo, địa chỉ: 186 Bạch Đằng,Phước Ninh, Hải Châu', 710334.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Sông Hàn', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(372, 'ATP Galaxy Hotel & Apartment Danang', 'Đà Nẵng', 'ATP Galaxy Hotel & Apartment Danang, nằm ở Trung tâm Thành phố Đà Nẵng, được đánh giá Rất tốt, địa chỉ: 89 Trần Phước Thành, phường Khuê Trung, quận Cẩm Lệ', 810000.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Trung tâm Thành phố Đà Nẵng', 40, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(373, 'Mitisa Hotel Da Nang - Near Dragon Bridge', 'Đà Nẵng', 'Mitisa Hotel Da Nang - Near Dragon Bridge, nằm ở Trung tâm Thành phố Đà Nẵng, được đánh giá Rất tốt, địa chỉ: 67-69 Nguyen Van Linh, Hai Chau District ', 962280.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Trung tâm Thành phố Đà Nẵng', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(374, 'Meliá Vinpearl Danang Riverfront', 'Đà Nẵng', 'Meliá Vinpearl Danang Riverfront, nằm ở Sông Hàn, được đánh giá Tuyệt vời, địa chỉ: 341 Tran Hung Dao Street, An Hai Bac Ward, Son Tra Ward', 2448682.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Sông Hàn', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(375, 'LaDa\'s House Da Nang', 'Hải Châu', 'LaDa\'s House Da Nang, nằm ở Trung tâm Thành phố Đà Nẵng, được đánh giá Tuyệt hảo, địa chỉ: 58 Hoàng Văn Thụ', 798000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Trung tâm Thành phố Đà Nẵng', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(376, 'Central Hotel & Spa Danang', 'Đà Nẵng', 'Central Hotel & Spa Danang, nằm ở Trung tâm Thành phố Đà Nẵng, được đánh giá Rất tốt, địa chỉ: 21 - 23 Hoang Dieu, Hai Chau', 571536.00, 'Khách sạn kết hợp trung tâm spa chuyên nghiệp, mang đến liệu pháp thư giãn toàn diện cho cả tinh thần và thể chất. Phòng nghỉ tiện nghi với view đẹp, được trang bị giường êm ái, minibar đầy đủ và không gian làm việc riêng. Trung tâm spa rộng 500m2 với phòng xông hơi, bể sục và các phòng trị liệu riêng biệt. Các dịch vụ massage đa dạng từ truyền thống đến hiện đại, chăm sóc da mặt và body treatment được thực hiện bởi đội ngũ kỹ thuật viên giàu kinh nghiệm. Nhà hàng phục vụ ẩm thực lành mạnh với thực đơn eat clean, smoothie bar và các món ăn kiêng đặc biệt. Yoga studio với các lớp học hàng ngày và huấn luyện viên cá nhân.', 'Trung tâm Thành phố Đà Nẵng', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Fitness center\", \"Swimming pool\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(377, 'Centre Hotel', 'Danang', 'Centre Hotel, nằm ở Sông Hàn, được đánh giá Tốt, địa chỉ: 18-20 Pham Phu Thu, Hai Chau', 1337050.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Sông Hàn', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(378, 'Wink Icon Hotel Danang Riverside - Luxury Suites - 24hrs Stay & Rooftop Pool Bar', 'Đà Nẵng', 'Wink Icon Hotel Danang Riverside - Luxury Suites - 24hrs Stay & Rooftop Pool Bar, nằm ở Sông Hàn, được đánh giá Tuyệt vời, địa chỉ: 351 Tran Hung Dao, An Hai Tay, Son Tra', 1409400.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Sông Hàn', 50, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(379, 'Tan Phuong Nam Hotel & Apartment', 'Đà Nẵng', 'Tan Phuong Nam Hotel & Apartment, nằm ở Sông Hàn, được đánh giá Tuyệt vời, địa chỉ: 494 Duong 2 Thang 9, Hoa Cuong Nam, Hai Chau', 749312.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Sông Hàn', 30, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(380, 'Merry Hotel', 'Sơn Trà', 'Merry Hotel, nằm ở Sông Hàn, được đánh giá Rất tốt, địa chỉ: 447 Trần Hưng Đạo', 675800.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Sông Hàn', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(381, 'IBIZA Riverfront Da Nang Hotel', 'Đà Nẵng', 'IBIZA Riverfront Da Nang Hotel, nằm ở Sông Hàn, được đánh giá Rất tốt, địa chỉ: 205 Tran Hung Dao, Son Tra', 531279.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Sông Hàn', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(382, 'MK Riverside Apartment by Haviland', 'Ngũ Hành Sơn', 'MK Riverside Apartment by Haviland, nằm ở Sông Hàn, được đánh giá Tuyệt hảo, địa chỉ:  35 - 37 Chuong Duong, My An', 592515.00, 'Căn hộ dịch vụ cao cấp với đầy đủ tiện nghi như một ngôi nhà thực thụ, lý tưởng cho những chuyến ở dài ngày. Thiết kế hiện đại với không gian mở, phòng khách rộng rãi với sofa lớn và TV màn hình rộng. Bếp fully-equipped với tủ lạnh side-by-side, lò vi sóng, máy rửa bát và đầy đủ dụng cụ nấu nướng. Phòng ngủ thoải mái với tủ quần áo walk-in và phòng tắm riêng. Mỗi căn hộ đều có ban công riêng với view thành phố, bàn làm việc ergonomic và hệ thống internet tốc độ cao. Dịch vụ dọn phòng hàng ngày, bảo vệ 24/7, hồ bơi trên tầng thượng và phòng gym hiện đại. Khu vực giặt ủi tự phục vụ và dịch vụ đưa đón sân bay.', 'Sông Hàn', 0, '[\"WiFi\", \"Kitchenette\", \"Family rooms\", \"Laundry\", \"Terrace\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(383, 'Wink Hotel Danang Centre - 24hrs Lifestyle Stay', 'Hải Châu', 'Wink Hotel Danang Centre - 24hrs Lifestyle Stay, nằm ở Sông Hàn, được đánh giá Tuyệt vời, địa chỉ: 178 Tran Phu', 1260000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Sông Hàn', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(384, 'ORANGE Hotel - Danang City CENTER, near Dragon Bridge', 'Đà Nẵng', 'ORANGE Hotel - Danang City CENTER, near Dragon Bridge, nằm ở Trung tâm Thành phố Đà Nẵng, được đánh giá Rất tốt, địa chỉ: 29 Hoang Dieu', 333000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Trung tâm Thành phố Đà Nẵng', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(385, 'Avora Hotel', 'Danang', 'Avora Hotel, nằm ở Sông Hàn, được đánh giá Tuyệt vời, địa chỉ: 170 Bach Dang, Hai Chau, Da Nang', 950000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Sông Hàn', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(386, 'Hilton Da Nang', 'Đà Nẵng', 'Hilton Da Nang, nằm ở Sông Hàn, được đánh giá Rất tốt, địa chỉ: 50 Bach Dang St, Hai Chau District', 2313360.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Sông Hàn', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(387, 'Da Nang - Mikazuki Japanese Resorts & Spa', 'Đà Nẵng', 'Da Nang - Mikazuki Japanese Resorts & Spa, nằm ở Vịnh Đà Nẵng, được đánh giá Tuyệt hảo, địa chỉ: Xuan Thieu, Nguyen Tat Thanh', 6194444.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Vịnh Đà Nẵng', 50, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(388, 'Son Tra Beach Resort & Spa Danang', 'Đà Nẵng', 'Son Tra Beach Resort & Spa Danang, nằm ở Bán đảo Sơn Trà, được đánh giá Rất tốt, địa chỉ: Bai Nam Bai Con Son Tra District', 5230800.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Bán đảo Sơn Trà', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(389, 'Vanda Hotel', 'Đà Nẵng', 'Vanda Hotel, nằm ở Sông Hàn, được đánh giá Tuyệt hảo, địa chỉ: 03 Nguyen Van Linh', 1350000.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Sông Hàn', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(390, 'Fivitel Boutique Da Nang', 'Hải Châu', 'Fivitel Boutique Da Nang, nằm ở Trung tâm Thành phố Đà Nẵng, được đánh giá Tuyệt hảo, địa chỉ: 202 Nguyễn Chí Thanh Phước Ninh, Hải Châu, Đà Nẵng', 963600.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Trung tâm Thành phố Đà Nẵng', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(391, 'Quoc Cuong Center Da Nang Hotel by Haviland', 'Đà Nẵng', 'Quoc Cuong Center Da Nang Hotel by Haviland, nằm ở Trung tâm Thành phố Đà Nẵng, được đánh giá Rất tốt, địa chỉ: 324-326 Hoang Dieu Street', 387828.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Trung tâm Thành phố Đà Nẵng', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(392, 'Seahorse Tropical Da Nang Hotel by Haviland', 'Đà Nẵng', 'Seahorse Tropical Da Nang Hotel by Haviland, nằm ở Sông Hàn, được đánh giá Tuyệt hảo, địa chỉ: 29 Yen Bai, Hai Chau ', 1064950.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Sông Hàn', 0, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(393, 'Fivitel Da Nang', 'Đà Nẵng', 'Fivitel Da Nang, nằm ở Sông Hàn, được đánh giá Tuyệt vời, địa chỉ: 388 Tran Hung Dao street, An Hai Tay Ward', 960300.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Sông Hàn', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(394, 'Sanouva Da Nang Hotel - Daily Afternoon Tea Inclusive', 'Đà Nẵng', 'Sanouva Da Nang Hotel - Daily Afternoon Tea Inclusive, nằm ở Trung tâm Thành phố Đà Nẵng, được đánh giá Tuyệt vời, địa chỉ: 68 Phan Chau Trinh, Hai Chau', 1210986.00, 'Khách sạn tiện nghi với vị trí thuận lợi tại trung tâm thành phố, dễ dàng di chuyển đến các điểm tham quan và khu mua sắm. Phòng nghỉ sạch sẽ và đầy đủ tiện nghi cơ bản với giường êm ái, TV màn hình phẳng, minibar và két an toàn. Phòng tắm riêng với vòi sen nóng lạnh, đồ vệ sinh cá nhân chất lượng. Dịch vụ chuyên nghiệp với lễ tân 24/24, hỗ trợ đặt vé máy bay và tour du lịch. Nhà hàng phục vụ các món ăn địa phương và quốc tế, bar với không gian thư giãn. Wifi tốc độ cao miễn phí toàn khuôn viên, bãi đỗ xe rộng rãi và dịch vụ giặt ủi. Lý tưởng cho cả du lịch và công tác với mức giá hợp lý.', 'Trung tâm Thành phố Đà Nẵng', 40, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Family rooms\", \"Terrace\"]', '2025-10-09 20:17:14', '2025-10-09 20:17:14', NULL, 'approved'),
(395, 'Muong Thanh Grand Da Nang Hotel', 'Đà Nẵng', 'Muong Thanh Grand Da Nang Hotel, nằm ở Sông Hàn, được đánh giá Tốt, địa chỉ: 962 Ngo Quyen Street, An Hai Tay Ward', 1055700.00, 'Khách sạn 5 sao đẳng cấp với kiến trúc hoàng gia sang trọng, tọa lạc tại trung tâm thành phố. Sảnh đón tiếp rộng lớn với trần cao và đèn chùm pha lê, tạo ấn tượng ngay từ cái nhìn đầu tiên. Phòng nghỉ cao cấp với nội thất tinh xảo, giường king size êm ái, phòng tắm sang trọng với bồn tắm riêng và vòi sen massage. Hệ thống nhà hàng đa dạng ẩm thực từ Âu đến Á, bar trên cao với view toàn cảnh thành phố về đêm. Dịch vụ spa chuyên nghiệp với các liệu pháp thư giãn độc quyền, hồ bơi bốn mùa trong nhà và phòng tập đạt tiêu chuẩn quốc tế. Đội ngũ butler chuyên nghiệp phục vụ 24/7, đáp ứng mọi yêu cầu của khách hàng.', 'Sông Hàn', 40, '[\"WiFi\", \"Spa\", \"Restaurant\", \"Bar\", \"Swimming pool\", \"Fitness center\"]', '2025-10-09 20:17:15', '2025-10-09 20:17:15', NULL, 'approved'),
(396, 'CENTRAL BOUTIQUE HOTEL', 'Đà Nẵng', 'CENTRAL BOUTIQUE HOTEL, nằm ở Sông Hàn, được đánh giá Rất tốt, địa chỉ: 60 Đường 2/9, Phường Bình Hiên, Quận Hải Châu, Thành phố Đà Nẵng, Việt Nam', 468342.00, 'Khách sạn boutique với kiến trúc độc đáo kết hợp giữa nét truyền thống và hiện đại, tạo nên một không gian nghỉ dưỡng đầy nghệ thuật. Mỗi phòng đều được trang trí tỉ mỉ với phong cách riêng biệt, sử dụng chất liệu gỗ tự nhiên và các tác phẩm nghệ thuật địa phương. Phòng ngủ được thiết kế ấm cúng với giường ngủ cao cấp, phòng tắm rộng rãi với đầy đủ tiện nghi. Vị trí thuận lợi trong khu phố cổ, dễ dàng khám phá các di tích lịch sử và trải nghiệm văn hóa địa phương. Nhà hàng phục vụ ẩm thực fusion độc đáo, kết hợp hương vị truyền thống và hiện đại. Dịch vụ tour hướng dẫn khám phá phố cổ và các làng nghề truyền thống được cung cấp hàng ngày.', 'Sông Hàn', 30, '[\"WiFi\", \"Restaurant\", \"Bar\", \"Terrace\", \"Family rooms\", \"Spa\", \"Tour desk\"]', '2025-10-09 20:17:15', '2025-10-09 20:17:15', NULL, 'approved');

-- --------------------------------------------------------

--
-- Table structure for table `hotel_styles`
--

CREATE TABLE `hotel_styles` (
  `id` bigint UNSIGNED NOT NULL,
  `hotel_id` bigint UNSIGNED NOT NULL,
  `style_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hotel_styles`
--

INSERT INTO `hotel_styles` (`id`, `hotel_id`, `style_id`, `created_at`, `updated_at`) VALUES
(11, 2, 3, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(12, 2, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(13, 3, 5, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(14, 3, 2, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(15, 4, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(16, 5, 2, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(17, 5, 5, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(18, 6, 1, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(19, 6, 3, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(20, 7, 3, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(21, 7, 5, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(22, 7, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(23, 8, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(24, 9, 1, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(25, 9, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(26, 10, 1, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(27, 10, 3, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(28, 10, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(29, 11, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(30, 12, 4, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(31, 12, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(32, 13, 1, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(33, 13, 4, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(34, 13, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(35, 14, 5, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(36, 15, 5, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(37, 15, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(38, 16, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(39, 17, 5, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(40, 17, 1, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(41, 17, 3, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(42, 18, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(43, 19, 1, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(44, 19, 5, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(45, 19, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(46, 20, 3, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(47, 20, 5, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(48, 21, 4, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(49, 21, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(50, 22, 3, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(51, 22, 5, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(52, 22, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(53, 23, 3, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(54, 23, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(55, 24, 3, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(56, 24, 5, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(57, 24, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(58, 25, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(59, 26, 5, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(60, 26, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(61, 27, 4, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(62, 28, 2, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(63, 28, 3, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(64, 28, 5, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(65, 29, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(66, 30, 3, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(67, 30, 5, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(68, 30, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(69, 31, 4, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(70, 31, 5, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(71, 31, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(72, 32, 5, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(73, 33, 1, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(74, 33, 3, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(75, 33, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(76, 34, 2, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(77, 34, 5, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(78, 34, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(79, 35, 4, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(80, 36, 1, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(81, 36, 4, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(82, 37, 4, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(83, 37, 5, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(84, 37, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(85, 38, 2, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(86, 38, 4, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(87, 39, 3, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(88, 40, 1, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(89, 40, 3, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(90, 41, 1, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(91, 42, 2, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(92, 42, 3, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(93, 43, 2, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(94, 43, 3, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(95, 44, 2, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(96, 44, 4, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(97, 45, 4, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(98, 46, 2, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(99, 47, 3, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(100, 48, 2, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(101, 48, 4, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(102, 48, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(103, 49, 1, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(104, 50, 2, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(105, 50, 3, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(106, 50, 5, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(107, 51, 5, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(108, 51, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(109, 52, 3, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(110, 52, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(111, 53, 5, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(112, 53, 6, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(113, 54, 2, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(114, 54, 3, '2025-10-11 12:48:11', '2025-10-11 12:48:11'),
(115, 54, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(116, 55, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(117, 55, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(118, 55, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(119, 56, 3, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(120, 57, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(121, 58, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(122, 58, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(123, 59, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(124, 60, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(125, 60, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(126, 60, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(127, 61, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(128, 61, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(129, 62, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(130, 62, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(131, 62, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(132, 63, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(133, 63, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(134, 64, 1, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(135, 64, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(136, 64, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(137, 65, 1, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(138, 65, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(139, 66, 1, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(140, 67, 3, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(141, 68, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(142, 68, 3, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(143, 69, 1, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(144, 69, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(145, 70, 3, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(146, 71, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(147, 72, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(148, 72, 3, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(149, 72, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(150, 73, 1, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(151, 73, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(152, 73, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(153, 74, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(154, 75, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(155, 75, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(156, 76, 3, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(157, 76, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(158, 76, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(159, 77, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(160, 77, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(161, 78, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(162, 78, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(163, 78, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(164, 79, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(165, 79, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(166, 79, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(167, 80, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(168, 81, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(169, 81, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(170, 82, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(171, 82, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(172, 83, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(173, 83, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(174, 83, 3, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(175, 84, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(176, 78, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(177, 85, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(178, 85, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(179, 85, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(180, 86, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(181, 87, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(182, 87, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(183, 88, 3, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(184, 88, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(185, 88, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(186, 89, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(187, 90, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(188, 90, 3, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(189, 91, 1, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(190, 91, 3, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(191, 92, 3, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(192, 92, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(193, 93, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(194, 94, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(195, 95, 1, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(196, 95, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(197, 95, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(198, 96, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(199, 96, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(200, 97, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(201, 98, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(202, 94, 1, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(203, 94, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(204, 94, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(205, 99, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(206, 99, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(207, 100, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(208, 100, 3, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(209, 101, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(210, 101, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(211, 102, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(212, 102, 3, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(213, 102, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(214, 103, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(215, 104, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(216, 104, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(217, 91, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(218, 105, 1, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(219, 105, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(220, 105, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(221, 106, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(222, 106, 3, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(223, 106, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(224, 107, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(225, 108, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(226, 108, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(227, 108, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(228, 109, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(229, 110, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(230, 110, 3, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(231, 111, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(232, 111, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(233, 111, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(234, 112, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(235, 113, 3, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(236, 114, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(237, 114, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(238, 114, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(239, 115, 1, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(240, 115, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(241, 115, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(242, 116, 1, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(243, 116, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(244, 117, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(245, 117, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(246, 117, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(247, 118, 1, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(248, 118, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(249, 119, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(250, 119, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(251, 120, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(252, 120, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(253, 120, 1, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(254, 121, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(255, 121, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(256, 121, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(257, 122, 1, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(258, 122, 3, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(259, 122, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(260, 123, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(261, 124, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(262, 124, 3, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(263, 125, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(264, 125, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(265, 126, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(266, 127, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(267, 128, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(268, 128, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(269, 129, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(270, 129, 3, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(271, 129, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(272, 130, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(273, 130, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(274, 130, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(275, 131, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(276, 132, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(277, 133, 1, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(278, 133, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(279, 134, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(280, 135, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(281, 135, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(282, 135, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(283, 136, 1, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(284, 136, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(285, 136, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(286, 137, 1, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(287, 137, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(288, 138, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(289, 139, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(290, 139, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(291, 140, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(292, 140, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(293, 140, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(294, 141, 3, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(295, 114, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(296, 142, 1, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(297, 142, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(298, 143, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(299, 143, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(300, 143, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(301, 144, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(302, 145, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(303, 146, 1, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(304, 146, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(305, 147, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(306, 147, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(307, 147, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(308, 148, 2, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(309, 148, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(310, 148, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(311, 149, 1, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(312, 149, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(313, 149, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(314, 150, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(315, 151, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(316, 152, 3, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(317, 152, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(318, 149, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(319, 153, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(320, 153, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(321, 153, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(322, 154, 1, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(323, 154, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(324, 154, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(325, 155, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(326, 155, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(327, 156, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(328, 157, 1, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(329, 158, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(330, 158, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(331, 159, 4, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(332, 159, 5, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(333, 159, 6, '2025-10-11 12:48:12', '2025-10-11 12:48:12'),
(334, 160, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(335, 160, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(336, 160, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(337, 161, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(338, 161, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(339, 162, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(340, 162, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(341, 162, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(342, 163, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(343, 163, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(344, 164, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(345, 165, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(346, 165, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(347, 165, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(348, 166, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(349, 167, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(350, 167, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(351, 168, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(352, 169, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(353, 169, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(354, 169, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(355, 170, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(356, 170, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(357, 170, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(358, 171, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(359, 171, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(360, 172, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(361, 172, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(362, 172, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(363, 173, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(364, 173, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(365, 173, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(366, 174, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(367, 175, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(368, 176, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(369, 177, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(370, 177, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(371, 178, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(372, 179, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(373, 179, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(374, 179, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(375, 180, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(376, 181, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(377, 181, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(378, 181, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(379, 182, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(380, 182, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(381, 183, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(382, 184, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(383, 184, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(384, 185, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(385, 186, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(386, 187, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(387, 188, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(388, 188, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(389, 189, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(390, 189, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(391, 189, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(392, 190, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(393, 191, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(394, 191, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(395, 192, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(396, 192, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(397, 193, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(398, 193, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(399, 194, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(400, 195, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(401, 196, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(402, 196, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(403, 197, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(404, 197, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(405, 198, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(406, 199, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(407, 199, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(408, 200, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(409, 200, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(410, 201, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(411, 202, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(412, 202, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(413, 202, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(414, 203, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(415, 203, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(416, 203, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(417, 204, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(418, 204, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(419, 204, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(420, 205, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(421, 205, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(422, 205, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(423, 206, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(424, 206, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(425, 207, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(426, 207, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(427, 207, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(428, 208, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(429, 209, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(430, 209, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(431, 210, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(432, 210, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(433, 211, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(434, 211, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(435, 211, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(436, 98, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(437, 212, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(438, 212, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(439, 213, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(440, 214, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(441, 215, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(442, 215, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(443, 216, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(444, 216, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(445, 217, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(446, 217, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(447, 217, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(448, 218, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(449, 219, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(450, 219, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(451, 220, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(452, 220, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(453, 220, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(454, 221, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(455, 221, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(456, 222, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(457, 222, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(458, 220, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(459, 221, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(460, 223, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(461, 223, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(462, 224, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(463, 225, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(464, 225, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(465, 225, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(466, 226, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(467, 226, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(468, 227, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(469, 227, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(470, 228, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(471, 228, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(472, 229, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(473, 229, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(474, 229, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(475, 230, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(476, 230, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(477, 231, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(478, 231, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(479, 231, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(480, 232, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(481, 233, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(482, 233, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(483, 233, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(484, 234, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(485, 235, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(486, 236, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(487, 236, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(488, 237, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(489, 237, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(490, 237, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(491, 238, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(492, 239, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(493, 239, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(494, 240, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(495, 240, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(496, 240, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(497, 241, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(498, 241, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(499, 242, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(500, 242, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(501, 242, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(502, 243, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(503, 244, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(504, 244, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(505, 244, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(506, 245, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(507, 245, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(508, 246, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(509, 246, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(510, 247, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(511, 247, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(512, 248, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(513, 248, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(514, 249, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(515, 249, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(516, 250, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(517, 250, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(518, 234, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(519, 234, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(520, 251, 2, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(521, 251, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(522, 252, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(523, 253, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(524, 253, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(525, 254, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(526, 254, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(527, 254, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(528, 255, 1, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(529, 255, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(530, 255, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(531, 256, 5, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(532, 256, 3, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(533, 256, 6, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(534, 257, 4, '2025-10-11 12:48:13', '2025-10-11 12:48:13'),
(535, 257, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(536, 258, 1, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(537, 258, 3, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(538, 259, 2, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(539, 259, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(540, 260, 2, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(541, 260, 4, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(542, 260, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(543, 261, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(544, 261, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(545, 261, 2, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(546, 262, 2, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(547, 262, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(548, 262, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(549, 263, 3, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(550, 263, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(551, 263, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(552, 264, 2, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(553, 264, 3, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(554, 265, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(555, 266, 4, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(556, 267, 2, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(557, 267, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(558, 267, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(559, 250, 2, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(560, 250, 4, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(561, 268, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(562, 269, 1, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(563, 269, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(564, 269, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(565, 270, 1, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(566, 271, 2, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(567, 264, 4, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(568, 264, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(569, 272, 2, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(570, 272, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(571, 273, 1, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(572, 273, 3, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(573, 273, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(574, 257, 2, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(575, 274, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(576, 275, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(577, 275, 2, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(578, 275, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(579, 276, 3, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(580, 277, 2, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(581, 277, 3, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(582, 277, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(583, 267, 4, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(584, 278, 1, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(585, 278, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(586, 271, 3, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(587, 271, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(588, 270, 2, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(589, 270, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(590, 279, 2, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(591, 280, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(592, 281, 1, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(593, 281, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(594, 282, 1, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(595, 282, 4, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(596, 282, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(597, 283, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(598, 284, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(599, 284, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(600, 285, 3, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(601, 286, 1, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(602, 286, 4, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(603, 287, 4, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(604, 287, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(605, 288, 1, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(606, 288, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(607, 289, 2, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(608, 289, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(609, 290, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(610, 291, 3, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(611, 291, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(612, 292, 2, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(613, 292, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(614, 292, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(615, 293, 4, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(616, 293, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(617, 294, 1, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(618, 295, 1, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(619, 295, 3, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(620, 296, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(621, 297, 1, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(622, 297, 4, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(623, 298, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(624, 298, 1, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(625, 298, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(626, 299, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(627, 299, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(628, 300, 3, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(629, 300, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(630, 301, 2, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(631, 301, 4, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(632, 301, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(633, 302, 1, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(634, 302, 3, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(635, 303, 4, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(636, 304, 4, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(637, 303, 2, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(638, 303, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(639, 303, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(640, 305, 1, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(641, 305, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(642, 295, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(643, 306, 4, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(644, 306, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(645, 306, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(646, 307, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(647, 307, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(648, 307, 2, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(649, 304, 1, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(650, 308, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(651, 309, 3, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(652, 309, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(653, 310, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(654, 311, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(655, 312, 3, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(656, 312, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(657, 313, 1, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(658, 313, 5, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(659, 313, 3, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(660, 314, 6, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(661, 315, 1, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(662, 315, 3, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(663, 316, 2, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(664, 316, 4, '2025-10-11 12:48:14', '2025-10-11 12:48:14'),
(665, 317, 3, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(666, 317, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(667, 317, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(668, 318, 3, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(669, 318, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(670, 319, 1, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(671, 319, 4, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(672, 319, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(673, 314, 2, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(674, 320, 1, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(675, 320, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(676, 320, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(677, 321, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(678, 322, 2, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(679, 322, 4, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(680, 322, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(681, 323, 3, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(682, 323, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(683, 324, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(684, 325, 1, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(685, 325, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(686, 326, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(687, 327, 4, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(688, 327, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(689, 327, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(690, 328, 1, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(691, 328, 4, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(692, 328, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(693, 329, 2, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(694, 330, 1, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(695, 330, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(696, 330, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(697, 331, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(698, 332, 3, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(699, 332, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(700, 332, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(701, 333, 2, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(702, 333, 3, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(703, 333, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(704, 289, 4, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(705, 289, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(706, 334, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(707, 335, 3, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(708, 336, 1, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(709, 336, 4, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(710, 336, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(711, 337, 4, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(712, 338, 1, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(713, 338, 4, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(714, 339, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(715, 339, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(716, 339, 3, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(717, 340, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(718, 341, 3, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(719, 341, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(720, 341, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(721, 342, 2, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(722, 342, 4, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(723, 343, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(724, 344, 1, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(725, 344, 3, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(726, 344, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(727, 345, 2, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(728, 345, 3, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(729, 346, 4, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(730, 347, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(731, 348, 2, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(732, 348, 4, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(733, 349, 4, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(734, 350, 3, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(735, 350, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(736, 351, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(737, 352, 4, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(738, 353, 2, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(739, 353, 3, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(740, 353, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(741, 16, 4, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(742, 16, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(743, 25, 4, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(744, 25, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(745, 19, 2, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(746, 27, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(747, 27, 1, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(748, 27, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(749, 18, 1, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(750, 18, 4, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(751, 22, 2, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(752, 33, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(753, 40, 2, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(754, 40, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(755, 42, 1, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(756, 42, 4, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(757, 42, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(758, 32, 4, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(759, 48, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(760, 354, 2, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(761, 354, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(762, 355, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(763, 355, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(764, 356, 2, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(765, 357, 1, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(766, 357, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(767, 358, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(768, 358, 1, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(769, 358, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(770, 359, 4, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(771, 359, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(772, 360, 4, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(773, 360, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(774, 360, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(775, 361, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(776, 361, 2, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(777, 361, 4, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(778, 362, 3, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(779, 362, 6, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(780, 363, 5, '2025-10-11 12:48:15', '2025-10-11 12:48:15'),
(781, 364, 2, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(782, 364, 3, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(783, 365, 2, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(784, 365, 5, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(785, 366, 5, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(786, 366, 6, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(787, 367, 1, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(788, 367, 5, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(789, 368, 2, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(790, 368, 4, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(791, 368, 5, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(792, 369, 3, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(793, 370, 6, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(794, 370, 4, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(795, 370, 5, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(796, 371, 3, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(797, 371, 1, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(798, 371, 5, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(799, 372, 5, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(800, 372, 6, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(801, 373, 4, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(802, 373, 5, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(803, 373, 6, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(804, 374, 1, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(805, 374, 4, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(806, 374, 5, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(807, 375, 1, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(808, 375, 5, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(809, 376, 2, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(810, 376, 5, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(811, 376, 6, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(812, 377, 4, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(813, 377, 6, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(814, 378, 1, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(815, 378, 3, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(816, 378, 5, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(817, 379, 2, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(818, 379, 4, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(819, 380, 5, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(820, 380, 6, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(821, 381, 2, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(822, 381, 5, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(823, 382, 3, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(824, 382, 5, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(825, 382, 6, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(826, 383, 3, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(827, 383, 6, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(828, 384, 1, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(829, 384, 6, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(830, 385, 6, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(831, 385, 1, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(832, 385, 4, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(833, 386, 1, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(834, 386, 5, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(835, 387, 1, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(836, 387, 5, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(837, 388, 4, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(838, 389, 5, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(839, 390, 2, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(840, 390, 3, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(841, 391, 6, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(842, 392, 5, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(843, 393, 2, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(844, 393, 5, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(845, 394, 1, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(846, 394, 5, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(847, 394, 6, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(848, 395, 3, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(849, 395, 6, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(850, 395, 5, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(851, 396, 2, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(852, 396, 4, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(853, 396, 6, '2025-10-11 12:48:16', '2025-10-11 12:48:16'),
(861, 401, 2, NULL, NULL),
(862, 401, 3, NULL, NULL),
(863, 402, 2, NULL, NULL),
(864, 402, 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `id` bigint UNSIGNED NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`id`, `url`, `type`, `reference_id`, `created_at`, `updated_at`) VALUES
(1241, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760241943/hotels/1/r98yc4fab7bwpra9godb.webp', 'hotel', 1, '2025-10-11 21:05:44', '2025-10-11 21:05:44'),
(1242, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760241947/hotels/1/vfkp4vepg31fie4cms7t.webp', 'hotel', 1, '2025-10-11 21:05:46', '2025-10-11 21:05:46'),
(1243, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760241949/hotels/1/m9syhcks151jrgbz2b5m.webp', 'hotel', 1, '2025-10-11 21:05:49', '2025-10-11 21:05:49'),
(1244, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760242071/hotels/2/afmulohmgzrb7tbsf1nz.webp', 'hotel', 2, '2025-10-11 21:07:50', '2025-10-11 21:07:50'),
(1245, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760242073/hotels/2/rlgruvsaucyfk4gfqcw9.webp', 'hotel', 2, '2025-10-11 21:07:53', '2025-10-11 21:07:53'),
(1246, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760242075/hotels/2/wi9rdhlnnncuvega248p.webp', 'hotel', 2, '2025-10-11 21:07:55', '2025-10-11 21:07:55'),
(1247, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760242114/hotels/3/bbxaipyrpoypawhvbfpv.webp', 'hotel', 3, '2025-10-11 21:08:34', '2025-10-11 21:08:34'),
(1248, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760242117/hotels/3/wojin2spbm4cj1vlg7pf.webp', 'hotel', 3, '2025-10-11 21:08:36', '2025-10-11 21:08:36'),
(1249, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760242120/hotels/3/aizpn01ezvsbjfqxtals.webp', 'hotel', 3, '2025-10-11 21:08:39', '2025-10-11 21:08:39'),
(1250, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760242164/hotels/4/gdpwmfet06bssemrqzmv.webp', 'hotel', 4, '2025-10-11 21:09:24', '2025-10-11 21:09:24'),
(1251, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760242167/hotels/4/ydma8q33uqjgiqcsfwfr.webp', 'hotel', 4, '2025-10-11 21:09:27', '2025-10-11 21:09:27'),
(1252, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760242170/hotels/4/codckgn2momkjljd9ouw.webp', 'hotel', 4, '2025-10-11 21:09:30', '2025-10-11 21:09:30'),
(1253, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760242202/hotels/5/ulecmwbh65ilojs6mtss.webp', 'hotel', 5, '2025-10-11 21:10:02', '2025-10-11 21:10:02'),
(1254, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760242204/hotels/5/ijsi6othvtkerxh2vrah.webp', 'hotel', 5, '2025-10-11 21:10:04', '2025-10-11 21:10:04'),
(1255, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760242207/hotels/5/fx7hcpoptrz5kbvc73ey.webp', 'hotel', 5, '2025-10-11 21:10:06', '2025-10-11 21:10:06'),
(1256, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760242391/hotels/15/w2leahqvp1wvllpc8wk3.webp', 'hotel', 15, '2025-10-11 21:13:12', '2025-10-11 21:13:12'),
(1257, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760242413/hotels/15/a8kmfj1zbdvkgmz0uyih.webp', 'hotel', 15, '2025-10-11 21:13:33', '2025-10-11 21:13:33'),
(1258, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760242417/hotels/15/sximdmkmy3ljfjliyyss.webp', 'hotel', 15, '2025-10-11 21:13:38', '2025-10-11 21:13:38'),
(1261, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760242776/hotels/17/ltpgg5w4okzqjab0sfkv.webp', 'hotel', 17, '2025-10-11 21:19:36', '2025-10-11 21:19:36'),
(1262, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760242778/hotels/17/zpq35qucubdbcnimg2zk.jpg', 'hotel', 17, '2025-10-11 21:19:38', '2025-10-11 21:19:38'),
(1263, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760242780/hotels/17/e4hrbvciyuutqg3i3b29.jpg', 'hotel', 17, '2025-10-11 21:19:39', '2025-10-11 21:19:39'),
(1264, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760242952/hotels/27/qys8csprda9qlgzzxco1.webp', 'hotel', 27, '2025-10-11 21:22:33', '2025-10-11 21:22:33'),
(1265, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760242956/hotels/27/t5wyzkfhg02tdvgenqlm.webp', 'hotel', 27, '2025-10-11 21:22:36', '2025-10-11 21:22:36'),
(1266, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760242960/hotels/27/ojtabt3bujhfon6s4ev0.webp', 'hotel', 27, '2025-10-11 21:22:39', '2025-10-11 21:22:39'),
(1267, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760320597/hotels/16/twi0sdmlb5q1m2lku5ww.webp', 'hotel', 16, '2025-10-12 18:56:37', '2025-10-12 18:56:37'),
(1268, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760320599/hotels/16/nvovh3ecpuvlh0mdno1t.jpg', 'hotel', 16, '2025-10-12 18:56:39', '2025-10-12 18:56:39'),
(1269, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760320602/hotels/16/yb0t9udnrpgdi5joj8lh.webp', 'hotel', 16, '2025-10-12 18:56:41', '2025-10-12 18:56:41'),
(1270, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760320734/hotels/28/zbxxh33mdvg2ayzhdji1.webp', 'hotel', 28, '2025-10-12 18:58:54', '2025-10-12 18:58:54'),
(1271, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760320736/hotels/28/ydqfs2itdxalghinhgff.webp', 'hotel', 28, '2025-10-12 18:58:56', '2025-10-12 18:58:56'),
(1272, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760320739/hotels/28/ns2luvwqlqxmpggwdobs.webp', 'hotel', 28, '2025-10-12 18:58:59', '2025-10-12 18:58:59'),
(1273, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760801101/hotels/29/bzj2lv372qslcoucnvjn.webp', 'hotel', 29, '2025-10-18 08:25:00', '2025-10-18 08:25:00'),
(1274, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760801105/hotels/29/dszryon8xfxxwuyp4law.webp', 'hotel', 29, '2025-10-18 08:25:04', '2025-10-18 08:25:04'),
(1275, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760801108/hotels/29/yanl4mlh9mcymmetip0h.webp', 'hotel', 29, '2025-10-18 08:25:07', '2025-10-18 08:25:07'),
(1276, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760801448/hotels/30/i4fibfzwvpjps15paf5q.webp', 'hotel', 30, '2025-10-18 08:30:47', '2025-10-18 08:30:47'),
(1277, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760801451/hotels/30/qg4i4uhuyhrnfzh17wgn.webp', 'hotel', 30, '2025-10-18 08:30:49', '2025-10-18 08:30:49'),
(1278, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760801454/hotels/30/xxf5sq3ubcu8tjmttlnz.webp', 'hotel', 30, '2025-10-18 08:30:52', '2025-10-18 08:30:52'),
(1279, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760801695/hotels/31/l64rjfh4tuq0jhwwlodj.webp', 'hotel', 31, '2025-10-18 08:34:53', '2025-10-18 08:34:53'),
(1280, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760801697/hotels/31/z5lkgfgi6uncsehuf9tl.webp', 'hotel', 31, '2025-10-18 08:34:56', '2025-10-18 08:34:56'),
(1281, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760801700/hotels/31/tb882apjhpkmizwc0jbq.webp', 'hotel', 31, '2025-10-18 08:34:58', '2025-10-18 08:34:58'),
(1282, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760801947/hotels/32/ymvgo4f1pzdeudlut64d.webp', 'hotel', 32, '2025-10-18 08:39:06', '2025-10-18 08:39:06'),
(1283, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760801951/hotels/32/ltve0mwhvqp7k9xtkivw.webp', 'hotel', 32, '2025-10-18 08:39:10', '2025-10-18 08:39:10'),
(1284, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760801954/hotels/32/p7pqots0zhxj7xplm6ue.webp', 'hotel', 32, '2025-10-18 08:39:14', '2025-10-18 08:39:14'),
(1285, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760802114/hotels/33/so8kux4etwuznz2stuhk.webp', 'hotel', 33, '2025-10-18 08:41:53', '2025-10-18 08:41:53'),
(1286, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760802117/hotels/33/wdrz81czbdm2pc3qeckr.webp', 'hotel', 33, '2025-10-18 08:41:56', '2025-10-18 08:41:56'),
(1287, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760802119/hotels/33/cjnftvuiwdz9a5a8ruha.webp', 'hotel', 33, '2025-10-18 08:41:58', '2025-10-18 08:41:58'),
(1288, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760802261/hotels/34/z73lm5rrpiz5nbjffp5g.webp', 'hotel', 34, '2025-10-18 08:44:20', '2025-10-18 08:44:20'),
(1289, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760802264/hotels/34/mtr8ga7y3jqoegiumrdc.webp', 'hotel', 34, '2025-10-18 08:44:23', '2025-10-18 08:44:23'),
(1290, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760802267/hotels/34/egc0dhnqj84hzr9qlnpr.webp', 'hotel', 34, '2025-10-18 08:44:25', '2025-10-18 08:44:25'),
(1291, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760802405/hotels/35/q3jcuvjteivhblx0ogvq.webp', 'hotel', 35, '2025-10-18 08:46:44', '2025-10-18 08:46:44'),
(1292, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760802409/hotels/35/ewybufphm8ipidj3e3os.webp', 'hotel', 35, '2025-10-18 08:46:48', '2025-10-18 08:46:48'),
(1293, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760802413/hotels/35/wc8jqi417zacfqf5nfet.webp', 'hotel', 35, '2025-10-18 08:46:52', '2025-10-18 08:46:52'),
(1294, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760802549/hotels/36/chglhtgwtkkcj9jpojft.webp', 'hotel', 36, '2025-10-18 08:49:07', '2025-10-18 08:49:07'),
(1295, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760802552/hotels/36/jsfgxiyn9o7jwfmq9sje.jpg', 'hotel', 36, '2025-10-18 08:49:11', '2025-10-18 08:49:11'),
(1296, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760802555/hotels/36/o4csu8fvxemdv6cw7zh4.webp', 'hotel', 36, '2025-10-18 08:49:14', '2025-10-18 08:49:14'),
(1297, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760802908/hotels/37/npru3o7zqwoig2whup4c.webp', 'hotel', 37, '2025-10-18 08:55:07', '2025-10-18 08:55:07'),
(1298, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760802912/hotels/37/sejgfobmdlamzqwkavgo.webp', 'hotel', 37, '2025-10-18 08:55:10', '2025-10-18 08:55:10'),
(1299, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760802915/hotels/37/uygkowcibils8hfqix4s.webp', 'hotel', 37, '2025-10-18 08:55:14', '2025-10-18 08:55:14'),
(1300, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760803481/hotels/38/nmfqbrput7c1nqiscsrz.webp', 'hotel', 38, '2025-10-18 09:04:40', '2025-10-18 09:04:40'),
(1301, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760803484/hotels/38/vq3ji6ebevj381djc4cs.webp', 'hotel', 38, '2025-10-18 09:04:43', '2025-10-18 09:04:43'),
(1302, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760803488/hotels/38/trynxyfqnnfje7ydquax.webp', 'hotel', 38, '2025-10-18 09:04:47', '2025-10-18 09:04:47'),
(1305, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760804689/hotels/40/jccw7ebwwyuh9ltihakv.webp', 'hotel', 40, '2025-10-18 09:24:48', '2025-10-18 09:24:48'),
(1306, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760804693/hotels/40/askzqczgnxqy25spyvkb.webp', 'hotel', 40, '2025-10-18 09:24:51', '2025-10-18 09:24:51'),
(1307, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760804696/hotels/40/hxwelfmeu7zgjl77a6wp.webp', 'hotel', 40, '2025-10-18 09:24:55', '2025-10-18 09:24:55'),
(1308, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760805209/hotels/41/v1tuxj3wu305fnkachni.webp', 'hotel', 41, '2025-10-18 09:33:28', '2025-10-18 09:33:28'),
(1309, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760805212/hotels/41/wl8qwp1qdi5ogxrirxeu.webp', 'hotel', 41, '2025-10-18 09:33:31', '2025-10-18 09:33:31'),
(1310, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1760805215/hotels/41/uxsb4kn2ytowzdumvyk8.webp', 'hotel', 41, '2025-10-18 09:33:34', '2025-10-18 09:33:34'),
(1311, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1761757212/hotels/55/sj03kz2fk8z0ubol9nr7.webp', 'hotel', 55, '2025-10-29 10:00:11', '2025-10-29 10:00:11'),
(1312, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1761757215/hotels/55/dujo3vmkofjfjuul1klq.webp', 'hotel', 55, '2025-10-29 10:00:16', '2025-10-29 10:00:16'),
(1313, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1761757219/hotels/55/j3qhsdxgbzcpukh4qh8k.webp', 'hotel', 55, '2025-10-29 10:00:19', '2025-10-29 10:00:19'),
(1314, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1761757473/hotels/376/c6qxtswwvljx0epqrtx4.webp', 'hotel', 376, '2025-10-29 10:04:33', '2025-10-29 10:04:33'),
(1315, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1761757477/hotels/376/rj7iya8ehl01p4lyljuh.webp', 'hotel', 376, '2025-10-29 10:04:36', '2025-10-29 10:04:36'),
(1316, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1761757480/hotels/376/tgxc02nk9xjdhjxgawof.webp', 'hotel', 376, '2025-10-29 10:04:41', '2025-10-29 10:04:41'),
(1317, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1761758537/hotels/376/ksgtaocrq7mjp9zfqzgg.jpg', 'hotel', 376, '2025-10-29 10:22:16', '2025-10-29 10:22:16'),
(1318, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1761758539/hotels/376/oac55jbyjn4myrnb7gbf.webp', 'hotel', 376, '2025-10-29 10:22:18', '2025-10-29 10:22:18'),
(1319, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1761758541/hotels/376/ci3lavstebtagjmzlzkc.webp', 'hotel', 376, '2025-10-29 10:22:21', '2025-10-29 10:22:21'),
(1320, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1761758546/hotels/255/aqochuvbmsza4egudrfr.jpg', 'hotel', 255, '2025-10-29 10:22:26', '2025-10-29 10:22:26'),
(1321, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1761758549/hotels/255/ykrlfawcth1lrcml4ly6.webp', 'hotel', 255, '2025-10-29 10:22:28', '2025-10-29 10:22:28'),
(1322, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1761758551/hotels/255/kiio1cbmzomcuhdouyga.webp', 'hotel', 255, '2025-10-29 10:22:30', '2025-10-29 10:22:30'),
(1323, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1761758680/hotels/58/ggjyb0ukv0lrhfcpfsts.webp', 'hotel', 58, '2025-10-29 10:24:40', '2025-10-29 10:24:40'),
(1324, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1761758683/hotels/58/rkysatm4hwjqqot6hdnv.webp', 'hotel', 58, '2025-10-29 10:24:42', '2025-10-29 10:24:42'),
(1325, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1761758685/hotels/58/l6bvyfle5zyrilkdzutf.webp', 'hotel', 58, '2025-10-29 10:24:44', '2025-10-29 10:24:44'),
(1326, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1761758767/hotels/59/s5ihycbiaypw5f0tgt5k.webp', 'hotel', 59, '2025-10-29 10:26:07', '2025-10-29 10:26:07'),
(1327, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1761758770/hotels/59/m1deu70lbfacgjw3cff7.webp', 'hotel', 59, '2025-10-29 10:26:09', '2025-10-29 10:26:09'),
(1328, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1761758772/hotels/59/emnhgs2kwy7bwg25hj3z.webp', 'hotel', 59, '2025-10-29 10:26:11', '2025-10-29 10:26:11'),
(1332, 'https://i.ibb.co/XfNBmTGD/47e13ecaf784.jpg', 'avatar', 8, '2025-11-03 19:08:07', '2025-11-03 19:08:07'),
(1336, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1771564323/hotels/401/webp/q26o0mgqaxcashpp8hkt.jpg', 'hotel', 401, '2026-02-19 22:11:59', '2026-02-19 22:11:59'),
(1337, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1771564325/hotels/401/webp/l80xj47r19evkvxq2v2c.webp', 'hotel', 401, '2026-02-19 22:12:01', '2026-02-19 22:12:01'),
(1338, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1771564327/hotels/401/webp/ws19fmyfq19hqv6q2ilv.webp', 'hotel', 401, '2026-02-19 22:12:03', '2026-02-19 22:12:03'),
(1339, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1771564471/hotels/402/webp/irlo60owae5yoiuqkx3q.jpg', 'hotel', 402, '2026-02-19 22:14:27', '2026-02-19 22:14:27'),
(1340, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1771564473/hotels/402/webp/tmuuvg6b3w3kidjfx75c.webp', 'hotel', 402, '2026-02-19 22:14:29', '2026-02-19 22:14:29'),
(1341, 'https://res.cloudinary.com/dh4yg3ktf/image/upload/v1771564474/hotels/402/webp/tklkmt6znfrgq0h6iq5u.webp', 'hotel', 402, '2026-02-19 22:14:30', '2026-02-19 22:14:30');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(4, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(6, '2016_06_01_000004_create_oauth_clients_table', 1),
(7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(8, '2019_08_19_000000_create_failed_jobs_table', 1),
(9, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(10, '2025_09_15_063705_add_phone_number_to_users_table', 1),
(11, '2025_09_20_103036_create_images_table', 1),
(12, '2025_09_21_122924_create_hotels_table', 1),
(13, '2025_09_27_163222_create_jobs_table', 1),
(14, '2025_10_03_000019_create_subscribers_table', 1),
(15, '2025_10_06_071819_create_bookings_table', 1),
(16, '2025_10_06_072034_create_comments_table', 1),
(17, '2025_10_06_072219_create_discounts_table', 1),
(18, '2025_10_06_072359_create_hotel_styles_table', 1),
(19, '2025_10_06_072640_create_payments_table', 1),
(20, '2025_10_06_072752_create_rates_table', 1),
(21, '2025_10_06_072956_create_recommendations_table', 1),
(22, '2025_10_06_073054_create_rooms_table', 1),
(23, '2025_10_06_073242_create_user_behaviors_table', 1),
(24, '2025_10_06_074342_create_styles_table', 1),
(25, '2025_10_13_032935_create_rooms_table', 2),
(26, '2025_10_26_032344_create_recommendations_table', 3),
(27, '2025_11_02_101401_add_cancel_policy_to_bookings_table', 4),
(28, '2025_11_02_163552_add_timestamps_to_payments_table', 5),
(29, '2025_11_08_163544_add_rating_to_comments_table', 6),
(30, '2025_11_15_063827_create_wishlists_table', 7),
(31, '2025_11_16_161507_add_pre_checkin_email_sent_to_bookings_table', 8),
(32, '2025_11_18_072143_add_wallet_balance_to_users_table', 9),
(33, '2025_11_18_083436_create_notifications_table', 10),
(34, '2025_11_24_044827_add_user_id_to_payments_table', 11),
(35, '2025_11_30_145436_create_support_tickets_table', 12),
(36, '2025_12_01_071730_add_is_blocked_to_users_table', 13),
(37, '2025_12_06_091839_create_discounts_table', 14),
(38, '2025_12_06_162845_add_discount_columns_to_bookings_table', 15),
(39, '2025_12_09_145655_add_is_sent_to_user_behaviors_table', 16),
(40, '2026_02_19_111037_add_user_id_to_hotels_table', 17);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `data` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `type`, `title`, `message`, `is_read`, `data`, `created_at`, `updated_at`) VALUES
(1, 8, 'payment', 'Thanh toán thành công', 'Booking #38 đã thanh toán thành công: 2.000.000 VND', 1, NULL, '2025-11-18 20:44:17', '2025-11-18 21:04:19'),
(2, 8, 'payment', 'Thanh toán thành công', 'Booking #39 đã thanh toán thành công: 2.000.000 VND', 1, NULL, '2025-11-18 21:08:38', '2025-11-18 21:09:05'),
(3, 8, 'payment', 'Thanh toán thành công', 'Booking #40 đã thanh toán thành công: 2.000.000 VND', 1, NULL, '2025-11-18 21:47:17', '2025-12-21 10:04:18'),
(4, 8, 'booking', 'Đặt phòng thành công', 'Booking #41 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, NULL, '2025-11-23 20:51:20', '2025-11-23 20:59:39'),
(5, 8, 'booking', 'Đặt phòng thành công', 'Booking #42 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, NULL, '2025-11-23 21:11:57', '2025-11-23 21:12:10'),
(6, 8, 'booking', 'Đặt phòng thành công', 'Booking #43 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, NULL, '2025-11-23 21:12:58', '2025-12-21 10:04:18'),
(7, 8, 'booking', 'Đặt phòng thành công', 'Booking #44 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 44}', '2025-11-23 21:25:06', '2025-11-23 21:25:14'),
(8, 8, 'booking', 'Đặt phòng thành công', 'Booking #45 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 45}', '2025-11-23 21:52:17', '2025-12-21 10:04:18'),
(9, 8, 'payment', 'Thanh toán thành công', 'Booking #45 đã thanh toán thành công: 1.800.000 VND', 1, NULL, '2025-11-23 21:53:39', '2025-12-21 10:04:18'),
(10, 8, 'booking', 'Đặt phòng thành công', 'Booking #46 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 46}', '2025-11-23 22:47:09', '2025-12-21 10:04:18'),
(11, 8, 'payment', 'Thanh toán thành công', 'Booking #46 đã thanh toán thành công: 1.800.000 VND', 1, NULL, '2025-11-23 22:48:05', '2025-12-21 10:04:18'),
(12, 8, 'booking', 'Đặt phòng thành công', 'Booking #47 của bạn đã được đặt thành công với tổng giá 2.000.000 VND.', 1, '{\"booking_id\": 47}', '2025-11-23 23:51:08', '2025-11-25 02:48:58'),
(13, 8, 'booking', 'Đặt phòng thành công', 'Booking #48 của bạn đã được đặt thành công với tổng giá 2.000.000 VND.', 1, '{\"booking_id\": 48}', '2025-11-25 03:00:08', '2025-12-21 10:04:18'),
(14, 1, 'booking', 'Đặt phòng thành công', 'Booking #49 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 0, '{\"booking_id\": 49}', '2025-11-26 23:58:40', '2025-11-26 23:58:40'),
(15, 8, 'booking', 'Đặt phòng thành công', 'Booking #50 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 50}', '2025-11-27 00:25:51', '2025-11-27 00:26:56'),
(16, 8, 'payment', 'Thanh toán thành công', 'Booking #50 đã thanh toán thành công: 1.800.000 VND', 1, NULL, '2025-11-27 00:26:39', '2025-11-27 00:27:03'),
(17, 8, 'booking', 'Đặt phòng thành công', 'Booking #51 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 51}', '2025-11-27 00:58:05', '2025-12-21 10:04:18'),
(18, 8, 'payment', 'Thanh toán thành công', 'Booking #51 đã thanh toán thành công: 1.800.000 VND', 1, NULL, '2025-11-27 00:58:46', '2025-12-21 10:04:18'),
(19, 8, 'booking', 'Đặt phòng thành công', 'Booking #52 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 52}', '2025-11-28 00:03:18', '2025-11-28 00:03:52'),
(20, 8, 'booking', 'Đặt phòng thành công', 'Booking #53 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 53}', '2025-11-29 00:43:50', '2025-12-21 10:04:18'),
(21, 8, 'booking', 'Đặt phòng thành công', 'Booking #54 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 54}', '2025-11-30 06:20:00', '2025-11-30 06:34:38'),
(22, 8, 'payment', 'Thanh toán thành công', 'Booking #54 đã thanh toán thành công: 1.800.000 VND', 1, NULL, '2025-11-30 06:27:59', '2025-12-21 10:04:18'),
(23, 9, 'Registration_Successful', 'Đăng ký thành công', 'Chào mừng tranvi aa đã đăng ký thành công tài khoản.', 0, NULL, '2025-11-30 10:54:28', '2025-11-30 10:54:28'),
(24, 8, 'booking', 'Đặt phòng thành công', 'Booking #55 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 55}', '2025-11-30 11:22:25', '2025-12-21 10:04:18'),
(25, 8, 'payment', 'Thanh toán thành công', 'Booking #55 đã thanh toán thành công: 1.800.000 VND', 1, NULL, '2025-11-30 11:24:20', '2025-11-30 11:25:55'),
(28, 8, 'booking', 'Hủy phòng thành công', 'Booking #55 của bạn đã được hủy thành công. Phí hủy: 1.800.000 VND. Số tiền hoàn lại: 0 VND.', 1, '{\"booking_id\": 55}', '2025-11-30 20:00:54', '2025-12-21 10:04:18'),
(29, 1, 'booking', 'Đặt phòng thành công', 'Booking #56 của bạn đã được đặt thành công với tổng giá 3.724.000 VND.', 0, '{\"booking_id\": 56}', '2025-12-01 08:10:53', '2025-12-01 08:10:53'),
(30, 1, 'payment', 'Thanh toán thành công', 'Booking #56 đã thanh toán thành công: 3.724.000 VND', 0, NULL, '2025-12-01 08:12:20', '2025-12-01 08:12:20'),
(31, 1, 'booking', 'Đặt phòng thành công', 'Booking #57 của bạn đã được đặt thành công với tổng giá 4.500.000 VND.', 0, '{\"booking_id\": 57}', '2025-12-01 08:13:09', '2025-12-01 08:13:09'),
(32, 1, 'payment', 'Thanh toán thành công', 'Booking #57 đã thanh toán thành công: 4.500.000 VND', 0, NULL, '2025-12-01 08:13:54', '2025-12-01 08:13:54'),
(33, 1, 'booking', 'Đặt phòng thành công', 'Booking #58 của bạn đã được đặt thành công với tổng giá 1.462.050 VND.', 0, '{\"booking_id\": 58}', '2025-12-02 01:35:52', '2025-12-02 01:35:52'),
(34, 1, 'booking', 'Đặt phòng thành công', 'Booking #59 của bạn đã được đặt thành công với tổng giá 2.000.000 VND.', 0, '{\"booking_id\": 59}', '2025-12-02 02:14:34', '2025-12-02 02:14:34'),
(35, 8, 'booking', 'Đặt phòng thành công', 'Booking #60 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 60}', '2025-12-03 04:54:21', '2025-12-21 10:04:18'),
(36, 8, 'payment', 'Thanh toán thành công', 'Booking #60 đã thanh toán thành công: 1.800.000 VND', 1, NULL, '2025-12-03 04:55:47', '2025-12-21 10:04:18'),
(37, 1, 'booking', 'Đặt phòng thành công', 'Booking #61 của bạn đã được đặt thành công.', 0, '{\"booking_id\": 61}', '2025-12-06 09:39:05', '2025-12-06 09:39:05'),
(38, 1, 'booking', 'Đặt phòng thành công', 'Booking #62 của bạn đã được đặt thành công.', 0, '{\"booking_id\": 62}', '2025-12-06 09:42:30', '2025-12-06 09:42:30'),
(39, 8, 'booking', 'Đặt phòng thành công', 'Booking #63 của bạn đã được đặt thành công.', 1, '{\"booking_id\": 63}', '2025-12-06 09:45:39', '2025-12-21 10:04:18'),
(40, 8, 'booking', 'Đặt phòng thành công', 'Booking #64 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 64}', '2025-12-06 11:15:34', '2025-12-21 10:04:18'),
(41, 8, 'booking', 'Đặt phòng thành công', 'Booking #65 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 65}', '2025-12-06 11:27:13', '2025-12-21 10:04:18'),
(42, 8, 'booking', 'Đặt phòng thành công', 'Booking #66 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 66}', '2025-12-06 11:32:51', '2025-12-21 10:04:18'),
(43, 8, 'booking', 'Đặt phòng thành công', 'Booking #67 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 67}', '2025-12-06 11:42:54', '2025-12-21 10:04:18'),
(44, 8, 'booking', 'Đặt phòng thành công', 'Booking #68 của bạn đã được đặt thành công với tổng giá 2.000.000 VND.', 1, '{\"booking_id\": 68}', '2025-12-07 08:20:02', '2025-12-21 10:04:18'),
(45, 8, 'payment', 'Thanh toán thành công', 'Booking #68 đã thanh toán thành công: 2.000.000 VND', 1, NULL, '2025-12-07 08:29:53', '2025-12-21 10:04:18'),
(46, 8, 'booking', 'Đặt phòng thành công', 'Booking #69 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 69}', '2025-12-08 00:38:28', '2025-12-21 10:04:18'),
(47, 8, 'payment', 'Thanh toán thành công', 'Booking #69 đã thanh toán thành công: 1.800.000 VND', 1, NULL, '2025-12-08 00:40:52', '2025-12-21 10:04:18'),
(48, 8, 'booking', 'Đặt phòng thành công', 'Booking #70 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 70}', '2025-12-08 01:00:52', '2025-12-21 10:04:18'),
(49, 8, 'booking', 'Đặt phòng thành công', 'Booking #71 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 71}', '2025-12-08 08:32:16', '2025-12-21 10:04:18'),
(50, 8, 'booking', 'Đặt phòng thành công', 'Booking #72 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 72}', '2025-12-08 08:35:44', '2025-12-21 10:04:18'),
(51, 8, 'booking', 'Đặt phòng thành công', 'Booking #73 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 73}', '2025-12-08 09:16:36', '2025-12-21 10:04:18'),
(52, 8, 'booking', 'Đặt phòng thành công', 'Booking #74 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 74}', '2025-12-09 01:04:31', '2025-12-21 10:04:18'),
(53, 8, 'payment', 'Thanh toán thành công', 'Booking #74 đã thanh toán thành công: 1.800.000 VND', 1, NULL, '2025-12-09 01:07:40', '2025-12-21 10:04:18'),
(54, 8, 'booking', 'Đặt phòng thành công', 'Booking #75 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 75}', '2025-12-12 20:20:26', '2025-12-21 10:04:18'),
(55, 8, 'booking', 'Đặt phòng thành công', 'Booking #76 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 76}', '2025-12-12 20:43:07', '2025-12-12 20:56:37'),
(56, 8, 'booking', 'Đặt phòng thành công', 'Booking #77 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 77}', '2025-12-12 20:45:42', '2025-12-21 10:04:18'),
(57, 8, 'booking', 'Đặt phòng thành công', 'Booking #78 của bạn đã được đặt thành công với tổng giá 1.200.000 VND.', 1, '{\"booking_id\": 78}', '2025-12-12 20:53:47', '2025-12-21 10:04:18'),
(58, 8, 'payment', 'Thanh toán thành công', 'Booking #76 đã thanh toán thành công: 1.800.000 VND', 1, NULL, '2025-12-12 20:58:24', '2025-12-21 10:04:18'),
(59, 8, 'booking', 'Đặt phòng thành công', 'Booking #79 của bạn đã được đặt thành công với tổng giá 1.200.000 VND.', 1, '{\"booking_id\": 79}', '2025-12-12 21:05:45', '2025-12-21 10:04:18'),
(60, 8, 'payment', 'Thanh toán thành công', 'Booking #79 đã thanh toán thành công: 1.200.000 VND', 1, NULL, '2025-12-12 21:07:57', '2025-12-21 10:04:18'),
(61, 8, 'booking', 'Đặt phòng thành công', 'Booking #80 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 80}', '2025-12-12 21:51:55', '2025-12-21 10:04:18'),
(62, 8, 'booking', 'Đặt phòng thành công', 'Booking #81 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 81}', '2025-12-12 22:05:05', '2025-12-21 10:04:18'),
(63, 8, 'booking', 'Đặt phòng thành công', 'Booking #82 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 82}', '2025-12-14 08:22:21', '2025-12-21 10:04:18'),
(64, 8, 'booking', 'Đặt phòng thành công', 'Booking #83 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 83}', '2025-12-14 09:00:28', '2025-12-21 10:04:18'),
(65, 3, 'booking', 'Đặt phòng thành công', 'Booking #84 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 0, '{\"booking_id\": 84}', '2025-12-14 09:00:34', '2025-12-14 09:00:34'),
(66, 8, 'booking', 'Đặt phòng thành công', 'Booking #85 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 1, '{\"booking_id\": 85}', '2025-12-14 10:50:29', '2025-12-21 10:04:18'),
(67, 10, 'Registration_Successful', 'Đăng ký thành công', 'Chào mừng tranvi aa đã đăng ký thành công tài khoản.', 0, NULL, '2025-12-16 08:22:38', '2025-12-16 08:22:38'),
(68, 3, 'booking', 'Đặt phòng thành công', 'Booking #86 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 0, '{\"booking_id\": 86}', '2025-12-18 07:36:48', '2025-12-18 07:36:48'),
(69, 3, 'booking', 'Đặt phòng thành công', 'Booking #87 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 0, '{\"booking_id\": 87}', '2025-12-18 08:14:09', '2025-12-18 08:14:09'),
(70, 3, 'booking', 'Đặt phòng thành công', 'Booking #88 của bạn đã được đặt thành công với tổng giá 1.800.000 VND.', 0, '{\"booking_id\": 88}', '2025-12-18 11:06:41', '2025-12-18 11:06:41'),
(71, 8, 'booking', 'Đặt phòng thành công', 'Booking #89 của bạn đã được đặt thành công với tổng giá 2.000.000 VND.', 1, '{\"booking_id\": 89}', '2025-12-18 20:25:48', '2025-12-21 10:04:18'),
(72, 8, 'payment', 'Thanh toán thành công', 'Booking #89 đã thanh toán thành công: 2.000.000 VND', 1, NULL, '2025-12-18 20:27:58', '2025-12-21 10:04:18'),
(73, 8, 'booking', 'Đặt phòng thành công', 'Booking #90 của bạn đã được đặt thành công với tổng giá 4.500.000 VND.', 1, '{\"booking_id\": 90}', '2025-12-21 07:16:53', '2025-12-21 10:04:18'),
(74, 8, 'cancel_booking', 'Hủy phòng thành công', 'Booking #90 của bạn đã được hủy thành công. Phí hủy: 4.500.000 VND. Số tiền hoàn lại: 0 VND.', 1, '{\"booking_id\": 90}', '2025-12-21 07:33:15', '2025-12-21 10:04:18'),
(75, 8, 'booking', 'Đặt phòng thành công', 'Booking #91 của bạn đã được đặt thành công với tổng giá 7.500.000 VND.', 1, '{\"booking_id\": 91}', '2025-12-21 10:16:48', '2025-12-21 10:18:24'),
(76, 11, 'booking', 'Đặt phòng thành công', 'Booking #92 của bạn đã được đặt thành công với tổng giá 2.500.000 VND.', 0, '{\"booking_id\": 92}', '2025-12-21 18:58:13', '2025-12-21 18:58:13'),
(77, 11, 'booking', 'Đặt phòng thành công', 'Booking #93 của bạn đã được đặt thành công với tổng giá 5.000.000 VND.', 0, '{\"booking_id\": 93}', '2025-12-21 20:33:59', '2025-12-21 20:33:59'),
(78, 11, 'payment', 'Thanh toán thành công', 'Booking #93 đã thanh toán thành công: 5.000.000 VND', 0, NULL, '2025-12-21 20:35:38', '2025-12-21 20:35:38'),
(79, 12, 'Registration_Successful', 'Đăng ký thành công', 'Chào mừng tranvi aa đã đăng ký thành công tài khoản.', 0, NULL, '2026-02-19 06:19:20', '2026-02-19 06:19:20');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('01187fc86ba795975a7add71b8c26d775acb325bdd6894e80898bf441778674416384a4c3d3aeb54', 1, 1, 'Personal Access Token', '[]', 0, '2025-10-21 02:28:07', '2025-10-21 02:28:07', '2026-04-21 09:28:07'),
('01e7f3100391b5e19c05bab07d46e35955c29b01928aec50c9c743b1cc867766e31cccc0f540567d', 8, 1, 'GoogleToken', '[]', 0, '2025-12-02 09:02:04', '2025-12-02 09:02:04', '2026-06-02 16:02:04'),
('023cf8467ac1b373bd3546683a32cf3c726817b3261afc7ca3f3b08b5fa3cbff91d112b2dc328836', 8, 1, 'GoogleToken', '[]', 0, '2025-11-17 00:34:45', '2025-11-17 00:34:45', '2026-05-17 07:34:45'),
('02f1e41fefa626c02faa38ff050068c62fa4fa8421accb69c6f0077381297c0724320d0bfbb26746', 8, 1, 'GoogleToken', '[]', 0, '2025-11-11 00:35:27', '2025-11-11 00:35:27', '2026-05-11 07:35:27'),
('0350b4116cbcaa322ccb64614e0a3729f5677f3e2b6e9d2ce70a976d8876d56f0163d3f237bb4b0c', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-02 09:29:04', '2025-12-02 09:29:04', '2026-06-02 16:29:04'),
('0378df227635df9bd3f6449fd06bfb7e9acbb27f77754e5e0a3d75af1540a3d5c8f83bcfca423fee', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-30 20:59:10', '2025-11-30 20:59:10', '2026-06-01 03:59:10'),
('038e24ad120f7b001ca1e3ab240573fe525e938f8ad907726c7be57484752e0aff7fd785fae95ec7', 8, 1, 'GoogleToken', '[]', 0, '2025-12-02 10:05:26', '2025-12-02 10:05:26', '2026-06-02 17:05:26'),
('0552ce95cc168c57e488c24ab8a40429b64df5541ad7dfca123ec0b723c358e20cb0d50974ce6b9d', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-17 00:28:20', '2025-11-17 00:28:20', '2026-05-17 07:28:20'),
('05adeefe90489fe7968ebe40e530a7a2e3afa27c7f4bb1f8088c76ed18664c2f72a65a3d1692dae7', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-26 10:26:51', '2025-11-26 10:26:51', '2026-05-26 17:26:51'),
('070edf9b0e178742335b102ccb9f28058d71da81f1a885870b6a62ed273952d3dda60d48445dd6be', 12, 1, 'Personal Access Token', '[]', 0, '2026-02-19 06:20:37', '2026-02-19 06:20:37', '2026-08-19 13:20:37'),
('075313f0be8ca7e980b74865587fecef8f01e62eeac259119b8b38cb68877b9a932c28f1f9f307ea', 1, 1, 'Personal Access Token', '[]', 0, '2025-10-09 16:57:33', '2025-10-09 16:57:33', '2026-04-09 23:57:33'),
('077e013a37ca9022c9e554ea233e3cd25a2b6d4b33fa27976a175b096b2abc8723d1bcdc49972875', 8, 1, 'GoogleToken', '[]', 0, '2025-10-30 00:32:40', '2025-10-30 00:32:40', '2026-04-30 07:32:40'),
('07bca6bb893e5b36d80eee72654eccf76ae53c6f547a8b4e777f149b6c6e1797c2efc7f2fbacbcde', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-09 00:11:31', '2025-12-09 00:11:31', '2026-06-09 07:11:31'),
('085caedd5fe4d50d71594e30d324cf5990ca0ac47a7821878e9eaa2140ebd6d776138983483b34a4', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-02 18:42:02', '2025-12-02 18:42:02', '2026-06-03 01:42:02'),
('09c3134272075783ef59eafbd511728dd3083951fba1187094c608a6f57b60acebffc668a784e04b', 8, 1, 'GoogleToken', '[]', 0, '2025-12-02 10:22:23', '2025-12-02 10:22:23', '2026-06-02 17:22:23'),
('0c4b7e3ba5c2274073e516aaa8a761df2f4243b19f6260cc1d17c05f54a2677601cf0a2a3238db74', 8, 1, 'GoogleToken', '[]', 0, '2025-11-18 06:35:18', '2025-11-18 06:35:18', '2026-05-18 13:35:18'),
('10cd31596ddf70e5989212905da055d20a66b7dfeb92036a0f4f08ed5eb640984fddabbd31058f8b', 3, 1, 'Personal Access Token', '[]', 0, '2025-12-20 12:01:58', '2025-12-20 12:01:58', '2026-06-20 19:01:58'),
('10d3020febf5f5364924eb2405ece9927234204357a459a9a1c25cbc9b008d63cadad7cabe15142b', 8, 1, 'GoogleToken', '[]', 0, '2025-11-03 07:26:29', '2025-11-03 07:26:29', '2026-05-03 14:26:29'),
('11d4fa11c21a281ddfc8eca5bf7de7fd8857962150ee56b5853f8b286e4c2b0d7161eb3e9a65886d', 8, 1, 'GoogleToken', '[]', 0, '2025-11-04 03:39:06', '2025-11-04 03:39:06', '2026-05-04 10:39:06'),
('120733f1c9a50fe73f280ca64e95cc48b01d722a9454c6bb0c7888a54e0b9b6b2ee204a6b095c71b', 8, 1, 'GoogleToken', '[]', 0, '2025-11-27 00:05:10', '2025-11-27 00:05:10', '2026-05-27 07:05:10'),
('1336e468b4c0f0bdec2131c8e3191d6407ef2dbd8bc41ff2c14cdd8c373159cf9f568d2348e15a49', 1, 1, 'GoogleToken', '[]', 0, '2026-02-13 22:13:25', '2026-02-13 22:13:25', '2026-08-14 05:13:25'),
('15098c5b65d5df57bf258a0649d0530bc355c50aadd043f33247ecc64f7edd528356b7f6a6f8d37d', 9, 1, 'Personal Access Token', '[]', 0, '2025-12-02 07:46:44', '2025-12-02 07:46:44', '2026-06-02 14:46:44'),
('16deda149d5aeda6e0d9b03f8e93f6497cd27e43a4080b68f99614ea2d1d33a024501d8062c573de', 3, 1, 'Personal Access Token', '[]', 0, '2025-12-14 08:56:56', '2025-12-14 08:56:56', '2026-06-14 15:56:56'),
('1736ef5780960ee3323804420087e715c632f44849ded0953c209c8f7af2302ef37149eaca951b78', 8, 1, 'GoogleToken', '[]', 0, '2025-11-30 10:52:05', '2025-11-30 10:52:05', '2026-05-30 17:52:05'),
('17b1151867ea8a6ffbd506dcbd03fd79868c84c22214629c9b0e84d88b2b136b4cac780102d37e19', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-02 08:57:42', '2025-12-02 08:57:42', '2026-06-02 15:57:42'),
('18bb1b3d81b5d3de94a1393b7b9b07bb64bd599615396e66c802bb136a035cd62805c00c09e24d53', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-26 09:48:52', '2025-11-26 09:48:53', '2026-05-26 16:48:52'),
('1a00e5d18e96393a35592a01a11d78c81e5bd3e8c2b1dde2a55f6348a8560b1d4b9121172bcfbe07', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-27 00:16:58', '2025-11-27 00:16:58', '2026-05-27 07:16:58'),
('1a05591b525f6741967844e33741db4688dcbae177a3bd39950cf6a68df623b617b5b59f39ef96a6', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-12 22:25:42', '2025-12-12 22:25:42', '2026-06-13 05:25:42'),
('1b13ee9b6ac993675e37be1c6b0843fc9a656cf91c13fca06584ee5a19c287e1c117eab9baa53f31', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-02 08:32:09', '2025-12-02 08:32:09', '2026-06-02 15:32:09'),
('1da3ba181b07387f3e576da25e58dbccadb5c8f4c66a58879d94c82cc801e01ff60b9d7f4e3d5125', 8, 1, 'GoogleToken', '[]', 0, '2025-11-30 10:56:38', '2025-11-30 10:56:38', '2026-05-30 17:56:38'),
('1de567f8cd94b4116680bb9b11293746d22e90596ff37dddbfd1c5cd00fba432262f7b2efa454d2e', 2, 1, 'Personal Access Token', '[]', 0, '2025-10-09 16:39:17', '2025-10-09 16:39:17', '2026-04-09 23:39:17'),
('20d09ef7856d9c25b9c0bdded1c73b12b5989d3e46a97db4613e32430693e8930ebd1338a72130d2', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-02 01:24:23', '2025-12-02 01:24:23', '2026-06-02 08:24:23'),
('22c16860b8640c58472353c4e096ddc037c6bdfa239068074ad4cb44bc5c3dfb290b9739b97d3822', 4, 1, 'Personal Access Token', '[]', 0, '2025-10-09 21:11:54', '2025-10-09 21:11:54', '2026-04-10 04:11:54'),
('22d138e7a75945c8590395627012b676274a10df5865946c8397e1c51f97001a11eda0e30842e6db', 8, 1, 'GoogleToken', '[]', 0, '2025-11-04 03:44:07', '2025-11-04 03:44:08', '2026-05-04 10:44:07'),
('2355ada12deaef00b42503410b368a78fae91bf38d8b6e2dea78708a84117323a2875a89c6351c59', 3, 1, 'Personal Access Token', '[]', 0, '2025-12-18 06:26:24', '2025-12-18 06:26:24', '2026-06-18 13:26:24'),
('2473d97b27b470f0e0cd16c58b4bd8d90fa56f6f874810768ad4fd0afe4919820ff5ce12a96cfb50', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-02 09:17:39', '2025-12-02 09:17:39', '2026-06-02 16:17:39'),
('24fb71e7f6fb1ea669d93c488bc4e88a9e6986d9989ef6aeb041f27294738209b102d8b94b2c881c', 8, 1, 'GoogleToken', '[]', 0, '2025-11-17 01:00:15', '2025-11-17 01:00:15', '2026-05-17 08:00:15'),
('250744759197f3477294288201554a656636fa10ebef2311dbb637ba18418d8d612c05cf0cf1c67b', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-30 08:51:30', '2025-11-30 08:51:30', '2026-05-30 15:51:30'),
('2628ccff0bf3bc2e804abc82cbda76c3aa312a2b2f19863ea80616ed2ce0b8cfc10f2c29d22a5d30', 12, 1, 'Personal Access Token', '[]', 0, '2026-02-19 22:04:08', '2026-02-19 22:04:08', '2026-08-20 05:04:08'),
('27808b4dff6b27770d84a8a044d2174ba8cf2944d5960fa24a7537594aa2f2586632d41be9be45bd', 8, 1, 'GoogleToken', '[]', 0, '2025-11-03 19:09:46', '2025-11-03 19:09:46', '2026-05-04 02:09:46'),
('27845753b090151517d05ee2f3fcec26687e6849553566050cf1cf0c14f42b53e5bfe043523c9891', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-30 21:35:57', '2025-11-30 21:35:57', '2026-06-01 04:35:57'),
('27b7c28e1a62a13a3684aea6090da91f6a11e3c9d801b60d8550a8e409dc7dae95481d2a7dee7e02', 8, 1, 'GoogleToken', '[]', 0, '2025-11-30 19:48:33', '2025-11-30 19:48:33', '2026-06-01 02:48:33'),
('296e7e78129947e418a261f171f3421178765c59cc575babbcbd51cf6144ce9a89ef229fa3215c08', 8, 1, 'GoogleToken', '[]', 0, '2025-12-06 09:06:55', '2025-12-06 09:06:55', '2026-06-06 16:06:55'),
('29826130e8aeddc5955a9b65172130a688a4ad4588c40323cc0b5e51a9cf3e29347b93eeb18664b0', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-05 01:31:19', '2025-12-05 01:31:19', '2026-06-05 08:31:19'),
('2ad5c3e0f4dfd226b6d1efb7da79fca924d6a0ad0d6c9c8b5368e3792b2bf9ff85353bdb65b738ba', 3, 1, 'Personal Access Token', '[]', 0, '2025-12-20 11:41:46', '2025-12-20 11:41:47', '2026-06-20 18:41:46'),
('2d61185eee0efb4a68ebf16a8934ca761251a4091b60b0110ef8340f647ac5b2c850a5e29931179f', 8, 1, 'GoogleToken', '[]', 0, '2025-10-30 00:31:23', '2025-10-30 00:31:23', '2026-04-30 07:31:23'),
('2d712d251b92b56368c3eb4f87e88c70df7c63d9c441cdecb7aab410b5b1fc9a002b95e30e593ad8', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-26 09:02:14', '2025-11-26 09:02:15', '2026-05-26 16:02:14'),
('36598c18811d0a3a4e9c093078212de7d06053041a67602b9b12217addc56f3b61b74d91d97c61a7', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-15 17:04:22', '2025-12-15 17:04:22', '2026-06-16 00:04:22'),
('3954e11ed36bf3c83ec7a3f5a626892ad4b15a4384cedca4958a2d0f4db96d6db5b4780acdda9bf5', 3, 1, 'Personal Access Token', '[]', 0, '2025-12-18 06:27:19', '2025-12-18 06:27:19', '2026-06-18 13:27:19'),
('395725a6bb41db26284e68b13ba0912e1436ee0f32eed5ef4c3d952debfcc14ce70dbdcddd35f2bf', 8, 1, 'GoogleToken', '[]', 0, '2025-11-06 19:03:37', '2025-11-06 19:03:37', '2026-05-07 02:03:37'),
('3b203f0da6bbf38c8be369977ddbe8ecf0dcd357f73ab0c1eed70afcfec08a6311242f18ced4c587', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-18 20:47:35', '2025-12-18 20:47:35', '2026-06-19 03:47:35'),
('3d1d4d4eb8d6403395c8b5ea6b4c15f1c82cb721e140a1a8125a1e804312758293d1dc1a69fb4e4d', 8, 1, 'GoogleToken', '[]', 0, '2025-11-17 01:00:32', '2025-11-17 01:00:32', '2026-05-17 08:00:32'),
('3eedaeb4d0608a3401c63bcc283eed807a04084b6546e10ba9654d2e329f0abc63d7c784bb3a635e', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-24 00:15:36', '2025-11-24 00:15:36', '2026-05-24 07:15:36'),
('3f7dc921704dbff5fe510f730aeafa541e3db79e306229e4c0ea22742acb94ff5d0b4a3598e44a69', 3, 1, 'Personal Access Token', '[]', 0, '2025-12-20 11:35:27', '2025-12-20 11:35:27', '2026-06-20 18:35:27'),
('41071e0eb5f2e681ad00a2eb1fd216894a2f670fd101f456202ba0967e2bf4ae893cd13459072c73', 1, 1, 'Personal Access Token', '[]', 0, '2025-10-09 17:02:05', '2025-10-09 17:02:05', '2026-04-10 00:02:05'),
('423be759f70193a91bb3008c9232db218278ec898c31de688d5536d099e82df4f1961de5a9943afb', 8, 1, 'GoogleToken', '[]', 0, '2025-12-03 04:44:42', '2025-12-03 04:44:42', '2026-06-03 11:44:42'),
('442b42af22672e557cec00ccbc8b63421630f7b24d4431ea30569936d7fab8653a4e73ace8c00cb6', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-02 08:31:03', '2025-12-02 08:31:03', '2026-06-02 15:31:03'),
('449cc1f3368ad9ff471d68dfe2d58073e5ae927b1024336b16e1b357b4517ff6bdcb9cf87e3facb0', 8, 1, 'GoogleToken', '[]', 0, '2025-11-27 00:19:17', '2025-11-27 00:19:17', '2026-05-27 07:19:17'),
('4756346b46ba5663b117be1aef323b01ba241eda8e5c817ff857b29207cf8a723115fbecfb4aa02d', 3, 1, 'Personal Access Token', '[]', 0, '2025-12-20 11:33:30', '2025-12-20 11:33:30', '2026-06-20 18:33:30'),
('4b66081bf5c87f3d4e59edc20be400cf94e5218de4945851edc7ddb9fcd863267ba966b35f4823a2', 3, 1, 'Personal Access Token', '[]', 0, '2025-12-20 11:42:49', '2025-12-20 11:42:49', '2026-06-20 18:42:49'),
('4d3db6a8f894434c3ff5c3d090a7eb60c6690064eb6861dfba9dfa1ffd3ca998698584af2aebd46c', 8, 1, 'GoogleToken', '[]', 0, '2025-12-02 10:32:33', '2025-12-02 10:32:33', '2026-06-02 17:32:33'),
('4e77fa70223fbdd948243d504a47aa75af2c08be8ef53d15c4ee9fbfb052b165ca5cc640ad4c281a', 1, 1, 'Personal Access Token', '[]', 0, '2025-10-09 18:42:55', '2025-10-09 18:42:55', '2026-04-10 01:42:55'),
('4eee7946db096f3f29b5b44e75e72270d0eaf975945027403b0851b1348ad32c14cfad2bf6566e32', 8, 1, 'GoogleToken', '[]', 0, '2025-12-07 06:07:55', '2025-12-07 06:07:55', '2026-06-07 13:07:55'),
('4f572bffc72b542c2e1c388a8ec9a074a1fbd411cc8ecd26874a52dfa4022a013dbcf56e06ab8145', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-04 00:13:23', '2025-12-04 00:13:24', '2026-06-04 07:13:23'),
('5018842e1c035e250cd9c469e512002ec5d048d169895a2f3d4302f70529d8dd8de1f2d8dd76897b', 4, 1, 'Personal Access Token', '[]', 0, '2025-10-09 21:17:08', '2025-10-09 21:17:08', '2026-04-10 04:17:08'),
('50cc23a03e077dc2c7763ccd0ec8dbaded014e78632d44c5e2d38cbf68fcc32e9595769c59501fc3', 8, 1, 'GoogleToken', '[]', 0, '2025-11-04 03:40:46', '2025-11-04 03:40:46', '2026-05-04 10:40:46'),
('512be076b126a9041c79cadb72c0bbcfdb80205654f36456eb03d573171d80ff6ce2278eb7037066', 8, 1, 'GoogleToken', '[]', 0, '2025-12-02 19:02:10', '2025-12-02 19:02:10', '2026-06-03 02:02:10'),
('55ca0d6520bf3a1f2393dcf43852dc0bfd65e6a3a1759a29bcb2b2c4b5e687e6c2ebf25fa0a63510', 8, 1, 'GoogleToken', '[]', 0, '2025-10-30 00:27:46', '2025-10-30 00:27:46', '2026-04-30 07:27:46'),
('5904c72a068a38ca654f8ee1703134b7150d19e4917370817215121db643fdf929c14447162d309e', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-18 20:46:40', '2025-12-18 20:46:40', '2026-06-19 03:46:40'),
('598e8be0cb5baf414e3b1fc7079e27fda1b170270efbc80e3cc9f0f2bed94de96381e13f83d7442d', 8, 1, 'GoogleToken', '[]', 0, '2025-11-25 00:38:32', '2025-11-25 00:38:32', '2026-05-25 07:38:32'),
('59d0a59d83b319dd390bc3c599df40d2361422e424e4267819dc8ca5f30a52ffd65035b80c168bee', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-21 18:54:22', '2025-12-21 18:54:22', '2026-06-22 01:54:22'),
('5a5b68f970591c1048abd430a5c0ebff9c14aa873221c6e8a9cdfde532d5621aeea7e6424f0ced51', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-27 00:16:57', '2025-11-27 00:16:57', '2026-05-27 07:16:57'),
('5fd79334c17b6fc6ede40c872734a4204f8121ea267c2b1ae79fd34ce2c5e3359d85ffe63cf7b69f', 1, 1, 'Personal Access Token', '[]', 0, '2025-10-09 16:35:42', '2025-10-09 16:35:42', '2026-04-09 23:35:42'),
('606b157e5d8bd934da0b74ad8f2fb9e579c8644d7d2ce6c5fa362060f6427aa4f48d28b90e689e0a', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-30 10:50:39', '2025-11-30 10:50:39', '2026-05-30 17:50:39'),
('615c742121984a674968afd063a30d0a42882d27f00b0b35e3acc628d94289381fb2f239937bd507', 8, 1, 'GoogleToken', '[]', 0, '2025-12-02 00:13:11', '2025-12-02 00:13:11', '2026-06-02 07:13:11'),
('61da3d9af57665b451af57634ef25a209b3a162c7f52479e4d26364ef99c64eda38a62314a4ad8ba', 1, 1, 'GoogleToken', '[]', 0, '2025-12-02 11:04:51', '2025-12-02 11:04:51', '2026-06-02 18:04:51'),
('644f1e505f1c8227b51bf5cd2da35a44ca8208a5476afef9172cf164efa3dfba88cc456e39148d1c', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-02 09:31:07', '2025-12-02 09:31:07', '2026-06-02 16:31:07'),
('64a9dc90db2fec954d716f527a004c9eb5b3f2f184a68c77226c4fc8510bb812346a53def861f4a1', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-02 08:00:06', '2025-12-02 08:00:06', '2026-06-02 15:00:06'),
('655494ff8dc2dce2ca6a32bcb36814bbd57f250c7dbf2d40b1db8e09da02f012eb4acded3f04482e', 8, 1, 'GoogleToken', '[]', 0, '2025-12-02 10:40:35', '2025-12-02 10:40:35', '2026-06-02 17:40:35'),
('6604c00df5517ae903799abc43586e4853cfddefc889ccd72a98d31852a313a2d1f85b25ce724f51', 8, 1, 'GoogleToken', '[]', 0, '2025-11-06 02:28:32', '2025-11-06 02:28:32', '2026-05-06 09:28:32'),
('66588c6060e3056d561cd54377738527036cb500d2ec894346eea775e4a3df0d1c07c39933bca467', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-07 09:28:47', '2025-12-07 09:28:47', '2026-06-07 16:28:47'),
('67cb97605d83eb7cc603290b882b7f3a7b8b0b0139388995fcb660a06d900d309c49b100b36a8044', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-27 00:00:56', '2025-11-27 00:00:56', '2026-05-27 07:00:56'),
('68ac7cb67656f7ef51fbe58ec015a12695f1efab56ae90654953bedf1da102b3f2b08384c5276ab5', 8, 1, 'Personal Access Token', '[]', 0, '2025-10-29 23:56:21', '2025-10-29 23:56:21', '2026-04-30 06:56:21'),
('6d489ecd6116bb42a3e6d63e51fe3a81cf5de4550a4f33e900d1e1d4ee49b79c05d592bc00282203', 8, 1, 'GoogleToken', '[]', 0, '2025-12-09 01:37:43', '2025-12-09 01:37:43', '2026-06-09 08:37:43'),
('6f4fd52bbbb1025d01933fe92a20f965c3a4fcf39121ecbd0f3c0e8d011c687426eec8d5e996cecc', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-02 07:50:44', '2025-12-02 07:50:44', '2026-06-02 14:50:44'),
('6f8f83fd535d9dfe127175fc4f97b8e2fcb3095078544af996206adcc16591b50029b1b0d8599df7', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-30 10:52:37', '2025-11-30 10:52:37', '2026-05-30 17:52:37'),
('6fa53f3bf36cd51ef067ebfd7099a3ffa08f7419a512833de98416dc17ce9d2a38622416a68f7b50', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-06 09:06:28', '2025-12-06 09:06:28', '2026-06-06 16:06:28'),
('7112636785be474ea51a9fdcba4f48140b21baf3ea69149f60d00a9e56ae7471ea757aa1addd9a68', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-02 09:30:03', '2025-12-02 09:30:03', '2026-06-02 16:30:03'),
('72ab2ea16bbb926115609ce3282fb091298b469f0a3b9e501902160a38a06395bf7a47cfae9eab42', 8, 1, 'GoogleToken', '[]', 0, '2025-11-04 18:56:23', '2025-11-04 18:56:23', '2026-05-05 01:56:23'),
('72f3597deefb3768f2c45d8bb20049b8a5fe538f222679296b2db480de6b3ae71e1b4305e241e0ae', 8, 1, 'GoogleToken', '[]', 0, '2025-12-02 08:31:51', '2025-12-02 08:31:51', '2026-06-02 15:31:51'),
('736715437673060383498f14578ddcf0154e499eb41845e6bd6da16ebc29750d318bf9bd98c2ee2f', 8, 1, 'GoogleToken', '[]', 0, '2025-11-04 03:39:22', '2025-11-04 03:39:22', '2026-05-04 10:39:22'),
('743e153ba1ea90614c99cdde7e8c7109766fa04562873946c503c1fe34f0be429d92c4819ce19e58', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-04 11:17:38', '2025-12-04 11:17:38', '2026-06-04 18:17:38'),
('767925b41c1fcec060bf8cf5debefa13bed1910c0298f5e62a1a9ef945548f28da830328fba9f689', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-27 00:14:16', '2025-11-27 00:14:16', '2026-05-27 07:14:16'),
('76d96bb6a1cd1612c54713e364f0e0f587f9c68f62c3dcfdc11f74d1d95de38812249f5422ef93dc', 8, 1, 'GoogleToken', '[]', 0, '2025-12-02 08:25:44', '2025-12-02 08:25:44', '2026-06-02 15:25:44'),
('76eeb690391d1075b5fdd73d1a2ee6a7f36cfced744b93d1ed22226e87e32819010a98db3e730a9c', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-27 00:16:42', '2025-11-27 00:16:42', '2026-05-27 07:16:42'),
('7b5b14c10c0a65a8c72bc0a713163e837684ee2a59de5574ebdfd469bf55d93a4ff4ec40d5913b0d', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-02 09:34:28', '2025-12-02 09:34:28', '2026-06-02 16:34:28'),
('7e1fc6bd2ea832b1d7c79f04b9d33df6bb6b63a65cf18d7b2e228e46d44dfeb271926933f255f54c', 1, 1, 'Personal Access Token', '[]', 0, '2025-10-09 18:59:10', '2025-10-09 18:59:10', '2026-04-10 01:59:10'),
('8016b6422dd84f0dc5cb507bce9916b6202b04d0d462fd4991697d81ef007c06b47b1dca01e65ad5', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-17 10:09:30', '2025-12-17 10:09:30', '2026-06-17 17:09:30'),
('83ac8c7a4703338fa07024db5fcb10f966cf1616b154cdf1403cad8014aecde82bd5aa45a87a840b', 8, 1, 'GoogleToken', '[]', 0, '2025-11-09 19:53:48', '2025-11-09 19:53:48', '2026-05-10 02:53:48'),
('83ae02da306ce448358656787b2f88a2727c431909179d19476f40b732e6a725343fcc9f0e2e636d', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-27 00:07:18', '2025-11-27 00:07:18', '2026-05-27 07:07:18'),
('83c0b9210ad0ccf5e556ccf5b42d27f57b66fb25dacbf61271a44bf7d96c6d121b5f5af129867a10', 8, 1, 'GoogleToken', '[]', 0, '2025-10-30 00:31:03', '2025-10-30 00:31:03', '2026-04-30 07:31:03'),
('83dc12cbee804d24d36d0fe910fd167bf054cdd18436f85131c5e7dbde21701a21a2cb4281f08011', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-02 19:01:54', '2025-12-02 19:01:54', '2026-06-03 02:01:54'),
('8534ed4786b2e6786a5fd5423db802f4088ca47d2a10b5a8f99ef9ce23f6bef3c73711e4a6eee881', 1, 1, 'Personal Access Token', '[]', 0, '2025-10-09 16:32:55', '2025-10-09 16:32:55', '2026-04-09 23:32:55'),
('85706af7e5c67cbe59b98c614ec24d83901f50d69e7a4c2d8261cc36bcc0beb1cc4531eb58b0b2a1', 3, 1, 'Personal Access Token', '[]', 0, '2025-10-09 19:00:44', '2025-10-09 19:00:45', '2026-04-10 02:00:44'),
('8909a34447d3d667ed3270c22c2fc50a3abcdd8465069aa2173a8d9a9edd4c4b9ee2d594e8a699dd', 10, 1, 'Personal Access Token', '[]', 0, '2025-12-16 08:23:04', '2025-12-16 08:23:04', '2026-06-16 15:23:04'),
('894373931a275864af2c4c4a9b809bf7d5480876ce2759a828575fa0a5ec2abb97a95500b7973ed0', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-30 19:47:26', '2025-11-30 19:47:26', '2026-06-01 02:47:26'),
('8a7ab56bae4d98a4112b036e7499ce0231a77fe2ed36fb3e523a9a21c616f4e1f1f1fde4bcd87b56', 8, 1, 'GoogleToken', '[]', 0, '2025-11-03 19:09:05', '2025-11-03 19:09:05', '2026-05-04 02:09:05'),
('8b743f03249946bcf7cf9bc22bdd58c7de91be0739e81e402963f35833d750ed2b111186f42128a7', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-02 18:41:34', '2025-12-02 18:41:34', '2026-06-03 01:41:34'),
('8e512a9d31ac6f605db83a003c9412d570ba1eb4712da92b781b517d1504478fa8af37961658a24c', 1, 1, 'Personal Access Token', '[]', 0, '2025-10-15 20:26:33', '2025-10-15 20:26:33', '2026-04-16 03:26:33'),
('8f9aab43447a848a582c2ef62d3044255539267f1eff73abf067cbd8390af64943fd8861cd4bf2af', 1, 1, 'Personal Access Token', '[]', 0, '2025-10-28 20:19:45', '2025-10-28 20:19:46', '2026-04-29 03:19:45'),
('8fcbdcc46db284ec8376c7dfc8d15104d0cccf389e24a87e8654b14689c9e57d0a50ffcd8786e463', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-01 06:47:50', '2025-12-01 06:47:50', '2026-06-01 13:47:50'),
('9043c37da22f84e1c2d5f21686c4e9fc4e145847de3a23377c8b7b16614151ca8b7b0ca9a1e25e8f', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-21 07:19:57', '2025-12-21 07:19:57', '2026-06-21 14:19:57'),
('9058d48676b768534ebc9e8f94f783d98dfb2b1a5641919e1b6abc7d6ee337df9689977d87d98aa1', 8, 1, 'Personal Access Token', '[]', 0, '2025-10-29 09:33:33', '2025-10-29 09:33:33', '2026-04-29 16:33:33'),
('92fbc58b60a3fa38730b8b9813411e9cd2d4650669d9a63a8d0a61a6a83778e2d917714cafcb6f7d', 8, 1, 'GoogleToken', '[]', 0, '2025-12-13 00:04:18', '2025-12-13 00:04:19', '2026-06-13 07:04:18'),
('9487f5cc51b66c26ab538591b5d80d4e78a064ce002f177d0b190e2a6ba75d54f0f315f2d78b1db1', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-02 08:26:03', '2025-12-02 08:26:03', '2026-06-02 15:26:03'),
('94e12ad6474aae9b6557e86c5518fcf50bf2db3f9436385e63740338c47d3543b6a463ca8956624b', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-17 00:43:54', '2025-11-17 00:43:54', '2026-05-17 07:43:54'),
('9522fe657da76710b23ee94c57ea67153e581d00b556b2a87ce9afb443f17f2ff70a1718ebf9a0a0', 8, 1, 'GoogleToken', '[]', 0, '2025-11-04 03:25:12', '2025-11-04 03:25:12', '2026-05-04 10:25:12'),
('95424106e8fb97b21bcea43fa7e3a964a48c0df039e6bcf6774cead4be369e1874f317861f5b73e7', 8, 1, 'GoogleToken', '[]', 0, '2025-11-04 21:21:04', '2025-11-04 21:21:04', '2026-05-05 04:21:04'),
('9719476ef7f009e3ade98a8c5a3b9252c48899da48f0a30abcfc16f48e127c28ff10f320906f8a69', 9, 1, 'Personal Access Token', '[]', 0, '2025-11-30 10:54:51', '2025-11-30 10:54:51', '2026-05-30 17:54:51'),
('9734dbf46efd4ed0c9b22221f4fea29c8b8289bec234a3c017088de75aa1316d32e0fd2cd3061992', 3, 1, 'Personal Access Token', '[]', 0, '2025-12-20 11:27:14', '2025-12-20 11:27:14', '2026-06-20 18:27:14'),
('9760bbfee24c2f353f69b1156e168a50e2d487f9f15b32014ddea5e46adece887d1d9f600ec6ca4b', 8, 1, 'GoogleToken', '[]', 0, '2025-12-07 06:08:28', '2025-12-07 06:08:28', '2026-06-07 13:08:28'),
('9770af7757616a8a6f280a78f7aaed7777ca4d983ab490b07a53f2d7c1480bf2b8e144e2b7d9cf40', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-02 08:25:08', '2025-12-02 08:25:08', '2026-06-02 15:25:08'),
('983a7e3d3c0c13d6c119499c000f96f5f92e298f69f64125ad5eb762051998fc6ee37586087e633e', 3, 1, 'Personal Access Token', '[]', 0, '2025-10-09 19:07:39', '2025-10-09 19:07:39', '2026-04-10 02:07:39'),
('9f24f11cbfcffd95b5f676fa01fe177f426f887afd486fbf579f8b575af44737a0af6c614f245522', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-30 19:12:24', '2025-11-30 19:12:24', '2026-06-01 02:12:24'),
('9fa1ff0aed6831fc4cbe49d0d450622285ff33d22d0627be21089fe08aa1e6b0f223da6ce00ffd0f', 8, 1, 'GoogleToken', '[]', 0, '2025-11-04 21:07:26', '2025-11-04 21:07:26', '2026-05-05 04:07:26'),
('9fb5954acc5b7531a611fd63919c2f549ceedd271dffde4eff08ab182818278e4241a8fcb2c3473b', 1, 1, 'Personal Access Token', '[]', 0, '2025-10-15 20:54:52', '2025-10-15 20:54:52', '2026-04-16 03:54:52'),
('a04ced4affa8a5e7fd41ef4d441c72a0303b91ea160e46e9dd8a2d9a322c4b5e9b5119ba286e729d', 8, 1, 'GoogleToken', '[]', 0, '2025-11-30 20:49:47', '2025-11-30 20:49:47', '2026-06-01 03:49:47'),
('a054eb59a6bde7cf429701d7439d6484312afe41377904bbca6645990f001b6d619dfe3e45178a0b', 8, 1, 'GoogleToken', '[]', 0, '2025-11-16 09:30:05', '2025-11-16 09:30:05', '2026-05-16 16:30:05'),
('a447d33cd5b9aab7ba892d80fbf4d1f31fbb4395b91b8419b5f9d7cd9859f35c328f0515abfd0731', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-06 09:07:49', '2025-12-06 09:07:49', '2026-06-06 16:07:49'),
('a6c486503123b43b1587bacc758ff22cfd53096f17cc9bf49d8d309470f054e837f1ebc7a20e2350', 8, 1, 'GoogleToken', '[]', 0, '2025-10-30 18:42:35', '2025-10-30 18:42:35', '2026-05-01 01:42:35'),
('ab40bfaca9592b76e131ade358eb721882f27a040edc93d730630dc838183b242a95708fb2816bd0', 8, 1, 'GoogleToken', '[]', 0, '2025-11-11 11:23:03', '2025-11-11 11:23:03', '2026-05-11 18:23:03'),
('af0fe22ebd8a4aeb1f4b3c8bad6c28de5df91f9e4177917b8ab6be8c3815715b395565b672a13f11', 8, 1, 'GoogleToken', '[]', 0, '2025-11-30 05:13:01', '2025-11-30 05:13:01', '2026-05-30 12:13:01'),
('b423402d34587a78e980776587ec5534447f4fb4ebe4e24179ca653e6f9116c63b4265ac107ecc90', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-08 09:35:39', '2025-12-08 09:35:39', '2026-06-08 16:35:39'),
('b5d3f21f117ccd5c7e6c20c2c3837a5c84bdde460ec27dc60905cc70468b871d9627bf34a9e873ae', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-27 00:16:57', '2025-11-27 00:16:57', '2026-05-27 07:16:57'),
('b638aaaf770bff9ba474d8b32f1345884b10547db78c2008f44d5ad8c60b975b8f66f5c3660bd2d1', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-26 10:32:38', '2025-11-26 10:32:38', '2026-05-26 17:32:38'),
('b6b13f7f8b65f4d8e18e8ba94b9becadb3f5a945178d2337d3ac6652afe7ee45899b18611c9909c2', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-17 00:37:58', '2025-11-17 00:37:58', '2026-05-17 07:37:58'),
('b73a2558d70f9d3a49d4fc544f4f1815e5c661953e1dbe74cfe38a3b80f44df0a3afb495c70bdc08', 8, 1, 'Personal Access Token', '[]', 0, '2025-11-23 21:19:29', '2025-11-23 21:19:29', '2026-05-24 04:19:29'),
('b83af23359e41a4be664abd2937aeaf195cbbca5cebaf1354fb6e9629e2951d812f2441bc0c2ffe9', 1, 1, 'Personal Access Token', '[]', 0, '2025-10-09 16:55:26', '2025-10-09 16:55:26', '2026-04-09 23:55:26'),
('b83c2a7ff6e9cc805887cf119672a7a1cf7c0ddccd1181d0135bca653821d26c5cbd10b523aba8b8', 11, 1, 'GoogleToken', '[]', 0, '2025-12-21 18:20:18', '2025-12-21 18:20:18', '2026-06-22 01:20:18'),
('bb1e8f01da43b31fae116299b2c955dc21c05a3f31bd9a10e3e069cca055380b0c39f407057003b7', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-02 19:03:27', '2025-12-02 19:03:27', '2026-06-03 02:03:27'),
('c1a2c49405141964b6af1a8c4d1d60c8a9a419b2a90385b47b07206db4ec638d06fd663d087c3778', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-21 08:56:28', '2025-12-21 08:56:28', '2026-06-21 15:56:28'),
('c23a243b4ac60fd07ebf92e5a45a9c3c5c6b5100ec9eea03d5da56d8dcfef6b4100b08169cdbb12b', 8, 1, 'Personal Access Token', '[]', 0, '2025-11-06 02:40:12', '2025-11-06 02:40:13', '2026-05-06 09:40:12'),
('c2f1320ae05d2e9312242da0cc0cfcf1c3cf85b10cb0d4c1c056df2409f7341e7f36ca9383c0b9db', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-17 00:33:57', '2025-11-17 00:33:57', '2026-05-17 07:33:57'),
('c6bb1508b6d39e2df2506346fe45a2435ec9cd2a600f254ab6d880c2efc2a4d34c15def9661d47e6', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-02 08:20:00', '2025-12-02 08:20:00', '2026-06-02 15:20:00'),
('c7ca5c3daffdebc75be3391cdb1a07484db56fbc2493d8cc6960ef633fc867b09cbb8862826838a5', 1, 1, 'Personal Access Token', '[]', 0, '2026-02-20 20:54:00', '2026-02-20 20:54:00', '2026-08-21 03:54:00'),
('c971bbdd6443c3c0a7a282bf4350cc296d3d538768f3d8ae6907fa426efc281cfba0cf82bf7f3913', 1, 1, 'Personal Access Token', '[]', 0, '2026-01-11 07:52:14', '2026-01-11 07:52:15', '2026-07-11 14:52:14'),
('ca52f3bb7e23165ad7465773225b262dc55bef08ca20e9b8fd79084bc288d45b9a05575f732c471e', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-01 00:54:40', '2025-11-01 00:54:40', '2026-05-01 07:54:40'),
('cd09dd54997c73c648c43ee498b1c61074f78afc38cafe59a2f4aa67364e1d4d91eb188253572e64', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-06 09:17:05', '2025-12-06 09:17:05', '2026-06-06 16:17:05'),
('cdc0ef669185447e969bce68189ca5a15b11a2d4ba75bc9c4d758e6b42dbd4c7e54c295e8a17a20a', 3, 1, 'Personal Access Token', '[]', 0, '2025-12-20 11:28:30', '2025-12-20 11:28:30', '2026-06-20 18:28:30'),
('cfaf0b040f1c96bf718554f9d150713c2ca6c187a82d673c615936589abee5caa867b1fab2d6831c', 8, 1, 'GoogleToken', '[]', 0, '2025-10-30 00:37:18', '2025-10-30 00:37:18', '2026-04-30 07:37:18'),
('d16c5a7bb425a603b0b91b4c133e938c37f3aae7f59c98990dfeb71cdc1ab7734e341047d8495dea', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-27 00:19:00', '2025-11-27 00:19:00', '2026-05-27 07:19:00'),
('d2f18d929813c59c2edf2d79535b93c385a0fd87e6d120c8c81bab6ea99cd332e7e589da99965690', 8, 1, 'Personal Access Token', '[]', 0, '2025-11-04 20:02:54', '2025-11-04 20:02:54', '2026-05-05 03:02:54'),
('d425194d41ad614264be7800792fd399a971d3ca03a950eb794d55f13ba3fc7318a041c1d31198ba', 8, 1, 'GoogleToken', '[]', 0, '2025-12-21 06:51:20', '2025-12-21 06:51:21', '2026-06-21 13:51:20'),
('d463f29aebf750528f55ff985b71d2c913f3eb3fe97ab8c43efd69de7b167df78b6847f6dfbd8961', 8, 1, 'GoogleToken', '[]', 0, '2025-11-04 21:06:48', '2025-11-04 21:06:48', '2026-05-05 04:06:48'),
('d5eacd10ffac978bcdcef7653a71d3579446a0a0e8e14fa93f6196560dad2186ba96d07923e34e78', 11, 1, 'GoogleToken', '[]', 0, '2026-02-27 07:21:10', '2026-02-27 07:21:10', '2026-08-27 14:21:10'),
('d86dd1eaa982c674dee265da6ca92918346aca53dad4bf95b6522794e8115f0b708e368433b74d84', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-04 11:57:49', '2025-12-04 11:57:49', '2026-06-04 18:57:49'),
('d962ee778e7c7ffd4af41e5fdacb2ffabe57a73c18e12d61ea80a6e20f5ad478888e8097d93b98fd', 8, 1, 'GoogleToken', '[]', 0, '2025-11-30 19:14:50', '2025-11-30 19:14:50', '2026-06-01 02:14:50'),
('da51b3899035df510a3a8b8d301df02e48a880a509e892cae9dcb3f34db66360205b0b5f46f3e50e', 8, 1, 'GoogleToken', '[]', 0, '2025-10-31 00:01:50', '2025-10-31 00:01:50', '2026-05-01 07:01:50'),
('dc47b461318a21242c2ce46bba3a055d50bef7ee45a03b0fc61bf36d70442574659be4d385ac7ed6', 1, 1, 'GoogleToken', '[]', 0, '2025-11-08 10:08:16', '2025-11-08 10:08:16', '2026-05-08 17:08:16'),
('dd229cd86bc408e043fed591494961555648dd7a4a86228e1219a9ca695546ea7161c49eaf177ddb', 3, 1, 'Personal Access Token', '[]', 0, '2025-12-20 11:22:43', '2025-12-20 11:22:43', '2026-06-20 18:22:43'),
('df200da2dd9195ec4772d47e5fd597f7a27689fd4e6273fc4997898184e8bb35c456fd1159089703', 8, 1, 'GoogleToken', '[]', 0, '2025-11-04 03:49:27', '2025-11-04 03:49:27', '2026-05-04 10:49:27'),
('df32dc9d4a4ca97b33bb9602dd5eaab373878a13f9010d9d4a14f2cbe9c1dc2bfa52e7d16ac43d8f', 2, 1, 'Personal Access Token', '[]', 0, '2025-10-09 16:42:26', '2025-10-09 16:42:26', '2026-04-09 23:42:26'),
('df7f9335325498be13f5cff6da91322ad1f5b1472885612147f0a2da3b3ac473f39436f0f3fa326c', 8, 1, 'Personal Access Token', '[]', 0, '2025-11-06 19:03:17', '2025-11-06 19:03:17', '2026-05-07 02:03:17'),
('e076110804ef0251fe737a2ebe77440c1a4970db2af1ef29d6393cdcd9299754dac4482ef2628ce2', 8, 1, 'Personal Access Token', '[]', 0, '2025-10-24 01:27:39', '2025-10-24 01:27:39', '2026-04-24 08:27:39'),
('e1f4497a698709b72557dd78c143b042aef916b2a1fc7ed7616d30b2968c72022f878781afabe068', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-02 18:41:00', '2025-12-02 18:41:00', '2026-06-03 01:41:00'),
('e2fea8c2e9a784e92e08fc583680fc49ab6211cdb4720b03c76d8652372b07ffe8598e9b87423718', 8, 1, 'GoogleToken', '[]', 0, '2025-11-03 07:46:12', '2025-11-03 07:46:12', '2026-05-03 14:46:12'),
('e3eeedf920ca9af2524cbbb54b9f8485619a5a4a0098dd1df341611f83395eda1c2e3a7e66cf5055', 2, 1, 'Personal Access Token', '[]', 0, '2025-10-09 16:45:05', '2025-10-09 16:45:05', '2026-04-09 23:45:05'),
('e6d4c6af2691f91ee796d713c7a372fbad19e134083aa24291627e7781f3b90d5ac42c776367ecc5', 8, 1, 'GoogleToken', '[]', 0, '2025-11-24 00:16:06', '2025-11-24 00:16:06', '2026-05-24 07:16:06'),
('e8e87a9279917bf79f104d27b5bc1d90e15028c53cd16ca228df74ac30e93f930f886c0262d88e79', 3, 1, 'Personal Access Token', '[]', 0, '2025-12-14 08:57:08', '2025-12-14 08:57:08', '2026-06-14 15:57:08'),
('e96fb4946f423c8a5d14e5bdf70af31397d7493d19d57af45effe05ef17678f94bb8109e276fb7ab', 8, 1, 'Personal Access Token', '[]', 0, '2025-11-27 00:17:15', '2025-11-27 00:17:15', '2026-05-27 07:17:15'),
('eafd11c5e09d32f4dc1cb8ef3266a3b6df50317807ce0b280c60c8355c6a94fa0eab06a77bbfab61', 8, 1, 'GoogleToken', '[]', 0, '2025-11-04 03:38:50', '2025-11-04 03:38:51', '2026-05-04 10:38:50'),
('eb092513fcd21bda34310fa06e38c9e8365688d0e16b108ae854f80a139b60934531d535e15e70df', 1, 1, 'Personal Access Token', '[]', 0, '2025-11-26 10:21:57', '2025-11-26 10:21:57', '2026-05-26 17:21:57'),
('ed5a1c45dcb45d815591d2cd73d0a07b037d8fc34ce6cfbe70d437a1e47ead1b5cf4713a0e71c097', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-02 09:02:48', '2025-12-02 09:02:49', '2026-06-02 16:02:48'),
('ee33019cb29fda7610355d3ed9a6168fbd2e041b60bce98f94a24b3f514405ac180daeece8e04e8d', 8, 1, 'GoogleToken', '[]', 0, '2025-12-18 20:16:59', '2025-12-18 20:16:59', '2026-06-19 03:16:59'),
('f03c190dce231105f6d9bd93bb2a85bf57b1a7abd94952f3de9af838c0bd0c6867edc0772bf8d55f', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-21 08:35:35', '2025-12-21 08:35:35', '2026-06-21 15:35:35'),
('f1b7b8fc1283cfbd40107856dbc1771fe5e9c09c7efe085d4c127f377a89dbbded10dced66e167f7', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-07 09:29:34', '2025-12-07 09:29:34', '2026-06-07 16:29:34'),
('f4634dfb073b254e8dde1f9990441185aa66d2eb70512d5bd65e4eb91c2fe8fe4b6ddf0e1d5c50f6', 12, 1, 'Personal Access Token', '[]', 0, '2026-02-19 06:19:34', '2026-02-19 06:19:34', '2026-08-19 13:19:34'),
('f4e82d8455533ab5b7af093876428df5ad0b3472bdfad2f35d93cae8d427b190bb8362a2d76ea6ee', 4, 1, 'Personal Access Token', '[]', 0, '2025-10-09 21:12:45', '2025-10-09 21:12:45', '2026-04-10 04:12:45'),
('f6722e78dcee35141c385a5fe6c3b6a97019abf01041296883e740b323fd992b375832ef4f447b09', 12, 1, 'Personal Access Token', '[]', 0, '2026-02-19 06:24:13', '2026-02-19 06:24:13', '2026-08-19 13:24:13'),
('f860d5e6abfbbdb0fb24c83fcfc42a9e46d76643259a01b2ce1e5a90060a3bfd16ccf5771696b4c3', 3, 1, 'Personal Access Token', '[]', 0, '2025-12-20 12:05:23', '2025-12-20 12:05:23', '2026-06-20 19:05:23'),
('f9a25b2aa85b5820365b58aa6b5af558ad5330a69abf607bc60f6a9c385086c36ae3f212184a1129', 1, 1, 'Personal Access Token', '[]', 0, '2025-10-12 07:30:32', '2025-10-12 07:30:32', '2026-04-12 14:30:32'),
('fa013618acef9bcd261e0bb9fd82cff514dacfa35389cb0cb67d50010cc7dfce4c7670fa9127150f', 1, 1, 'Personal Access Token', '[]', 0, '2025-12-02 18:40:39', '2025-12-02 18:40:39', '2026-06-03 01:40:39');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 'FKH2ZqvLIBmJmGWg5oUySQlTPVkjwPC8LAfGtw4J', NULL, 'http://localhost', 1, 0, 0, '2025-10-09 16:26:01', '2025-10-09 16:26:01'),
(2, NULL, 'Laravel Password Grant Client', '2f6OPn9V2AHM4zeSDgBbOgFosyLYPz7scagoW0hJ', 'users', 'http://localhost', 0, 1, 0, '2025-10-09 16:26:01', '2025-10-09 16:26:01');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint UNSIGNED NOT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2025-10-09 16:26:01', '2025-10-09 16:26:01');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`email`, `token`, `created_at`) VALUES
('vit76404@gmail.com', '$2y$10$WWjMX3mp.O2AJaPBc2.En.W9u60LRva8AVjI/50ekFVH7GH4TebWS', '2025-10-09 17:04:24');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `booking_id` bigint NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) NOT NULL DEFAULT 'vnpay',
  `status` enum('pending','paid','failed') DEFAULT 'pending',
  `vnp_txn_ref` varchar(100) DEFAULT NULL,
  `vnp_response_code` varchar(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `user_id`, `booking_id`, `amount`, `payment_method`, `status`, `vnp_txn_ref`, `vnp_response_code`, `created_at`, `updated_at`) VALUES
(75, 8, 45, 1800000.00, 'vnpay', 'paid', '45_1763959947', '00', '2025-11-24 04:52:27', '2025-11-23 21:53:39'),
(76, 8, 46, 1800000.00, 'vnpay', 'paid', '46_1763963243', '00', '2025-11-24 05:47:23', '2025-11-23 22:48:05'),
(77, 8, 50, 1800000.00, 'vnpay', 'paid', '50_1764228360', '00', '2025-11-27 07:26:00', '2025-11-27 00:26:39'),
(78, 8, 51, 1800000.00, 'vnpay', 'paid', '51_1764230294', '00', '2025-11-27 07:58:14', '2025-11-27 00:58:46'),
(79, 8, 52, 1800000.00, 'vnpay', 'failed', '52_1764313409', '24', '2025-11-28 07:03:29', '2025-11-28 00:03:37'),
(80, 8, 54, 1800000.00, 'vnpay', 'paid', '54_1764508813', '00', '2025-11-30 13:20:13', '2025-11-30 06:27:59'),
(81, 8, 55, 1800000.00, 'vnpay', 'paid', '55_1764526957', '00', '2025-11-30 18:22:37', '2025-11-30 11:24:20'),
(82, 1, 56, 3724000.00, 'vnpay', 'paid', '56_1764601864', '00', '2025-12-01 15:11:04', '2025-12-01 08:12:20'),
(83, 1, 57, 4500000.00, 'vnpay', 'paid', '57_1764601999', '00', '2025-12-01 15:13:19', '2025-12-01 08:13:54'),
(84, 8, 60, 1800000.00, 'vnpay', 'paid', '60_1764762891', '00', '2025-12-03 11:54:51', '2025-12-03 04:55:47'),
(85, 8, 64, 1800000.00, 'vnpay', 'pending', '64_1765045004', NULL, '2025-12-06 18:16:44', '2025-12-06 18:16:44'),
(86, 8, 68, 2000000.00, 'vnpay', 'pending', '68_1765120853', NULL, '2025-12-07 15:20:53', '2025-12-07 15:20:53'),
(87, 8, 68, 2000000.00, 'vnpay', 'paid', '68_1765121354', '00', '2025-12-07 15:29:14', '2025-12-07 08:29:53'),
(88, 8, 69, 1440000.00, 'vnpay', 'paid', '69_1765179614', '00', '2025-12-08 07:40:14', '2025-12-08 00:40:52'),
(89, 8, 74, 1440000.00, 'vnpay', 'paid', '74_1765267591', '00', '2025-12-09 08:06:31', '2025-12-09 01:07:40'),
(90, 8, 76, 1800000.00, 'vnpay', 'paid', '76_1765598259', '00', '2025-12-13 03:57:39', '2025-12-12 20:58:24'),
(91, 8, 79, 1200000.00, 'vnpay', 'paid', '79_1765598818', '00', '2025-12-13 04:06:58', '2025-12-12 21:07:57'),
(92, 8, 89, 1600000.00, 'vnpay', 'paid', '89_1766114830', '00', '2025-12-19 03:27:10', '2025-12-18 20:27:58'),
(93, 8, 91, 6500000.00, 'vnpay', 'pending', '91_1766337469', NULL, '2025-12-21 17:17:49', '2025-12-21 17:17:49'),
(94, 11, 93, 4000000.00, 'vnpay', 'paid', '93_1766374480', '00', '2025-12-22 03:34:40', '2025-12-21 20:35:38');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rates`
--

CREATE TABLE `rates` (
  `id` bigint UNSIGNED NOT NULL,
  `rate` decimal(2,1) NOT NULL,
  `hotel_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `recommendations`
--

CREATE TABLE `recommendations` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `data` json NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `recommendations`
--

INSERT INTO `recommendations` (`id`, `user_id`, `data`, `created_at`, `updated_at`) VALUES
(3, 1, '\"[2,19,23,31,24,121,54,142,246,126]\"', '2025-12-03 23:57:09', '2025-12-04 01:50:02'),
(5, 3, '\"[555,35,712,707,690,686,736,753,693,667]\"', '2025-12-18 19:56:12', '2025-12-18 19:56:12'),
(6, 8, '\"[391,690,358,727,704,9,410,766,349,688]\"', '2025-12-21 18:09:11', '2025-12-21 18:09:11'),
(7, 11, '\"[1,35,97,28,22,81,9,27,151,14]\"', '2025-12-21 18:44:03', '2025-12-21 20:37:01');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` bigint UNSIGNED NOT NULL,
  `hotel_id` bigint UNSIGNED NOT NULL,
  `room_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `max_guest` int NOT NULL DEFAULT '1',
  `quantity` int NOT NULL DEFAULT '1',
  `amenities` json DEFAULT NULL,
  `available_from` date DEFAULT NULL,
  `available_to` date DEFAULT NULL,
  `availability_status` enum('available','unavailable') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'available',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `hotel_id`, `room_type`, `price`, `max_guest`, `quantity`, `amenities`, `available_from`, `available_to`, `availability_status`, `created_at`, `updated_at`) VALUES
(4, 1, 'Standard', 2500000.00, 6, 5, '[\"1 giường đơn và\", \"1 giường đôi lớn\"]', '2025-10-31', '2025-12-31', 'available', '2025-10-30 16:46:53', '2025-12-21 20:33:58'),
(5, 1, 'Deluxe', 2900000.00, 6, 7, '[\"1 giường đơn và\", \"1 giường đôi lớn\"]', '2025-10-31', '2025-12-31', 'available', '2025-10-30 16:48:04', '2025-12-18 20:25:47'),
(6, 1, 'Normal', 2000000.00, 2, 7, '[\"1 giường đôi lớn\"]', '2025-10-31', '2025-12-31', 'available', '2025-10-30 16:49:29', '2025-12-12 21:25:01'),
(7, 2, 'Normal', 3724000.00, 2, 9, '[\"1 giường đôi lớn\"]', '2025-10-31', '2025-12-31', 'available', '2025-12-01 07:40:25', '2025-12-01 08:10:53'),
(8, 2, 'Standard', 4500000.00, 6, 8, '[\"1 giường đôi lớn\", \"1 giường đơn\"]', '2025-12-01', '2025-12-31', 'available', '2025-12-01 07:44:53', '2025-12-21 07:33:15'),
(9, 2, 'Deluxe', 5000000.00, 6, 10, '[\"2 giường đôi lớn\"]', '2025-12-01', '2025-12-31', 'available', '2025-12-01 07:49:07', '2025-12-01 07:49:07'),
(10, 3, 'Normal', 1462050.00, 2, 10, '[\"1 giường đôi lớn\"]', '2025-12-01', '2025-12-31', 'available', '2025-12-01 07:51:49', '2025-12-02 02:10:01'),
(12, 3, 'Standard', 2000000.00, 6, 10, '[\"1 giường đôi lớn\", \"1 giường đơn\"]', '2025-12-01', '2025-12-31', 'available', '2025-12-01 07:53:20', '2025-12-01 07:53:20'),
(13, 3, 'Deluxe', 2500000.00, 6, 10, '[\"2 giường đôi lớn\"]', '2025-12-01', '2025-12-31', 'available', '2025-12-01 07:53:55', '2025-12-01 07:53:55'),
(14, 4, 'Normal', 1833960.00, 2, 10, '[\"1 giường đôi lớn\"]', '2025-12-01', '2025-12-31', 'available', '2025-12-01 08:01:58', '2025-12-01 08:01:58'),
(15, 4, 'Standard', 2300000.00, 6, 10, '[\"1 giường đôi lớn\", \"1 giường đơn\"]', '2025-12-01', '2025-12-31', 'available', '2025-12-01 08:03:54', '2025-12-01 08:03:54'),
(16, 4, 'Deluxe', 3000000.00, 6, 10, '[\"2 giường đôi lớn\"]', '2025-12-01', '2025-12-31', 'available', '2025-12-01 08:08:32', '2025-12-01 08:08:32'),
(17, 5, 'Normal', 1917664.00, 2, 10, '[\"1 giường đôi lớn\"]', '2025-12-01', '2025-12-31', 'available', '2025-12-01 08:09:24', '2025-12-01 08:09:24'),
(18, 5, 'Standard', 2500000.00, 6, 10, '[\"1 giường đôi lớn\", \"1 giường đơn\"]', '2025-12-01', '2025-12-31', 'available', '2025-12-01 08:09:57', '2025-12-01 08:09:57'),
(19, 5, 'Deluxe', 3000000.00, 6, 10, '[\"2 giường đôi lớn\"]', '2025-12-01', '2025-12-31', 'available', '2025-12-01 08:10:18', '2025-12-01 08:10:18');

-- --------------------------------------------------------

--
-- Table structure for table `styles`
--

CREATE TABLE `styles` (
  `id` bigint UNSIGNED NOT NULL,
  `style` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `styles`
--

INSERT INTO `styles` (`id`, `style`, `created_at`, `updated_at`) VALUES
(1, 'Cổ điển', '2025-10-09 16:26:00', '2025-10-09 16:26:00'),
(2, 'Hiện đại', '2025-10-09 16:26:00', '2025-10-09 16:26:00'),
(3, 'Yên tĩnh', '2025-10-09 16:26:00', '2025-10-09 16:26:00'),
(4, 'Sôi động', '2025-10-09 16:26:00', '2025-10-09 16:26:00'),
(5, 'Lãng mạn', '2025-10-09 16:26:00', '2025-10-09 16:26:00'),
(6, 'Tình yêu', '2025-10-09 16:26:00', '2025-10-09 16:26:00');

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

CREATE TABLE `subscribers` (
  `id` bigint UNSIGNED NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

CREATE TABLE `support_tickets` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `priority` enum('low','medium','high','urgent') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'medium',
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','in_progress','resolved') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `ticket_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `support_tickets`
--

INSERT INTO `support_tickets` (`id`, `name`, `email`, `subject`, `priority`, `message`, `status`, `ticket_number`, `created_at`, `updated_at`) VALUES
(1, 'tranvi aa', 'tranquocvi25082004@gmail.com', 'aaa', 'medium', 'aaaaaaaaaaaaaaa', 'pending', 'TKT-20251130-2282', '2025-11-30 08:11:48', '2025-11-30 08:11:48'),
(2, 'tranvi aa', 'tranquocvi25082004@gmail.com', 'aaaaaaaaaaaaaaa', 'medium', 'aaaaaaaaaaaaaaa', 'pending', 'TKT-20251130-9836', '2025-11-30 08:11:55', '2025-11-30 08:11:55'),
(3, 'qqqq', 'tranquocvi25082004@gmail.com', 'aaaaaaaaaaaaaaaaaaaaa', 'medium', 'aaaaaaaaaa', 'pending', 'TKT-20251130-3454', '2025-11-30 08:15:32', '2025-11-30 08:15:32'),
(4, 'tranvi aa', 'tranquocvi25082004@gmail.com', 'aaaaaaaaaaaaaaaaaaa', 'medium', 'aaaaaaaaaaaaaaaaaaaaaaaa', 'pending', 'TKT-20251130-4665', '2025-11-30 08:21:27', '2025-11-30 08:21:27');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` tinyint NOT NULL DEFAULT '0' COMMENT '0 = user,1 = admin,2 = bussiness',
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birth` date DEFAULT NULL,
  `address` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wallet_balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `is_blocked` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `role`, `gender`, `birth`, `address`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `phone`, `image`, `wallet_balance`, `is_blocked`) VALUES
(1, 'vi25', 'vit76404@gmail.com', 1, NULL, NULL, '424 lê duẩn', NULL, '$2y$10$pPZ.u2HQStt/huKnAvAKze45KqYa72KeY/lEdmxD0lCjfYdEzfkSa', NULL, '2025-10-09 16:32:39', '2025-12-04 11:41:01', '0774594729', 'https://i.ibb.co/zWc916yw/360e14db8326.jpg', 0.00, 0),
(2, 'tranvi', 'vit7604@gmail.com', 0, NULL, NULL, NULL, NULL, '$2y$10$2Qwy9cH2T/UMFonDaNO.QOYwFH.VfXAvtswUFAgiDcCCUWDdwMAqu', NULL, '2025-10-09 16:38:35', '2025-10-09 16:38:35', '0935326193', NULL, 0.00, 0),
(3, 'tranvi', 'tranquocvi25082004@gmail.com', 0, NULL, NULL, NULL, NULL, '$2y$10$pPZ.u2HQStt/huKnAvAKze45KqYa72KeY/lEdmxD0lCjfYdEzfkSa', NULL, '2025-10-09 18:59:55', '2025-10-09 18:59:55', '0774594729', NULL, 0.00, 0),
(8, 'TranVi', 'vi.ddtran@rikai.technology', 0, 'Male', '2004-08-25', '420 Lê Duẩn đà nẵng', NULL, '$2y$10$pPZ.u2HQStt/huKnAvAKze45KqYa72KeY/lEdmxD0lCjfYdEzfkSa', NULL, '2025-10-24 01:27:21', '2025-12-21 10:31:46', '0774594729', 'https://i.ibb.co/20PCFNb7/84593262e138.jpg', 900000.00, 0),
(9, 'tranvi aa', 'vit22@gmail.com', 3, NULL, NULL, NULL, NULL, '$2y$10$i/dVVvWgscpyJnxdW6qB.euQgFRM.bLhvfbNw9HQ.JcK2Z4/oXzfa', NULL, '2025-11-30 10:54:28', '2025-12-04 11:46:00', '0774594729', NULL, 0.00, 0),
(10, 'tranvi aa', 'tranquocvi2508200@gmail.com', 0, NULL, NULL, NULL, NULL, '$2y$10$Uiw0gZBdiBnY4fVzahwq5uPzSd983EU/TsesmzgBkN2CkIy2DQ/4y', NULL, '2025-12-16 08:22:38', '2025-12-16 08:22:38', '0774594729', NULL, 0.00, 0),
(11, 'Tran Quoc Vi', 'vi.tran@rikai.technology', 0, NULL, NULL, NULL, NULL, '$2y$10$Afb80nq.OMRYB1WYJmj06eQIuHcWOe1OIKZSVA0imHDSOS7FCpxkO', NULL, '2025-12-21 18:20:18', '2025-12-21 18:20:18', NULL, NULL, 0.00, 0),
(12, 'tranvi aa', 'vit404@gmail.com', 2, NULL, NULL, NULL, NULL, '$2y$10$Xa1efZqJF/M2LorhmK8GtOBdkHlZ96KfgpNJy6OWB4waYRXpFQQLu', NULL, '2026-02-19 06:19:20', '2026-02-19 06:19:20', '0774594729', NULL, 0.00, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_behaviors`
--

CREATE TABLE `user_behaviors` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `hotel_id` bigint UNSIGNED DEFAULT NULL,
  `action` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `metadata` json DEFAULT NULL,
  `is_sent` tinyint(1) NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_behaviors`
--

INSERT INTO `user_behaviors` (`id`, `user_id`, `hotel_id`, `action`, `metadata`, `is_sent`, `timestamp`) VALUES
(1008, 1, 374, 'booking', '\"{\\\"userId\\\":1,\\\"hotelId\\\":374}\"', 0, '2026-02-27 14:19:55'),
(1009, 11, 6, 'booking', '\"{\\\"userId\\\":11,\\\"hotelId\\\":6}\"', 1, '2026-02-27 14:29:15'),
(1010, 11, 3, 'click', '\"{\\\"userId\\\":11,\\\"hotelId\\\":3}\"', 0, '2026-02-27 14:34:05'),
(1011, 11, 3, 'booking', '\"{\\\"userId\\\":11,\\\"hotelId\\\":3}\"', 0, '2026-02-27 14:34:11');

-- --------------------------------------------------------

--
-- Table structure for table `wishlists`
--

CREATE TABLE `wishlists` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `hotel_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wishlists`
--

INSERT INTO `wishlists` (`id`, `user_id`, `hotel_id`, `created_at`, `updated_at`) VALUES
(221, 11, 1, '2025-12-21 20:36:35', '2025-12-21 20:36:35'),
(222, 11, 2, '2025-12-21 20:36:38', '2025-12-21 20:36:38');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookings_user_id_index` (`user_id`),
  ADD KEY `bookings_room_id_index` (`room_id`),
  ADD KEY `idx_booking_status` (`status`),
  ADD KEY `idx_booking_created_at` (`created_at`),
  ADD KEY `idx_bookings_created_at` (`created_at`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_userid_index` (`userId`),
  ADD KEY `comments_parent_id_index` (`parent_id`);

--
-- Indexes for table `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `discounts_code_unique` (`code`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `hotels`
--
ALTER TABLE `hotels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_province` (`province`),
  ADD KEY `idx_price` (`price`),
  ADD KEY `idx_hotel_class` (`hotel_class`),
  ADD KEY `hotels_user_id_foreign` (`user_id`);
ALTER TABLE `hotels` ADD FULLTEXT KEY `idx_name_description` (`name`,`description`);

--
-- Indexes for table `hotel_styles`
--
ALTER TABLE `hotel_styles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hotel_styles_hotel_id_index` (`hotel_id`),
  ADD KEY `hotel_styles_style_id_index` (`style_id`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_user_id_foreign` (`user_id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_payments_user_created` (`user_id`,`created_at` DESC);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `rates`
--
ALTER TABLE `rates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rates_hotel_id_index` (`hotel_id`),
  ADD KEY `rates_user_id_index` (`user_id`);

--
-- Indexes for table `recommendations`
--
ALTER TABLE `recommendations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recommendations_user_id_foreign` (`user_id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_hotel_id` (`hotel_id`),
  ADD KEY `idx_status` (`availability_status`),
  ADD KEY `idx_guest` (`max_guest`),
  ADD KEY `idx_quantity` (`quantity`),
  ADD KEY `idx_available_from_to` (`available_from`,`available_to`),
  ADD KEY `idx_rooms_search` (`hotel_id`,`quantity`,`available_from`,`available_to`);

--
-- Indexes for table `styles`
--
ALTER TABLE `styles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscribers`
--
ALTER TABLE `subscribers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subscribers_email_unique` (`email`);

--
-- Indexes for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `support_tickets_ticket_number_unique` (`ticket_number`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `idx_user_role` (`role`);

--
-- Indexes for table `user_behaviors`
--
ALTER TABLE `user_behaviors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_behaviors_user_id_index` (`user_id`),
  ADD KEY `user_behaviors_hotel_id_index` (`hotel_id`),
  ADD KEY `user_behaviors_action_index` (`action`),
  ADD KEY `user_behaviors_timestamp_index` (`timestamp`);

--
-- Indexes for table `wishlists`
--
ALTER TABLE `wishlists`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `wishlists_user_id_room_id_unique` (`user_id`,`hotel_id`),
  ADD KEY `wishlists_room_id_foreign` (`hotel_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `discounts`
--
ALTER TABLE `discounts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `hotels`
--
ALTER TABLE `hotels`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=403;

--
-- AUTO_INCREMENT for table `hotel_styles`
--
ALTER TABLE `hotel_styles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=867;

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1345;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rates`
--
ALTER TABLE `rates`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `recommendations`
--
ALTER TABLE `recommendations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `styles`
--
ALTER TABLE `styles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `subscribers`
--
ALTER TABLE `subscribers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_tickets`
--
ALTER TABLE `support_tickets`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `user_behaviors`
--
ALTER TABLE `user_behaviors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1012;

--
-- AUTO_INCREMENT for table `wishlists`
--
ALTER TABLE `wishlists`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=225;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `hotels`
--
ALTER TABLE `hotels`
  ADD CONSTRAINT `hotels_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `recommendations`
--
ALTER TABLE `recommendations`
  ADD CONSTRAINT `recommendations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `rooms_hotel_id_foreign` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `wishlists`
--
ALTER TABLE `wishlists`
  ADD CONSTRAINT `wishlists_room_id_foreign` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `wishlists_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
