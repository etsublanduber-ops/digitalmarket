-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 18, 2026 at 09:19 AM
-- Server version: 10.11.16-MariaDB
-- PHP Version: 8.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `digital_marketplace`
--

-- --------------------------------------------------------

--
-- Table structure for table `app_settings`
--

CREATE TABLE `app_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_settings`
--

INSERT INTO `app_settings` (`id`, `setting_key`, `setting_value`, `updated_at`) VALUES
(1, 'site_name', 'Digital Marketplace', '2026-11-13 23:43:26'),
(2, 'site_email', '', '2026-11-13 23:43:26'),
(3, 'site_phone', '', '2026-11-13 23:43:26'),
(4, 'currency', 'ETB', '2026-11-13 23:43:26'),
(5, 'min_withdrawal', '300', '2026-11-13 23:43:26');

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `action` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `commissions`
--

CREATE TABLE `commissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `affiliate_id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `order_item_id` int(10) UNSIGNED NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `status` enum('pending','approved','reversed') NOT NULL DEFAULT 'pending',
  `approved_by` int(10) UNSIGNED DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `commissions`
--

INSERT INTO `commissions` (`id`, `affiliate_id`, `order_id`, `order_item_id`, `amount`, `status`, `approved_by`, `approved_at`, `created_at`) VALUES
(1, 1, 2, 2, 50.00, 'approved', 2, '2026-11-14 02:28:55', '2026-11-13 23:19:56');

-- --------------------------------------------------------

--
-- Table structure for table `daily_commission_logs`
--

CREATE TABLE `daily_commission_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `schedule_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `commission_date` date NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `wallet_id` int(10) UNSIGNED NOT NULL,
  `balance_after` decimal(15,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `daily_commission_logs`
--

INSERT INTO `daily_commission_logs` (`id`, `schedule_id`, `user_id`, `commission_date`, `amount`, `wallet_id`, `balance_after`, `created_at`) VALUES
(1, 1, 1, '2026-11-14', 25.00, 2, 25.00, '2026-11-13 21:34:38');

-- --------------------------------------------------------

--
-- Table structure for table `daily_commission_schedules`
--

CREATE TABLE `daily_commission_schedules` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `order_item_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `purchase_price` decimal(15,2) NOT NULL,
  `daily_rate` decimal(5,2) NOT NULL DEFAULT 5.00,
  `duration_days` smallint(5) UNSIGNED NOT NULL DEFAULT 365,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` enum('active','completed','paused') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `daily_commission_schedules`
--

INSERT INTO `daily_commission_schedules` (`id`, `user_id`, `order_id`, `order_item_id`, `product_id`, `purchase_price`, `daily_rate`, `duration_days`, `start_date`, `end_date`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 2, 500.00, 5.00, 365, '2026-11-14', '2027-11-13', 'active', '2026-11-13 21:30:32', '2026-11-13 21:30:32'),
(2, 3, 2, 2, 2, 500.00, 5.00, 365, '2026-11-15', '2027-11-14', 'active', '2026-11-13 23:19:56', '2026-11-13 23:19:56');

-- --------------------------------------------------------

--
-- Table structure for table `deposits`
--

CREATE TABLE `deposits` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `payment_method_id` int(10) UNSIGNED NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `transaction_id` varchar(150) NOT NULL,
  `proof_path` varchar(255) DEFAULT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `admin_note` text DEFAULT NULL,
  `reviewed_by` int(10) UNSIGNED DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `deposits`
--

INSERT INTO `deposits` (`id`, `user_id`, `payment_method_id`, `amount`, `transaction_id`, `proof_path`, `status`, `admin_note`, `reviewed_by`, `reviewed_at`, `created_at`) VALUES
(1, 1, 3, 10000.00, 'fyugyugf', 'uploads/deposit_proofs/3d0178f056659b1c87ce4941a978864c9d17a142.jpg', 'approved', NULL, 2, '2026-11-13 22:08:49', '2026-11-13 19:08:06'),
(2, 3, 3, 200.00, 'fyugyugfe', 'uploads/deposit_proofs/faa5c653a2a511005f25d45b3c2e318b687b158f.jpg', 'approved', NULL, 2, '2026-11-14 02:07:05', '2026-11-13 23:03:02'),
(3, 1, 2, 500.00, 'dfhgbkhbgukjdf', 'uploads/deposit_proofs/b52e47e1cf1a97ad36acf1eb1cc49b27e8bbe32c.jpg', 'approved', NULL, 2, '2026-11-18 00:05:35', '2026-11-18 08:04:50');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_number` varchar(50) NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED DEFAULT NULL,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `unit_price` decimal(15,2) NOT NULL DEFAULT 0.00,
  `affiliate_id` int(10) UNSIGNED DEFAULT NULL,
  `referral_code` varchar(30) DEFAULT NULL,
  `total_amount` decimal(15,2) NOT NULL,
  `payment_method` varchar(50) NOT NULL DEFAULT 'wallet',
  `payment_status` varchar(30) NOT NULL DEFAULT 'pending',
  `status` enum('pending','completed','cancelled','refunded') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `completed_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `order_number`, `user_id`, `product_id`, `quantity`, `unit_price`, `affiliate_id`, `referral_code`, `total_amount`, `payment_method`, `payment_status`, `status`, `created_at`, `completed_at`, `updated_at`) VALUES
