-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 21, 2026 at 01:57 PM
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
-- Database: `reporting_laravel_dalisay`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUserRecentTickets` (IN `p_user_id` INT, IN `p_limit` INT)   BEGIN
    SELECT 
        t.id,
        t.title,
        t.status,
        t.priority,
        t.created_at,
        d.name AS department
    FROM tickets t
    LEFT JOIN departments d ON d.id = t.department_id
    WHERE t.user_id = p_user_id
    AND t.status != 'Cancelled'
    ORDER BY t.created_at DESC
    LIMIT p_limit;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUserStats` (IN `p_user_id` INT)   BEGIN
    SELECT 
        COUNT(*) AS total,
        SUM(CASE WHEN status = 'Pending' THEN 1 ELSE 0 END) AS pending,
        SUM(CASE WHEN status = 'Resolved' THEN 1 ELSE 0 END) AS resolved,
        SUM(CASE WHEN status = 'In Progress' THEN 1 ELSE 0 END) AS in_progress,
        SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled
    FROM tickets
    WHERE user_id = p_user_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `attachments`
--

CREATE TABLE `attachments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ticket_id` bigint(20) UNSIGNED NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attachments`
--

INSERT INTO `attachments` (`id`, `ticket_id`, `file_name`, `file_path`, `created_at`, `updated_at`) VALUES
(1, 16, 'Screenshot 2025-08-18 223806.png', 'attachments/kCEcSEfzIphNOn96iKdQGymJ9Ide4cQSZZ2GF2di.png', '2026-05-10 18:50:31', '2026-05-10 18:50:31'),
(2, 25, 'Screenshot 2025-08-18 223806.png', 'attachments/HH79zYkchNkAiAM3Tm9Rrmq9zaNuvdhCLNPj4yif.png', '2026-05-11 18:16:15', '2026-05-11 18:16:15'),
(3, 28, 'Screenshot 2025-08-27 125420.png', 'attachments/YK9uIfRcSQdHCphmTDoDmOR43RAE2SekEXNlEUuI.png', '2026-05-19 20:50:57', '2026-05-19 20:50:57'),
(4, 40, 'Screenshot 2025-08-27 125420.png', 'attachments/HM9K6YMJUKaMotCIXyY0jM6OzXhBIOweZPhHojhh.png', '2026-05-20 22:33:10', '2026-05-20 22:33:10');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ticket_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `ticket_id`, `user_id`, `message`, `created_at`, `updated_at`) VALUES
(1, 3, 8, 'hi', '2026-05-09 05:48:32', '2026-05-09 05:48:32'),
(2, 3, 8, 'hello', '2026-05-09 05:48:40', '2026-05-09 05:48:40'),
(3, 3, 8, 'done napo', '2026-05-09 05:50:25', '2026-05-09 05:50:25'),
(4, 4, 8, 'hi', '2026-05-09 06:11:52', '2026-05-09 06:11:52'),
(5, 4, 3, 'da', '2026-05-09 06:21:45', '2026-05-09 06:21:45'),
(6, 4, 3, 'hi', '2026-05-09 06:21:51', '2026-05-09 06:21:51'),
(7, 4, 3, 'sumbagay', '2026-05-09 06:22:10', '2026-05-09 06:22:10'),
(8, 4, 3, 'hi', '2026-05-09 06:22:16', '2026-05-09 06:22:16'),
(9, 4, 3, 'sumbagay', '2026-05-09 06:22:22', '2026-05-09 06:22:22'),
(10, 4, 8, 'ulol', '2026-05-09 06:22:58', '2026-05-09 06:22:58'),
(11, 5, 3, 'dads', '2026-05-10 01:05:43', '2026-05-10 01:05:43'),
(12, 6, 3, 'dasdsa', '2026-05-10 03:25:45', '2026-05-10 03:25:45'),
(13, 6, 3, 'dasdas', '2026-05-10 03:28:12', '2026-05-10 03:28:12'),
(14, 6, 3, 'dasda', '2026-05-10 03:28:16', '2026-05-10 03:28:16'),
(15, 6, 8, '312312', '2026-05-10 03:30:22', '2026-05-10 03:30:22'),
(16, 6, 8, 'dasda', '2026-05-10 03:42:27', '2026-05-10 03:42:27'),
(17, 6, 8, 'nega', '2026-05-10 03:42:32', '2026-05-10 03:42:32'),
(18, 11, 3, '432fdsf', '2026-05-10 04:54:11', '2026-05-10 04:54:11'),
(19, 7, 8, '21321', '2026-05-10 05:02:46', '2026-05-10 05:02:46'),
(20, 7, 8, '31231', '2026-05-10 05:02:48', '2026-05-10 05:02:48'),
(21, 11, 3, '31231231', '2026-05-10 05:03:44', '2026-05-10 05:03:44'),
(22, 11, 3, '423423', '2026-05-10 05:03:46', '2026-05-10 05:03:46'),
(23, 11, 8, '4234324', '2026-05-10 05:04:06', '2026-05-10 05:04:06'),
(24, 12, 3, 'klj', '2026-05-10 05:19:58', '2026-05-10 05:19:58'),
(25, 11, 8, '432432', '2026-05-10 17:28:36', '2026-05-10 17:28:36'),
(26, 19, 3, 'dqsdasd', '2026-05-11 00:26:56', '2026-05-11 00:26:56'),
(27, 19, 8, 'ulol', '2026-05-11 00:27:15', '2026-05-11 00:27:15'),
(28, 19, 2, 'nega', '2026-05-11 00:27:47', '2026-05-11 00:27:47'),
(29, 21, 3, 'dasd', '2026-05-11 00:47:24', '2026-05-11 00:47:24'),
(30, 23, 8, 'dasdas', '2026-05-11 18:16:40', '2026-05-11 18:16:40'),
(31, 23, 8, 'dasdsa', '2026-05-11 18:16:42', '2026-05-11 18:16:42'),
(32, 23, 3, '3211', '2026-05-11 18:17:04', '2026-05-11 18:17:04'),
(33, 21, 8, '312321321', '2026-05-16 04:23:57', '2026-05-16 04:23:57'),
(34, 28, 8, 'dasdasdasdasdasdas', '2026-05-19 20:51:55', '2026-05-19 20:51:55'),
(35, 30, 3, 'dasdasd', '2026-05-20 17:44:21', '2026-05-20 17:44:21'),
(36, 41, 3, '321321', '2026-05-21 03:22:18', '2026-05-21 03:22:18'),
(37, 36, 8, '3213213', '2026-05-21 03:22:36', '2026-05-21 03:22:36'),
(38, 36, 8, '3213213', '2026-05-21 03:24:44', '2026-05-21 03:24:44'),
(39, 36, 8, '3213213', '2026-05-21 03:27:00', '2026-05-21 03:27:00'),
(40, 36, 8, 'das', '2026-05-21 03:29:00', '2026-05-21 03:29:00'),
(41, 36, 8, 'das', '2026-05-21 03:33:02', '2026-05-21 03:33:02'),
(42, 36, 8, 'das', '2026-05-21 03:33:47', '2026-05-21 03:33:47'),
(43, 36, 8, 'dasdas', '2026-05-21 03:33:54', '2026-05-21 03:33:54'),
(44, 41, 3, 'dasdasdas', '2026-05-21 03:35:00', '2026-05-21 03:35:00'),
(45, 41, 8, 'dasdas', '2026-05-21 03:35:16', '2026-05-21 03:35:16');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'HR', '2026-05-20 16:30:20', '2026-05-20 16:30:20'),
(2, 'IT', '2026-05-20 17:45:00', '2026-05-20 17:45:00'),
(3, 'Security', '2026-05-21 03:11:26', '2026-05-21 03:11:26');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_05_06_021800_create_categories_table', 1),
(5, '2026_05_06_021829_create_tickets_table', 1),
(6, '2026_05_06_021840_create_comments_table', 1),
(7, '2026_05_06_021853_create_attachments_table', 1),
(8, '2026_05_11_071409_create_ticket_histories_table', 2),
(9, '2026_05_16_063845_create_notifications_table', 3),
(10, '2026_05_20_225708_create_departments_table', 4),
(11, '2026_05_21_002655_add_department_id_to_users_table', 5),
(12, '2026_05_21_012350_add_department_id_to_tickets_table', 6),
(13, '2026_05_21_113324_create_notifications_table', 7);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('183cc0c2-3338-4b01-86c4-4d280362edd1', 'App\\Notifications\\NewComment', 'App\\Models\\User', 8, '{\"ticket_id\":41,\"comment_id\":44,\"commenter_name\":\"jopfrey\",\"type\":\"comment\",\"message\":\"jopfrey added a comment to your report\"}', NULL, '2026-05-21 03:35:00', '2026-05-21 03:35:00'),
('875f5acc-ca82-4c59-952d-764af551864f', 'App\\Notifications\\NewComment', 'App\\Models\\User', 3, '{\"ticket_id\":36,\"comment_id\":42,\"commenter_name\":\"jopfreynatao\",\"type\":\"comment\",\"message\":\"jopfreynatao added a comment to your report\"}', NULL, '2026-05-21 03:33:47', '2026-05-21 03:33:47'),
('ae5c0ea9-b0d8-494d-b75f-db63d9570c05', 'App\\Notifications\\NewComment', 'App\\Models\\User', 3, '{\"ticket_id\":41,\"comment_id\":45,\"commenter_name\":\"jopfreynatao\",\"type\":\"comment\",\"message\":\"jopfreynatao added a comment to your report\"}', NULL, '2026-05-21 03:35:16', '2026-05-21 03:35:16'),
('f58308a8-21bd-4077-bb28-b129708ff50f', 'App\\Notifications\\NewComment', 'App\\Models\\User', 3, '{\"ticket_id\":36,\"comment_id\":43,\"commenter_name\":\"jopfreynatao\",\"type\":\"comment\",\"message\":\"jopfreynatao added a comment to your report\"}', NULL, '2026-05-21 03:33:54', '2026-05-21 03:33:54');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('OjpgBq4dYL1XCmVWUcjP9wfgjIA6SbGX6YORg2eA', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidzBhcEFIZnE5QUNSQXR0YVZHbHVxMHA1d3hXM0lQQkJNcjc2MThuYiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9fQ==', 1779364463);

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `assigned_to` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `priority` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `department_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`id`, `user_id`, `assigned_to`, `title`, `description`, `priority`, `status`, `created_at`, `updated_at`, `department_id`) VALUES
(1, 3, 8, '312321', 'rwerw', 'Low', 'Cancelled', '2026-05-09 00:32:38', '2026-05-11 00:45:07', NULL),
(2, 3, 8, 'bisaya na guba', 'nega', 'Low', 'In Progress', '2026-05-09 03:22:13', '2026-05-09 06:08:57', NULL),
(3, 3, 8, 'yagaya', 'lol', 'High', 'In Progress', '2026-05-09 05:09:36', '2026-05-09 06:08:29', NULL),
(4, 3, 8, '4324', '32432432', 'Medium', 'In Progress', '2026-05-09 05:27:55', '2026-05-09 06:08:49', NULL),
(5, 3, 8, '321321', '32131', 'High', 'In Progress', '2026-05-10 01:00:27', '2026-05-10 01:14:16', NULL),
(6, 3, 8, '31231', '312321321', 'High', 'In Progress', '2026-05-10 01:11:58', '2026-05-10 03:42:51', NULL),
(7, 3, 8, '3213', '1321321', 'Low', 'Resolved', '2026-05-10 03:59:33', '2026-05-10 05:02:41', NULL),
(8, 3, NULL, '321312', '32131232131', 'Medium', 'Cancelled', '2026-05-10 04:09:02', '2026-05-11 06:42:05', NULL),
(9, 3, NULL, 'eqweqwe213', '21312312321', 'Medium', 'Cancelled', '2026-05-10 04:14:26', '2026-05-11 06:42:02', NULL),
(10, 3, NULL, '42342', '423', 'Low', 'Cancelled', '2026-05-10 04:27:13', '2026-05-11 00:56:02', NULL),
(11, 3, 8, '3123', '21321311', 'Low', 'Resolved', '2026-05-10 04:33:56', '2026-05-11 00:14:59', NULL),
(12, 3, 8, '4234', '234324324324', 'Medium', 'Cancelled', '2026-05-10 05:19:50', '2026-05-11 00:55:59', NULL),
(13, 3, 8, '4324324', '23423432', 'Low', 'Resolved', '2026-05-10 05:25:48', '2026-05-11 00:14:51', NULL),
(14, 3, 8, 'dfsfsdfs', 'fsfsfsfsfs', 'Medium', 'Cancelled', '2026-05-10 18:05:39', '2026-05-11 00:55:54', NULL),
(15, 3, 8, 'dasdad', 'adasdadadadads', 'Low', 'Cancelled', '2026-05-10 18:47:03', '2026-05-11 00:55:52', NULL),
(16, 3, 8, '32132131231', '312321321321321', 'Low', 'Cancelled', '2026-05-10 18:50:31', '2026-05-11 00:55:49', NULL),
(17, 3, 8, '321321', '321312312', 'Medium', 'Cancelled', '2026-05-10 23:44:59', '2026-05-11 00:55:47', NULL),
(18, 3, 8, '3213', '21321321321', 'Medium', 'Cancelled', '2026-05-10 23:48:08', '2026-05-11 00:55:45', NULL),
(19, 3, 8, '312312', '313213132131', 'Medium', 'Resolved', '2026-05-10 23:53:01', '2026-05-11 00:51:05', NULL),
(20, 3, NULL, '312312', '312321312312', 'Medium', 'Cancelled', '2026-05-11 00:20:46', '2026-05-11 06:40:36', NULL),
(21, 3, 8, '3213213132131321', '32132131313213', 'Low', 'In Progress', '2026-05-11 00:36:30', '2026-05-11 06:26:09', NULL),
(22, 3, 9, '32132131213', '21312313', 'Medium', 'In Progress', '2026-05-11 01:21:45', '2026-05-11 18:01:41', NULL),
(23, 3, 8, '3213213', '2131231312321321', 'Low', 'Resolved', '2026-05-11 17:24:25', '2026-05-11 18:16:46', NULL),
(24, 3, NULL, '434', '32423423432', 'High', 'Cancelled', '2026-05-11 17:40:11', '2026-05-11 18:16:24', NULL),
(25, 3, NULL, '321321', '3213213213', 'Medium', 'Cancelled', '2026-05-11 18:16:14', '2026-05-11 18:16:22', NULL),
(26, 3, 19, '3213', '213123121', 'Low', 'In Progress', '2026-05-16 04:06:08', '2026-05-19 14:26:23', NULL),
(27, 3, 8, '3213', '123213143242332', 'High', 'In Progress', '2026-05-16 04:21:13', '2026-05-20 17:51:27', NULL),
(28, 3, 18, '3213213', '1232132121', 'Low', 'In Progress', '2026-05-19 20:50:56', '2026-05-20 17:51:28', NULL),
(29, 3, 8, 'dasd', 'adadas', 'Low', 'In Progress', '2026-05-20 15:29:21', '2026-05-20 17:33:34', NULL),
(30, 3, 9, '432423', '432432432', 'Low', 'In Progress', '2026-05-20 17:44:00', '2026-05-20 17:45:40', 1),
(31, 3, 8, '3213', '21321321321', 'Low', 'In Progress', '2026-05-20 17:51:56', '2026-05-20 17:57:20', 2),
(32, 3, 26, 'dasdasd', 'asdasdasdsad', 'Low', 'In Progress', '2026-05-20 21:01:12', '2026-05-20 21:24:44', 2),
(33, 3, 26, '3213', '21321321', 'Low', 'In Progress', '2026-05-20 21:11:45', '2026-05-20 21:24:42', 1),
(34, 3, 26, 'dasdas', 'adasda', 'High', 'In Progress', '2026-05-20 21:16:03', '2026-05-20 21:24:41', 1),
(35, 3, NULL, '321321', '321321', 'Low', 'Cancelled', '2026-05-20 22:05:06', '2026-05-21 03:54:01', 1),
(36, 3, 8, '31', '31221', 'Low', 'In Progress', '2026-05-20 22:16:29', '2026-05-20 22:20:31', 1),
(37, 3, NULL, '32131', '2321321', 'Low', 'Cancelled', '2026-05-20 22:26:42', '2026-05-21 03:53:59', 1),
(38, 3, NULL, '32', '4234', 'Low', 'Cancelled', '2026-05-20 22:29:01', '2026-05-21 03:53:57', 1),
(39, 3, NULL, '32', '4234', 'Low', 'Cancelled', '2026-05-20 22:29:25', '2026-05-21 03:53:55', 1),
(40, 3, NULL, '32', '4234', 'Low', 'Cancelled', '2026-05-20 22:33:10', '2026-05-21 03:53:51', 1),
(41, 3, 8, '312312321', '321321321', 'Medium', 'In Progress', '2026-05-21 03:17:42', '2026-05-21 03:34:45', 3);

