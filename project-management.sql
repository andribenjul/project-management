-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 29, 2018 at 07:11 AM
-- Server version: 10.1.32-MariaDB
-- PHP Version: 7.2.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project-management`
--

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2017_08_19_154835_create_projects_table', 1),
(4, '2017_08_19_154845_create_tasks_table', 1),
(5, '2017_09_01_105033_create_task_files_table', 1),
(8, '2018_05_06_140740_create_comments_table', 2),
(9, '2018_10_06_040308_create_permission_tables', 2);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_permissions`
--

INSERT INTO `model_has_permissions` (`permission_id`, `model_type`, `model_id`) VALUES
(2, 'App\\User', 5),
(2, 'App\\User', 16),
(3, 'App\\User', 5),
(3, 'App\\User', 16),
(4, 'App\\User', 5),
(5, 'App\\User', 5),
(5, 'App\\User', 16),
(5, 'App\\User', 18),
(6, 'App\\User', 5),
(6, 'App\\User', 16),
(7, 'App\\User', 5),
(7, 'App\\User', 16),
(8, 'App\\User', 5),
(9, 'App\\User', 5),
(9, 'App\\User', 16),
(9, 'App\\User', 18),
(10, 'App\\User', 5),
(10, 'App\\User', 16),
(11, 'App\\User', 5),
(11, 'App\\User', 16),
(12, 'App\\User', 5),
(13, 'App\\User', 5),
(13, 'App\\User', 16),
(13, 'App\\User', 18),
(14, 'App\\User', 16),
(15, 'App\\User', 16),
(17, 'App\\User', 16),
(17, 'App\\User', 18);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\User', 5),
(2, 'App\\User', 16),
(3, 'App\\User', 18);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('demo@test.com', '$2y$10$trLK/QtXrW2asuC7hhLLYun3LJLxnoc1pfs4vIdx4quyV663cBZGq', '2017-10-22 23:10:20');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, '', 'web', '2018-10-26 09:46:29', '2018-10-26 09:46:29'),
(2, 'add user', 'web', '2018-10-26 09:46:59', '2018-10-26 09:46:59'),
(3, 'edit user', 'web', '2018-10-26 09:47:07', '2018-10-26 09:47:07'),
(4, 'delete user', 'web', '2018-10-26 09:47:15', '2018-10-26 09:47:15'),
(5, 'view user', 'web', '2018-10-26 09:47:24', '2018-10-26 09:47:24'),
(6, 'add order', 'web', '2018-10-26 10:01:13', '2018-10-26 10:01:13'),
(7, 'edit order', 'web', '2018-10-26 10:01:20', '2018-10-26 10:01:20'),
(8, 'delete order', 'web', '2018-10-26 10:01:31', '2018-10-26 10:01:31'),
(9, 'view order', 'web', '2018-10-26 10:01:40', '2018-10-26 10:01:40'),
(10, 'add task', 'web', '2018-10-26 10:01:50', '2018-10-26 10:01:50'),
(11, 'edit task', 'web', '2018-10-26 10:01:56', '2018-10-26 10:01:56'),
(12, 'delete task', 'web', '2018-10-26 10:02:03', '2018-10-26 10:02:03'),
(13, 'view task', 'web', '2018-10-26 10:02:11', '2018-10-26 10:02:11'),
(14, 'add project', 'web', '2018-10-28 17:42:30', '2018-10-28 17:42:30'),
(15, 'edit project', 'web', '2018-10-28 17:42:42', '2018-10-28 17:42:42'),
(16, 'delete project', 'web', '2018-10-28 17:42:51', '2018-10-28 17:42:51'),
(17, 'view project', 'web', '2018-10-28 17:43:00', '2018-10-28 17:43:00');

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` int(10) UNSIGNED NOT NULL,
  `project_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `project_name`, `created_at`, `updated_at`) VALUES