(1, 'DM-20261113204623-31DC33', 1, 2, 1, 500.00, NULL, NULL, 500.00, 'wallet', 'paid', 'completed', '2026-11-13 19:46:23', '2026-11-13 22:46:23', '2026-11-13 19:46:23'),
(2, 'DM-20261114001956-683A03', 3, 2, 1, 500.00, 1, 'DMFC87CAAC', 500.00, 'wallet', 'paid', 'completed', '2026-11-13 23:19:56', '2026-11-14 02:19:56', '2026-11-13 23:19:56');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `unit_price` decimal(15,2) NOT NULL,
  `commission_rate` decimal(5,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `unit_price`, `commission_rate`, `created_at`) VALUES
(1, 1, 2, 1, 500.00, 10.00, '2026-11-13 19:46:23'),
(2, 2, 2, 1, 500.00, 10.00, '2026-11-13 23:19:56');

-- --------------------------------------------------------

--
-- Table structure for table `payment_methods`
--

CREATE TABLE `payment_methods` (
  `id` int(10) UNSIGNED NOT NULL,
  `method_name` varchar(100) NOT NULL,
  `account_name` varchar(150) DEFAULT NULL,
  `account_number` varchar(100) DEFAULT NULL,
  `instructions` text DEFAULT NULL,
  `method_type` enum('deposit','withdrawal','both') NOT NULL DEFAULT 'both',
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_methods`
--

INSERT INTO `payment_methods` (`id`, `method_name`, `account_name`, `account_number`, `instructions`, `method_type`, `status`, `created_at`) VALUES
(1, 'Telebirr', 'Digital Mareket Company', '0904210279', 'Send the deposit amount to this Telebirr number. Enter your transaction ID when submitting the deposit request.', 'both', 'active', '2026-11-13 18:59:50'),
(2, 'CBE', 'Your Business Name', '1000476278264', 'Transfer the deposit amount to this CBE account and submit your transaction reference.', 'both', 'active', '2026-11-13 19:00:46'),
(3, 'Telebirr', 'DigitalMarket Company', '0907765474', 'Transfer the deposit to this Telebirr account and enter your transaction ID.', 'both', 'active', '2026-11-13 19:05:37');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(15,2) NOT NULL,
  `commission_rate` decimal(5,2) NOT NULL DEFAULT 0.00,
  `image_path` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `product_name`, `description`, `price`, `commission_rate`, `image_path`, `file_path`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Watch', 'u can purchase', 500.00, 10.00, 'storage/products/uploads/images/6940580ac3ff427586eaf0af4a30ae131f9ac3db.jpg', 'storage/products/uploads/files/2ac1e03acb78b255d90d11000e55d9bd2be54430.jpg', 'active', '2026-11-13 19:38:38', '2026-11-18 08:15:25'),
(2, 'Watch', 'you can buy', 500.00, 10.00, 'storage/products/uploads/images/82867b1f3263f026da7220c184ec431667503a49.jpg', 'storage/products/uploads/files/c7f99357654cf52abdaf2c780a6034beb77c2560.jpg', 'active', '2026-11-13 19:39:35', '2026-11-16 16:39:54'),
(3, 'Watch', '', 1000.00, 0.00, NULL, 'storage/products/uploads/files/cfeaeec689d17343145aaaa69c94b369c7bc116f.jpg', 'inactive', '2026-11-16 16:49:00', '2026-11-16 16:56:54'),
(5, 'phone', 'phone', 500.00, 5.00, 'storage/products/uploads/images/374faba8cc234d872d3d42cd312f8c8b84d3fea7.jpg', 'storage/products/uploads/files/0e35e8697de2a205917506eb0f9b0cb320665c46.jpg', 'active', '2026-11-18 08:16:50', '2026-11-18 08:16:50');

-- --------------------------------------------------------

--
-- Table structure for table `product_access`
--

CREATE TABLE `product_access` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `granted_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_access`
--

INSERT INTO `product_access` (`id`, `user_id`, `product_id`, `order_id`, `granted_at`) VALUES
(1, 1, 2, 1, '2026-11-13 19:46:24'),
(2, 3, 2, 2, '2026-11-13 23:19:56');

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` varchar(255) NOT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`id`, `setting_key`, `setting_value`, `updated_at`) VALUES
(1, 'minimum_deposit', '500', '2026-11-13 10:44:21'),
(2, 'minimum_withdrawal', '300', '2026-11-13 10:44:21'),
(3, 'currency', 'ETB', '2026-11-13 10:44:21'),
(4, 'platform_name', 'Digital Marketplace', '2026-11-13 10:44:21');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `username` varchar(60) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `status` enum('active','inactive','suspended') NOT NULL DEFAULT 'active',
  `referral_code` varchar(30) NOT NULL,
  `referred_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `username`, `email`, `phone`, `password`, `role`, `status`, `referral_code`, `referred_by`, `created_at`, `updated_at`) VALUES
(1, 'elias asresagn', 'elias', 'eliasasresagn@gmail.com', '+251935378293', '$2y$12$RkA7qZvUh9RmcvqfTXnsdeUKEf1VQfrasVTReM4Mp1zJktZ6ZaYdu', 'user', 'active', 'DMFC87CAAC', NULL, '2026-11-13 10:58:35', '2026-11-18 08:03:44'),
(2, 'Tobel Muluneh Fufa', 'Tobel', 'eliasasresagn2@gmail.com', '0935378293', '$2y$12$E0H4RD542D9JbRMoJqZicegLNlLXNuNtLE8k9vPotme6/ZhZMP7oW', 'admin', 'active', 'ADM51BF373C', NULL, '2026-11-13 11:19:04', '2026-11-13 11:19:04'),
(3, 'kayof  Negaro', 'kayof', 'eliasasresagn3@gmail.com', '0935378299', '$2y$12$7irtyIlywlm6tQHfdAHZguc3UFacIYBU7wgs9D2.oZpCML5N2xdO2', 'user', 'active', 'DM52AB36C6', 1, '2026-11-13 22:59:01', '2026-11-18 08:02:50');

-- --------------------------------------------------------

--
-- Table structure for table `user_payment_accounts`
--

CREATE TABLE `user_payment_accounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `account_type` enum('Telebirr','CBE') NOT NULL,
  `account_name` varchar(150) NOT NULL,
  `account_number` varchar(50) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_payment_accounts`
--

INSERT INTO `user_payment_accounts` (`id`, `user_id`, `account_type`, `account_name`, `account_number`, `is_default`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Telebirr', 'Elias Asresagn Gizaw', '0935378293', 1, 'active', '2026-11-13 18:33:27', '2026-11-13 18:33:27');

-- --------------------------------------------------------

--
-- Table structure for table `wallet_accounts`
--

CREATE TABLE `wallet_accounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `wallet_type` enum('purchase','commission') NOT NULL,
  `balance` decimal(15,2) NOT NULL DEFAULT 0.00,
  `reserved_balance` decimal(15,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wallet_accounts`
--

INSERT INTO `wallet_accounts` (`id`, `user_id`, `wallet_type`, `balance`, `reserved_balance`, `created_at`, `updated_at`) VALUES
(1, 1, 'purchase', 700.00, 0.00, '2026-11-13 10:58:35', '2026-11-18 08:05:35'),
(2, 1, 'commission', 75.00, 0.00, '2026-11-13 10:58:35', '2026-11-13 23:28:55'),
(3, 3, 'purchase', 0.00, 0.00, '2026-11-13 22:59:01', '2026-11-13 23:19:56'),
(4, 3, 'commission', 0.00, 0.00, '2026-11-13 22:59:01', '2026-11-13 22:59:01');

-- --------------------------------------------------------

--
-- Table structure for table `wallet_transactions`
--

CREATE TABLE `wallet_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `wallet_id` int(10) UNSIGNED NOT NULL,
  `transaction_type` enum('credit','debit','reserve','release') NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `balance_after` decimal(15,2) NOT NULL,
  `reference_type` varchar(50) NOT NULL,
  `reference_id` bigint(20) UNSIGNED NOT NULL,
  `idempotency_key` varchar(150) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wallet_transactions`
--

INSERT INTO `wallet_transactions` (`id`, `wallet_id`, `transaction_type`, `amount`, `balance_after`, `reference_type`, `reference_id`, `idempotency_key`, `description`, `created_at`) VALUES
(1, 1, 'credit', 1000.00, 0.00, 'deposit', 1, '', 'Manual deposit approved. Transaction: fyugyugf', '2026-11-13 19:08:49'),
(2, 1, 'reserve', 300.00, 1000.00, 'withdrawal', 1, 'withdrawal_reserve_1', 'Withdrawal request #1', '2026-11-13 19:28:07'),
(3, 1, 'debit', 500.00, 500.00, 'order', 1, 'purchase_order_1', 'Purchase of eloas', '2026-11-13 19:46:24'),
(4, 2, 'credit', 25.00, 25.00, 'daily_commission', 1, 'daily_commission_1_2026-11-14', 'Daily product commission (5.00%)', '2026-11-13 21:34:38'),
(5, 1, 'debit', 300.00, 200.00, 'withdrawal', 1, 'withdrawal_paid_1', 'Withdrawal payment completed', '2026-11-13 22:09:04'),
(6, 1, 'reserve', 200.00, 200.00, 'withdrawal', 2, 'withdrawal_reserve_2_purchase', 'Withdrawal request #2 (purchase)', '2026-11-13 22:29:01'),
(7, 2, 'reserve', 25.00, 25.00, 'withdrawal', 2, 'withdrawal_reserve_2_commission', 'Withdrawal request #2 (commission)', '2026-11-13 22:29:01'),
(8, 1, 'release', 200.00, 200.00, 'withdrawal', 2, 'withdrawal_release_2_1', 'Reserved funds released after withdrawal rejection', '2026-11-13 22:39:03'),
(9, 2, 'release', 25.00, 25.00, 'withdrawal', 2, 'withdrawal_release_2_2', 'Reserved funds released after withdrawal rejection', '2026-11-13 22:39:03'),
(11, 3, 'credit', 500.00, 500.00, 'deposit', 2, 'deposit_approval_2', 'Manual deposit approved. Transaction: fyugyugfe', '2026-11-13 23:07:05'),
(12, 3, 'debit', 500.00, 0.00, 'order', 2, 'purchase_order_2', 'Purchase of eloas', '2026-11-13 23:19:56'),
(13, 2, 'credit', 50.00, 75.00, 'commission', 1, 'commission_credit_1', 'Referral commission approved for order #2', '2026-11-13 23:28:55'),
(14, 1, 'credit', 500.00, 700.00, 'deposit', 3, 'deposit_approval_3', 'Manual deposit approved. Transaction: dfhgbkhbgukjdf', '2026-11-18 08:05:35');

-- --------------------------------------------------------

--
-- Table structure for table `withdrawals`
--

CREATE TABLE `withdrawals` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `wallet_type` enum('purchase','commission') NOT NULL DEFAULT 'commission',
  `amount` decimal(15,2) NOT NULL,
  `payment_method_id` int(10) UNSIGNED NOT NULL,
  `account_details` text NOT NULL,
  `status` enum('pending','approved','rejected','paid','refunded') NOT NULL DEFAULT 'pending',
  `admin_note` text DEFAULT NULL,
  `reviewed_by` int(10) UNSIGNED DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `payment_reference` varchar(150) DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `withdrawals`
--

INSERT INTO `withdrawals` (`id`, `user_id`, `wallet_type`, `amount`, `payment_method_id`, `account_details`, `status`, `admin_note`, `reviewed_by`, `reviewed_at`, `payment_reference`, `paid_at`, `created_at`) VALUES
(1, 1, 'purchase', 300.00, 1, 'Account type: Telebirr | Account name: Elias Asresagn Gizaw | Account number: 0935378293 | Payment method: Telebirr', 'paid', 'c', 2, '2026-11-14 01:09:04', 'vg', '2026-11-14 01:09:04', '2026-11-13 19:28:07'),
(2, 1, 'purchase', 225.00, 1, 'Account type: Telebirr | Account name: Elias Asresagn Gizaw | Account number: 0935378293 | Payment method: Telebirr | Wallet allocation: Purchase: 200.00 ETB, Commission: 25.00 ETB', 'rejected', NULL, 2, '2026-11-14 01:39:03', NULL, NULL, '2026-11-13 22:29:01');

-- --------------------------------------------------------

--
-- Table structure for table `withdrawal_wallet_allocations`
--

CREATE TABLE `withdrawal_wallet_allocations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `withdrawal_id` int(10) UNSIGNED NOT NULL,
  `wallet_id` int(10) UNSIGNED NOT NULL,
  `wallet_type` enum('purchase','commission') NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `withdrawal_wallet_allocations`
--

INSERT INTO `withdrawal_wallet_allocations` (`id`, `withdrawal_id`, `wallet_id`, `wallet_type`, `amount`, `created_at`) VALUES
(1, 2, 1, 'purchase', 200.00, '2026-11-13 22:29:01'),
(2, 2, 2, 'commission', 25.00, '2026-11-13 22:29:01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `app_settings`
--
ALTER TABLE `app_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_setting_key` (`setting_key`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_audit_user` (`user_id`),
  ADD KEY `idx_audit_created` (`created_at`);

--
-- Indexes for table `commissions`
--
ALTER TABLE `commissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_item_affiliate` (`affiliate_id`,`order_item_id`),
  ADD KEY `fk_commission_order` (`order_id`),
  ADD KEY `fk_commission_item` (`order_item_id`),
  ADD KEY `fk_commission_admin` (`approved_by`),
  ADD KEY `idx_commission_status` (`status`);

--
-- Indexes for table `daily_commission_logs`
--
ALTER TABLE `daily_commission_logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_schedule_commission_date` (`schedule_id`,`commission_date`),
  ADD KEY `idx_daily_log_user` (`user_id`),
  ADD KEY `idx_daily_log_date` (`commission_date`);

--
-- Indexes for table `daily_commission_schedules`
--
ALTER TABLE `daily_commission_schedules`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_daily_schedule_order_item` (`order_item_id`),
  ADD KEY `idx_daily_schedule_due` (`status`,`start_date`,`end_date`),
  ADD KEY `idx_daily_schedule_user` (`user_id`);

--
-- Indexes for table `deposits`
--
ALTER TABLE `deposits`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transaction_id` (`transaction_id`),
  ADD KEY `fk_deposit_method` (`payment_method_id`),
  ADD KEY `fk_deposit_admin` (`reviewed_by`),
  ADD KEY `idx_deposit_status` (`status`),
  ADD KEY `idx_deposit_user` (`user_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_notification_user` (`user_id`,`is_read`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `fk_order_affiliate` (`affiliate_id`),
  ADD KEY `idx_order_status` (`status`),
  ADD KEY `idx_order_user` (`user_id`),
  ADD KEY `idx_order_product` (`product_id`),
  ADD KEY `idx_payment_status` (`payment_status`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_item_product` (`product_id`),
  ADD KEY `idx_item_order` (`order_id`);

--
-- Indexes for table `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_product_status` (`status`);

--
-- Indexes for table `product_access`
--
ALTER TABLE `product_access`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_product_order` (`user_id`,`product_id`,`order_id`),
  ADD KEY `fk_access_product` (`product_id`),
  ADD KEY `fk_access_order` (`order_id`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `referral_code` (`referral_code`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `fk_users_referrer` (`referred_by`);

--
-- Indexes for table `user_payment_accounts`
--
ALTER TABLE `user_payment_accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_payment_accounts` (`user_id`);

--
-- Indexes for table `wallet_accounts`
--
ALTER TABLE `wallet_accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_wallet` (`user_id`,`wallet_type`);

--
-- Indexes for table `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idempotency_key` (`idempotency_key`),
  ADD KEY `idx_wallet_transaction` (`wallet_id`,`created_at`),
  ADD KEY `idx_wallet_reference` (`reference_type`,`reference_id`);

--
-- Indexes for table `withdrawals`
--
ALTER TABLE `withdrawals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_withdrawal_method` (`payment_method_id`),
  ADD KEY `fk_withdrawal_admin` (`reviewed_by`),
  ADD KEY `idx_withdrawal_status` (`status`),
  ADD KEY `idx_withdrawal_user` (`user_id`);

--
-- Indexes for table `withdrawal_wallet_allocations`
--
ALTER TABLE `withdrawal_wallet_allocations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_withdrawal_wallet` (`withdrawal_id`,`wallet_id`),
  ADD KEY `idx_withdrawal_id` (`withdrawal_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `app_settings`
--
ALTER TABLE `app_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commissions`
--
ALTER TABLE `commissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `daily_commission_logs`
--
ALTER TABLE `daily_commission_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `daily_commission_schedules`
--
ALTER TABLE `daily_commission_schedules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `deposits`
--
ALTER TABLE `deposits`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `product_access`
--
ALTER TABLE `product_access`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_payment_accounts`
--
ALTER TABLE `user_payment_accounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `wallet_accounts`
--
ALTER TABLE `wallet_accounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `withdrawals`
--
ALTER TABLE `withdrawals`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `withdrawal_wallet_allocations`
--
ALTER TABLE `withdrawal_wallet_allocations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `fk_audit_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `commissions`
--
ALTER TABLE `commissions`
  ADD CONSTRAINT `fk_commission_admin` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_commission_affiliate` FOREIGN KEY (`affiliate_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_commission_item` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`id`),
  ADD CONSTRAINT `fk_commission_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Constraints for table `deposits`
--
ALTER TABLE `deposits`
  ADD CONSTRAINT `fk_deposit_admin` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_deposit_method` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`),
  ADD CONSTRAINT `fk_deposit_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_notification_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_order_affiliate` FOREIGN KEY (`affiliate_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_item_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `fk_item_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `product_access`
--
ALTER TABLE `product_access`
  ADD CONSTRAINT `fk_access_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `fk_access_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `fk_access_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_referrer` FOREIGN KEY (`referred_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `user_payment_accounts`
--
ALTER TABLE `user_payment_accounts`
  ADD CONSTRAINT `fk_user_payment_accounts_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `wallet_accounts`
--
ALTER TABLE `wallet_accounts`
  ADD CONSTRAINT `fk_wallet_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  ADD CONSTRAINT `fk_transaction_wallet` FOREIGN KEY (`wallet_id`) REFERENCES `wallet_accounts` (`id`);

--
-- Constraints for table `withdrawals`
--
ALTER TABLE `withdrawals`
  ADD CONSTRAINT `fk_withdrawal_admin` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_withdrawal_method` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`),
  ADD CONSTRAINT `fk_withdrawal_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