--
-- Triggers `tickets`
--
DELIMITER $$
CREATE TRIGGER `after_ticket_status_update` AFTER UPDATE ON `tickets` FOR EACH ROW BEGIN
    IF OLD.status != NEW.status THEN
        INSERT INTO ticket_histories (
            ticket_id,
            user_id,
            status_from,
            status_to,
            comment,
            created_at,
            updated_at
        ) VALUES (
            NEW.id,
            NEW.user_id,  -- ← FIXED: use user_id instead of assigned_to
            OLD.status,
            NEW.status,
            CONCAT('Status changed from ', OLD.status, ' to ', NEW.status),
            NOW(),
            NOW()
        );
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_histories`
--

CREATE TABLE `ticket_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ticket_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `status_from` varchar(255) DEFAULT NULL,
  `status_to` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ticket_histories`
--

INSERT INTO `ticket_histories` (`id`, `ticket_id`, `user_id`, `status_from`, `status_to`, `comment`, `created_at`, `updated_at`) VALUES
(1, 16, 2, NULL, NULL, NULL, '2026-05-10 23:42:22', '2026-05-10 23:42:22'),
(2, 18, 2, 'In Progress', 'In Progress', 'Status updated', '2026-05-10 23:52:27', '2026-05-10 23:52:27'),
(3, 18, 2, 'In Progress', 'Pending', 'Status updated', '2026-05-10 23:52:31', '2026-05-10 23:52:31'),
(4, 18, 2, 'Pending', 'In Progress', 'Status updated', '2026-05-10 23:52:35', '2026-05-10 23:52:35'),
(5, 13, 8, 'In Progress', 'Resolved', 'resolved', '2026-05-11 00:14:51', '2026-05-11 00:14:51'),
(6, 11, 8, 'Pending', 'Resolved', 'resolved', '2026-05-11 00:14:59', '2026-05-11 00:14:59'),
(7, 19, 2, 'Pending', 'Pending', 'status_updated', '2026-05-11 00:18:52', '2026-05-11 00:18:52'),
(8, 19, 2, 'Pending', 'In Progress', 'status_updated', '2026-05-11 00:18:54', '2026-05-11 00:18:54'),
(9, 19, 2, 'In Progress', 'In Progress', 'Ticket assigned to staff member: jopfreynatao', '2026-05-11 00:24:05', '2026-05-11 00:24:05'),
(10, 18, 2, 'In Progress', 'In Progress', 'Ticket assigned to staff member: jopfreynatao', '2026-05-11 00:24:07', '2026-05-11 00:24:07'),
(11, 17, 2, 'Pending', 'In Progress', 'Ticket assigned to staff member: jopfreynatao', '2026-05-11 00:24:52', '2026-05-11 00:24:52'),
(12, 16, 2, 'In Progress', 'In Progress', 'Ticket assigned to staff member: jopfreynatao', '2026-05-11 00:24:54', '2026-05-11 00:24:54'),
(13, 15, 2, 'Pending', 'In Progress', 'Ticket assigned to staff member: jopfreynatao', '2026-05-11 00:25:03', '2026-05-11 00:25:03'),
(14, 14, 2, 'Pending', 'In Progress', 'Ticket assigned to staff member: jopfreynatao', '2026-05-11 00:25:05', '2026-05-11 00:25:05'),
(15, 12, 2, 'Pending', 'In Progress', 'Ticket assigned to staff member: jopfreynatao', '2026-05-11 00:25:07', '2026-05-11 00:25:07'),
(16, 20, 2, 'Pending', 'Pending', 'status_updated', '2026-05-11 00:25:15', '2026-05-11 00:25:15'),
(17, 19, 8, 'In Progress', 'In Progress', 'status_updated', '2026-05-11 00:27:16', '2026-05-11 00:27:16'),
(18, 19, 8, 'In Progress', 'Resolved', 'resolved', '2026-05-11 00:27:18', '2026-05-11 00:27:18'),
(19, 1, 3, 'In Progress', 'Cancelled', 'User cancelled the ticket', '2026-05-11 00:45:07', '2026-05-11 00:45:07'),
(20, 21, 3, 'Pending', 'Cancelled', 'User cancelled the ticket', '2026-05-11 00:47:07', '2026-05-11 00:47:07'),
(21, 20, 3, 'Pending', 'Cancelled', 'User cancelled the ticket', '2026-05-11 00:47:10', '2026-05-11 00:47:10'),
(22, 18, 3, 'In Progress', 'Cancelled', 'User cancelled the ticket', '2026-05-11 00:47:46', '2026-05-11 00:47:46'),
(23, 17, 3, 'In Progress', 'Cancelled', 'User cancelled the ticket', '2026-05-11 00:47:49', '2026-05-11 00:47:49'),
(24, 19, 8, 'Resolved', 'Pending', 'status_updated', '2026-05-11 00:51:00', '2026-05-11 00:51:00'),
(25, 19, 8, 'Pending', 'In Progress', 'status_updated', '2026-05-11 00:51:03', '2026-05-11 00:51:03'),
(26, 19, 8, 'In Progress', 'Resolved', 'resolved', '2026-05-11 00:51:05', '2026-05-11 00:51:05'),
(27, 18, 8, 'Cancelled', 'In Progress', 'status_updated', '2026-05-11 00:51:12', '2026-05-11 00:51:12'),
(28, 18, 8, 'In Progress', 'Pending', 'status_updated', '2026-05-11 00:51:14', '2026-05-11 00:51:14'),
(29, 18, 8, 'Pending', 'Pending', 'status_updated', '2026-05-11 00:51:14', '2026-05-11 00:51:14'),
(30, 18, 8, 'Pending', 'In Progress', 'status_updated', '2026-05-11 00:51:19', '2026-05-11 00:51:19'),
(31, 17, 8, 'Cancelled', 'In Progress', 'status_updated', '2026-05-11 00:51:23', '2026-05-11 00:51:23'),
(32, 18, 3, 'In Progress', 'Cancelled', 'User cancelled the ticket', '2026-05-11 00:55:45', '2026-05-11 00:55:45'),
(33, 17, 3, 'In Progress', 'Cancelled', 'User cancelled the ticket', '2026-05-11 00:55:47', '2026-05-11 00:55:47'),
(34, 16, 3, 'In Progress', 'Cancelled', 'User cancelled the ticket', '2026-05-11 00:55:49', '2026-05-11 00:55:49'),
(35, 15, 3, 'In Progress', 'Cancelled', 'User cancelled the ticket', '2026-05-11 00:55:52', '2026-05-11 00:55:52'),
(36, 14, 3, 'In Progress', 'Cancelled', 'User cancelled the ticket', '2026-05-11 00:55:54', '2026-05-11 00:55:54'),
(37, 12, 3, 'In Progress', 'Cancelled', 'User cancelled the ticket', '2026-05-11 00:55:59', '2026-05-11 00:55:59'),
(38, 10, 3, 'Pending', 'Cancelled', 'User cancelled the ticket', '2026-05-11 00:56:02', '2026-05-11 00:56:02'),
(39, 21, 2, 'Cancelled', 'In Progress', 'status_updated', '2026-05-11 00:58:26', '2026-05-11 00:58:26'),
(40, 20, 2, 'Cancelled', 'In Progress', 'Ticket assigned to staff member: jopfreynatao', '2026-05-11 01:17:09', '2026-05-11 01:17:09'),
(41, 20, 2, 'In Progress', 'In Progress', 'Ticket assigned to staff member: das', '2026-05-11 01:21:08', '2026-05-11 01:21:08'),
(42, 20, 2, 'In Progress', 'In Progress', 'Ticket assigned to staff member: geoffrey', '2026-05-11 01:21:10', '2026-05-11 01:21:10'),
(43, 20, 2, 'In Progress', 'In Progress', 'Ticket assigned to staff member: jopfreynatao', '2026-05-11 01:21:11', '2026-05-11 01:21:11'),
(44, 21, 2, 'In Progress', 'In Progress', 'Ticket assigned to staff member: jopfreynatao', '2026-05-11 01:22:06', '2026-05-11 01:22:06'),
(45, 21, 2, 'In Progress', 'In Progress', 'Ticket assigned to staff member: das', '2026-05-11 01:30:42', '2026-05-11 01:30:42'),
(46, 21, 2, 'In Progress', 'In Progress', 'Ticket assigned to staff member: jopfreynatao', '2026-05-11 01:30:46', '2026-05-11 01:30:46'),
(47, 21, 2, 'In Progress', 'In Progress', 'Ticket assigned to staff member: geoffrey', '2026-05-11 01:34:02', '2026-05-11 01:34:02'),
(48, 21, 2, NULL, 'Pending', 'Staff member removed. Ticket is now Unassigned.', '2026-05-11 01:35:32', '2026-05-11 01:35:32'),
(49, 20, 2, NULL, 'Pending', 'Staff member removed. Ticket is now Unassigned.', '2026-05-11 01:35:34', '2026-05-11 01:35:34'),
(50, 21, 2, NULL, 'In Progress', 'Ticket assigned to jopfreynatao', '2026-05-11 01:37:26', '2026-05-11 01:37:26'),
(51, 21, 2, NULL, 'Pending', 'Staff member removed. Ticket is now Unassigned.', '2026-05-11 01:37:29', '2026-05-11 01:37:29'),
(52, 21, 2, 'Pending', 'In Progress', 'Admin assigned staff to ticket', '2026-05-11 01:39:44', '2026-05-11 01:39:44'),
(53, 21, 2, NULL, 'In Progress', 'Ticket assigned to jopfreynatao', '2026-05-11 01:41:34', '2026-05-11 01:41:34'),
(54, 21, 2, NULL, 'In Progress', 'Ticket assigned to das', '2026-05-11 01:42:18', '2026-05-11 01:42:18'),
(55, 21, 2, NULL, 'In Progress', 'Ticket assigned to geoffrey', '2026-05-11 01:42:20', '2026-05-11 01:42:20'),
(56, 20, 2, NULL, 'In Progress', 'Ticket assigned to geoffrey', '2026-05-11 01:42:23', '2026-05-11 01:42:23'),
(57, 20, 2, NULL, 'Pending', 'Staff member removed. Ticket is now Unassigned.', '2026-05-11 01:42:25', '2026-05-11 01:42:25'),
(58, 21, 2, 'In Progress', 'In Progress', 'Ticket assigned to jopfreynatao', '2026-05-11 06:06:40', '2026-05-11 06:06:40'),
(59, 21, 2, 'In Progress', 'In Progress', 'Ticket assigned to das', '2026-05-11 06:06:42', '2026-05-11 06:06:42'),
(60, 22, 2, 'Pending', 'In Progress', 'status_updated', '2026-05-11 06:15:45', '2026-05-11 06:15:45'),
(61, 22, 2, 'In Progress', 'Pending', 'status_updated', '2026-05-11 06:16:14', '2026-05-11 06:16:14'),
(62, 21, 2, 'In Progress', 'In Progress', 'Assigned to: jopfreynatao', '2026-05-11 06:21:08', '2026-05-11 06:21:08'),
(63, 21, 8, 'In Progress', 'Resolved', 'resolved', '2026-05-11 06:25:52', '2026-05-11 06:25:52'),
(64, 21, 8, 'Resolved', 'In Progress', 'status_updated', '2026-05-11 06:26:09', '2026-05-11 06:26:09'),
(65, 22, 2, NULL, 'In Progress', 'Ticket assigned to jopfreynatao', '2026-05-11 06:30:02', '2026-05-11 06:30:02'),
(66, 22, 2, NULL, 'In Progress', 'Ticket assigned to das', '2026-05-11 06:30:45', '2026-05-11 06:30:45'),
(67, 22, 2, NULL, 'In Progress', 'Ticket assigned to jopfreynatao', '2026-05-11 06:30:47', '2026-05-11 06:30:47'),
(68, 22, 2, NULL, 'In Progress', 'Ticket assigned to das', '2026-05-11 06:36:01', '2026-05-11 06:36:01'),
(69, 22, 2, NULL, 'In Progress', 'Ticket assigned to geoffrey', '2026-05-11 06:36:02', '2026-05-11 06:36:02'),
(70, 22, 2, NULL, 'Pending', 'Staff member removed. Ticket is now Unassigned.', '2026-05-11 06:36:04', '2026-05-11 06:36:04'),
(71, 22, 3, 'Pending', 'Cancelled', 'User cancelled the ticket', '2026-05-11 06:38:41', '2026-05-11 06:38:41'),
(72, 20, 3, 'Pending', 'Cancelled', 'User cancelled the ticket', '2026-05-11 06:40:36', '2026-05-11 06:40:36'),
(73, 9, 3, 'Pending', 'Cancelled', 'User cancelled the ticket', '2026-05-11 06:42:02', '2026-05-11 06:42:02'),
(74, 8, 3, 'Pending', 'Cancelled', 'User cancelled the ticket', '2026-05-11 06:42:05', '2026-05-11 06:42:05'),
(75, 23, 3, 'Pending', 'Cancelled', 'System Trigger: Ticket marked as Cancelled', '2026-05-12 01:24:30', '2026-05-12 01:24:30'),
(76, 24, 2, NULL, 'In Progress', 'Ticket assigned to jopfreynatao', '2026-05-11 17:40:35', '2026-05-11 17:40:35'),
(77, 24, 2, 'In Progress', 'Resolved', 'resolved', '2026-05-11 17:40:40', '2026-05-11 17:40:40'),
(78, 24, 2, NULL, 'In Progress', 'Ticket assigned to das', '2026-05-11 18:00:36', '2026-05-11 18:00:36'),
(79, 24, 2, NULL, 'In Progress', 'Ticket assigned to geoffrey', '2026-05-11 18:00:38', '2026-05-11 18:00:38'),
(80, 23, 2, NULL, 'In Progress', 'Ticket assigned to jopfreynatao', '2026-05-11 18:01:22', '2026-05-11 18:01:22'),
(81, 24, 2, NULL, 'In Progress', 'Ticket assigned to das', '2026-05-11 18:01:39', '2026-05-11 18:01:39'),
(82, 22, 2, NULL, 'In Progress', 'Ticket assigned to das', '2026-05-11 18:01:41', '2026-05-11 18:01:41'),
(83, 24, 2, NULL, 'In Progress', 'Ticket assigned to jopfreynatao', '2026-05-11 18:08:41', '2026-05-11 18:08:41'),
(84, 24, 2, NULL, 'In Progress', 'Ticket assigned to geoffrey', '2026-05-11 18:08:42', '2026-05-11 18:08:42'),
(85, 24, 2, NULL, 'Pending', 'Staff member removed. Ticket is now Unassigned.', '2026-05-11 18:08:44', '2026-05-11 18:08:44'),
(86, 25, 3, 'Pending', 'Cancelled', 'System Trigger: Ticket marked as Cancelled', '2026-05-12 02:16:22', '2026-05-12 02:16:22'),
(87, 24, 3, 'Pending', 'Cancelled', 'System Trigger: Ticket marked as Cancelled', '2026-05-12 02:16:24', '2026-05-12 02:16:24'),
(88, 23, 8, 'In Progress', 'Resolved', 'resolved', '2026-05-11 18:16:46', '2026-05-11 18:16:46'),
(89, 27, 2, NULL, 'In Progress', 'Ticket assigned to jopfreynatao', '2026-05-19 14:26:02', '2026-05-19 14:26:02'),
(90, 26, 2, NULL, 'In Progress', 'Ticket assigned to geoffrey1', '2026-05-19 14:26:23', '2026-05-19 14:26:23'),
(91, 27, 8, 'In Progress', 'Resolved', 'resolved', '2026-05-19 14:27:02', '2026-05-19 14:27:02'),
(92, 27, 8, 'In Progress', 'In Progress', 'status_updated', '2026-05-19 16:10:07', '2026-05-19 16:10:07'),
(93, 27, 8, 'In Progress', 'Pending', 'status_updated', '2026-05-19 16:10:13', '2026-05-19 16:10:13'),
(94, 28, 2, NULL, 'In Progress', 'Ticket assigned to jopfreynatao', '2026-05-19 20:51:11', '2026-05-19 20:51:11'),
(95, 27, 3, 'Pending', 'Cancelled', 'System Trigger: Ticket marked as Cancelled', '2026-05-20 04:52:21', '2026-05-20 04:52:21'),
(96, 28, 8, 'In Progress', 'Resolved', 'resolved', '2026-05-19 22:21:55', '2026-05-19 22:21:55'),
(97, 29, 3, 'Pending', 'Cancelled', 'System: Ticket marked as Cancelled by user', '2026-05-20 17:20:11', '2026-05-20 17:20:11'),
(98, 29, 2, NULL, 'In Progress', 'Ticket assigned to jopfreynatao', '2026-05-20 17:33:34', '2026-05-20 17:33:34'),
(99, 30, 2, NULL, 'In Progress', 'Ticket assigned to das', '2026-05-20 17:45:40', '2026-05-20 17:45:40'),
(100, 27, 2, NULL, 'In Progress', 'Ticket assigned to das', '2026-05-20 17:51:26', '2026-05-20 17:51:26'),
(101, 27, 2, NULL, 'In Progress', 'Ticket assigned to jopfreynatao', '2026-05-20 17:51:27', '2026-05-20 17:51:27'),
(102, 28, 2, NULL, 'In Progress', 'Ticket assigned to dadasd', '2026-05-20 17:51:29', '2026-05-20 17:51:29'),
(103, 31, 2, NULL, 'In Progress', 'Ticket assigned to jopfreynatao', '2026-05-20 17:57:20', '2026-05-20 17:57:20'),
(104, 34, 26, 'Pending', 'In Progress', 'status_updated', '2026-05-20 21:24:12', '2026-05-20 21:24:12'),
(105, 34, 2, NULL, 'In Progress', 'Ticket assigned to bisaya', '2026-05-20 21:24:41', '2026-05-20 21:24:41'),
(106, 33, 2, NULL, 'In Progress', 'Ticket assigned to bisaya', '2026-05-20 21:24:42', '2026-05-20 21:24:42'),
(107, 32, 2, NULL, 'In Progress', 'Ticket assigned to bisaya', '2026-05-20 21:24:44', '2026-05-20 21:24:44'),
(108, 36, 8, 'Pending', 'In Progress', 'Status changed from Pending to In Progress', '2026-05-21 06:20:31', '2026-05-21 06:20:31'),
(109, 41, 8, 'Pending', 'In Progress', 'Status changed from Pending to In Progress', '2026-05-21 11:34:45', '2026-05-21 11:34:45'),
(110, 40, 3, 'Pending', 'Cancelled', 'Status changed from Pending to Cancelled', '2026-05-21 11:53:51', '2026-05-21 11:53:51'),
(111, 39, 3, 'Pending', 'Cancelled', 'Status changed from Pending to Cancelled', '2026-05-21 11:53:55', '2026-05-21 11:53:55'),
(112, 38, 3, 'Pending', 'Cancelled', 'Status changed from Pending to Cancelled', '2026-05-21 11:53:57', '2026-05-21 11:53:57'),
(113, 37, 3, 'Pending', 'Cancelled', 'Status changed from Pending to Cancelled', '2026-05-21 11:53:59', '2026-05-21 11:53:59'),
(114, 35, 3, 'Pending', 'Cancelled', 'Status changed from Pending to Cancelled', '2026-05-21 11:54:01', '2026-05-21 11:54:01');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'user',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `department_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `remember_token`, `created_at`, `updated_at`, `department_id`) VALUES
(1, 'Test User', 'test@example.com', '2026-05-09 00:30:41', '$2y$12$Kgbo.xuYbWTAgaj2SdWDGe7k6hxWmopfV2ZCQMwHm6VjOlum5dAiW', 'user', 'YH8DzsLv9j', '2026-05-09 00:30:41', '2026-05-09 00:30:41', NULL),
(2, 'Admin', 'admin@example.com', '2026-05-09 00:30:41', '$2y$12$tVRN64WbC/U2Zz2AQM8.ZOc4r.FGf7JiaGtH6NKiwaMBqWyKa3LP.', 'admin', 'J9bO2NCzNH6N9HFrD5YDBpdUSngYtl7z9Oh6jTlvkdOfkFQPH6OVwegu9a2y', '2026-05-09 00:30:41', '2026-05-09 00:30:41', NULL),
(3, 'geoffrey', 'geoffreydalisay8@gmail.com', '2026-05-09 00:32:22', '$2y$12$4/Zgip.4Iem4dKLTXao1rOiVGGVcyib7a626w1ccqWtTIWBZoxxLa', 'user', NULL, '2026-05-09 00:31:34', '2026-05-21 03:43:47', NULL),
(8, 'jopfreynatao', 'jopfrey@1', '2026-05-09 02:16:57', '$2y$12$93Kh330091FSpS.mG5kVyexEpkW6AjJpKsZr2bLd90ri5zuLPNqO2', 'staff', NULL, '2026-05-09 02:16:57', '2026-05-21 03:12:06', 3),
(9, 'das', 'geo@133', '2026-05-09 04:50:57', '$2y$12$c8H/iyoU.wRyvJQNS/EDQuclwFABHCnpUuEBGnG0rQQeLVmb3y1BS', 'staff', NULL, '2026-05-09 04:50:57', '2026-05-20 17:45:17', 2),
(18, 'dadasd', 'asdasdasdas@dasdasd', '2026-05-11 18:15:55', '$2y$12$3QSm1zaeBbyxPsDAi9UAaO4x8Msrbz0fmHAgAzZTAf6jMiZc.7IWm', 'staff', NULL, '2026-05-11 18:15:55', '2026-05-20 16:46:36', 1),
(19, 'geoffrey2', 'geoffrey@123', '2026-05-19 14:18:59', '$2y$12$leP2qbSfxl2xcsIHMsxNRucC.x96/mEW2z8G6JqS.LQE4ZvOqfTzW', 'staff', NULL, '2026-05-19 14:18:59', '2026-05-20 16:46:38', 1),
(20, '312321', '32132@1221321', '2026-05-19 16:20:44', '$2y$12$CB3mZSeijP82HutG12pqIO5j9OZJBFOwFqTZ6RuvW9OV.Kq6r5JIy', 'staff', NULL, '2026-05-19 16:20:44', '2026-05-20 16:46:42', 1),
(21, 'jop24', 'jop@24', '2026-05-19 22:25:29', '$2y$12$aEU4yrK4obZQBQiuaPH5AOB49I77yDJ6ZBcIuisP8O3.FTVwxHFhi', 'staff', NULL, '2026-05-19 22:25:29', '2026-05-20 16:46:45', 1),
(22, '312312', '3213213@312321', '2026-05-20 16:30:57', '$2y$12$AL9wlfIqFyyhg8hEZzbDGu13iUw1SVxrcXPgoj4nzicjYeYOVCUg2', 'staff', NULL, '2026-05-20 16:30:57', '2026-05-20 16:39:02', 1),
(23, 'geoffrey', '312321321321321@321', '2026-05-20 16:34:08', '$2y$12$1Nde4pn7ABWCXbZ/kvkCCONfecJ3PMXX62pxRbyqeOBRaLP3DBHw.', 'staff', NULL, '2026-05-20 16:34:08', '2026-05-20 16:44:03', 1),
(24, 'dadasdsadsa', 'asdasdsasad22@312312', '2026-05-20 16:40:28', '$2y$12$mrbkGrw3SI782Uh.BxPd5Ob1AOgOkrzJ/XRVM0bp3pmC296ymTn9e', 'staff', NULL, '2026-05-20 16:40:28', '2026-05-20 16:40:28', 1),
(25, '32132132131', '32132132@321321', '2026-05-20 16:44:17', '$2y$12$FyoS0KUWTdjY3gw4GqwKl.q.5iU2YiuW.dNbB2sdc4n7772A11cCS', 'staff', NULL, '2026-05-20 16:44:17', '2026-05-20 16:44:17', 1),
(26, 'bisaya', 'dalisay@1', '2026-05-20 21:20:31', '$2y$12$62uRnp1cPSqNLk3FYncT9.g8XFR/WqxGWpZSYi8e.LcPWhD9A.H1a', 'staff', NULL, '2026-05-20 21:20:31', '2026-05-20 21:20:31', 1),
(27, 'dasdasda', '321321321@3123', '2026-05-21 03:12:01', '$2y$12$x49S9hmps3ea16EQSOhW1eU59rPxaAX.d1AdKeM7QikwI6OWe9cJO', 'staff', NULL, '2026-05-21 03:12:01', '2026-05-21 03:12:01', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attachments`
--
ALTER TABLE `attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attachments_ticket_id_foreign` (`ticket_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_ticket_id_foreign` (`ticket_id`),
  ADD KEY `comments_user_id_foreign` (`user_id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

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
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tickets_user_id_foreign` (`user_id`),
  ADD KEY `tickets_assigned_to_foreign` (`assigned_to`),
  ADD KEY `tickets_department_id_foreign` (`department_id`);

--
-- Indexes for table `ticket_histories`
--
ALTER TABLE `ticket_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticket_histories_ticket_id_foreign` (`ticket_id`),
  ADD KEY `ticket_histories_user_id_foreign` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_department_id_foreign` (`department_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attachments`
--
ALTER TABLE `attachments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `ticket_histories`
--
ALTER TABLE `ticket_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attachments`
--
ALTER TABLE `attachments`
  ADD CONSTRAINT `attachments_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_assigned_to_foreign` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `tickets_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `tickets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ticket_histories`
--
ALTER TABLE `ticket_histories`
  ADD CONSTRAINT `ticket_histories_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ticket_histories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