(9, 'Kaos Pak Firman', '2018-10-02 14:16:05', '2018-10-02 14:16:05'),
(10, 'Project 1', '2018-10-03 21:15:09', '2018-10-03 21:15:09'),
(11, 'Project 2', '2018-10-03 21:15:18', '2018-10-03 21:15:18'),
(12, 'Project 3', '2018-10-03 21:15:25', '2018-10-03 21:15:25'),
(13, 'Project 4', '2018-10-03 21:15:32', '2018-10-03 21:15:32'),
(14, 'Project 5', '2018-10-03 21:15:44', '2018-10-03 21:15:44'),
(15, 'Project 6', '2018-10-03 21:15:50', '2018-10-03 21:15:50'),
(16, 'Project 7', '2018-10-03 21:15:58', '2018-10-03 21:15:58'),
(17, 'Project 8', '2018-10-03 21:16:07', '2018-10-03 21:16:07'),
(18, 'Project 9', '2018-10-03 21:16:13', '2018-10-03 21:16:13'),
(19, 'Project 10', '2018-10-03 21:20:10', '2018-10-03 21:20:10'),
(21, 'kaos', '2018-10-24 10:25:39', '2018-10-24 10:25:39');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', '2018-10-26 09:46:29', '2018-10-26 09:46:29'),
(2, 'kabag', 'web', '2018-10-26 09:46:41', '2018-10-26 09:46:41'),
(3, 'user', 'web', '2018-10-26 09:46:46', '2018-10-26 09:46:46');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(1, 2),
(1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `project_id` int(10) UNSIGNED NOT NULL,
  `task_title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `task` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `priority` int(11) NOT NULL DEFAULT '0',
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `duedate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `user_id`, `project_id`, `task_title`, `task`, `priority`, `completed`, `created_at`, `updated_at`, `duedate`) VALUES
(60, 18, 9, 'Task 13', '<p>t</p>', 0, 1, '2018-10-03 21:38:28', '2018-10-25 09:19:14', '2018-10-04 03:38:21'),
(61, 1, 9, 'Task 14', 'r', 0, 1, '2018-10-03 21:38:39', '2018-10-17 07:29:54', '2018-10-04 03:38:33'),
(62, 1, 9, 'Task 15', 't', 0, 1, '2018-10-03 21:38:50', '2018-10-17 07:29:55', '2018-10-04 03:38:43'),
(63, 1, 9, 'Task 16', 'ser', 0, 1, '2018-10-03 21:39:32', '2018-10-20 09:04:07', '2018-10-04 03:39:21'),
(64, 1, 9, 'Taks 17', 't', 0, 1, '2018-10-03 21:39:44', '2018-10-20 09:04:06', '2018-10-04 03:39:36'),
(65, 1, 9, 'task 18', 'task', 0, 1, '2018-10-03 21:39:56', '2018-10-20 09:04:05', '2018-10-04 03:39:48'),
(66, 1, 9, 'task 19', 'er', 0, 1, '2018-10-03 21:40:07', '2018-10-20 09:04:04', '2018-10-04 03:40:00'),
(67, 1, 9, 'Task 90', 'wer', 0, 1, '2018-10-03 21:40:31', '2018-10-20 09:04:03', '2018-10-04 03:40:22');

-- --------------------------------------------------------

--
-- Table structure for table `task_files`
--

CREATE TABLE `task_files` (
  `id` int(10) UNSIGNED NOT NULL,
  `task_id` int(10) UNSIGNED NOT NULL,
  `filename` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `admin`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 0, 'Not Assigned', 'not@assigned.com', '', NULL, NULL, NULL),
(5, 1, 'Admin', 'admin@app.com', '$2y$10$w5XMKVAOUl95uQdxrF3PuOCHZrnqZwT38jFw4RtZBp8lWblUsoz6W', '381XBIT4hDTuRe9lDr8QtbDPu0KcO120GVDivLBEd6aDRrs7NfDLb2fHiFSc', '2017-08-29 12:08:01', '2018-10-28 19:06:52'),
(16, 1, 'Kepala Bagian', 'kabag@app.com', '$2y$10$BsSpyJ2rzMS8T0QxASn6VeO1B22W/EWZGcIuDdslfUSA9iiiEVcOW', '1GHvqP6RLFOFfv5QnFqjDCnrjKf3hMPag6PGkltUMnFyBPJIJhY6p3of6KRK', '2018-10-02 14:17:42', '2018-10-25 09:36:26'),
(18, 1, 'Karyawan 1', 'karyawan1@app.com', '$2y$10$pTOk3gFaw2EyaFTt2V3va.IVl8lIuvnq4U208K3wpMss672ermSN6', 'RYXdAV61Wxn6050E01qrql1x4hxlLwfXjQtmLYXFf8cSPNMVJIPaov8z2UDQ', '2018-10-25 08:59:49', '2018-10-25 08:59:49'),
(19, 1, 'Karyawan 2', 'karyawan2@app.com', '$2y$10$j6EEZkvSNoVEsPEQ0bi5yOX1Ra0uApi.JQCfJh5VpsGZ77oPkRz0G', NULL, '2018-10-28 19:02:05', '2018-10-28 19:02:05');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_user_id_index` (`user_id`),
  ADD KEY `comments_task_id_index` (`task_id`),
  ADD KEY `comments_parent_id_index` (`parent_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tasks_project_id_foreign` (`project_id`),
  ADD KEY `tasks_user_id_foreign` (`user_id`);

--
-- Indexes for table `task_files`
--
ALTER TABLE `task_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_files_task_id_foreign` (`task_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `task_files`
--
ALTER TABLE `task_files`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tasks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `task_files`
--
ALTER TABLE `task_files`
  ADD CONSTRAINT `task_files_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
