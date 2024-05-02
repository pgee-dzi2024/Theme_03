-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Време на генериране:  2 май 2024 в 20:57
-- Версия на сървъра: 10.4.32-MariaDB
-- Версия на PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данни: `dzi_03`
--

-- --------------------------------------------------------

--
-- Структура на таблица `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(1, 'CUSTOMER');

-- --------------------------------------------------------

--
-- Структура на таблица `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add feedback', 7, 'add_feedback'),
(26, 'Can change feedback', 7, 'change_feedback'),
(27, 'Can delete feedback', 7, 'delete_feedback'),
(28, 'Can view feedback', 7, 'view_feedback'),
(29, 'Can add product', 8, 'add_product'),
(30, 'Can change product', 8, 'change_product'),
(31, 'Can delete product', 8, 'delete_product'),
(32, 'Can view product', 8, 'view_product'),
(33, 'Can add customer', 9, 'add_customer'),
(34, 'Can change customer', 9, 'change_customer'),
(35, 'Can delete customer', 9, 'delete_customer'),
(36, 'Can view customer', 9, 'view_customer'),
(37, 'Can add orders', 10, 'add_orders'),
(38, 'Can change orders', 10, 'change_orders'),
(39, 'Can delete orders', 10, 'delete_orders'),
(40, 'Can view orders', 10, 'view_orders');

-- --------------------------------------------------------

--
-- Структура на таблица `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$blEfvss3JTGmPy4Lak2lnk$UHWijmrCp6L9ZI6g3JgZ9zA+JY6pjHA29FVbZW11bsE=', '2024-05-02 18:53:29.639481', 1, 'admin', '', '', '', 1, 1, '2024-02-22 13:41:00.000000'),
(2, 'pbkdf2_sha256$600000$PK1epsqql0DNmSZF4E8FjS$/OCFpNFId2Uslaj+Kokp28fwQzx7JXWoLZ920dvtB0o=', '2024-05-02 18:55:48.719426', 0, 'customer1', 'Иван', 'Петров', '', 0, 1, '2024-04-28 20:09:26.786362'),
(3, 'pbkdf2_sha256$600000$pPpL6GEHOVlIQKgRuZPrWU$zJCo7t8u0RG+TiQfImyKoyqyXfKyqAUtVuUAYA/Qi3A=', '2024-04-30 18:02:02.159765', 0, 'customer2', 'Елена', 'Петрова', '', 0, 1, '2024-04-30 18:01:44.204411');

-- --------------------------------------------------------

--
-- Структура на таблица `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `auth_user_groups`
--

INSERT INTO `auth_user_groups` (`id`, `user_id`, `group_id`) VALUES
(1, 2, 1),
(2, 3, 1);

-- --------------------------------------------------------

--
-- Структура на таблица `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2024-04-28 20:35:36.404311', '1', 'admin', 2, '[]', 4, 1),
(2, '2024-04-28 20:48:45.112121', '1', 'Иван', 2, '[{\"changed\": {\"fields\": [\"Profile pic\"]}}]', 9, 1),
(3, '2024-04-29 15:26:27.726184', '1', 'Иван', 2, '[{\"changed\": {\"fields\": [\"Profile pic\"]}}]', 9, 1),
(4, '2024-04-29 15:26:50.081021', '1', 'Рокля', 2, '[{\"changed\": {\"fields\": [\"Product image\"]}}]', 8, 1);

-- --------------------------------------------------------

--
-- Структура на таблица `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(9, 'main', 'customer'),
(7, 'main', 'feedback'),
(10, 'main', 'orders'),
(8, 'main', 'product'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Структура на таблица `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-02-22 13:15:16.822966'),
(2, 'auth', '0001_initial', '2024-02-22 13:15:17.411978'),
(3, 'admin', '0001_initial', '2024-02-22 13:15:17.534382'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-02-22 13:15:17.542924'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-02-22 13:15:17.551124'),
(6, 'contenttypes', '0002_remove_content_type_name', '2024-02-22 13:15:17.654177'),
(7, 'auth', '0002_alter_permission_name_max_length', '2024-02-22 13:15:17.716225'),
(8, 'auth', '0003_alter_user_email_max_length', '2024-02-22 13:15:17.729754'),
(9, 'auth', '0004_alter_user_username_opts', '2024-02-22 13:15:17.736411'),
(10, 'auth', '0005_alter_user_last_login_null', '2024-02-22 13:15:17.806601'),
(11, 'auth', '0006_require_contenttypes_0002', '2024-02-22 13:15:17.809666'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2024-02-22 13:15:17.816625'),
(13, 'auth', '0008_alter_user_username_max_length', '2024-02-22 13:15:17.829063'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2024-02-22 13:15:17.839384'),
(15, 'auth', '0010_alter_group_name_max_length', '2024-02-22 13:15:17.852424'),
(16, 'auth', '0011_update_proxy_permissions', '2024-02-22 13:15:17.859447'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2024-02-22 13:15:17.870738'),
(18, 'sessions', '0001_initial', '2024-02-22 13:15:17.906910'),
(19, 'main', '0001_initial', '2024-04-28 18:22:29.592694'),
(20, 'main', '0002_alter_customer_id_alter_feedback_id_alter_orders_id_and_more', '2024-04-28 20:36:36.106427'),
(21, 'main', '0003_product_for_sale_product_is_new_and_more', '2024-05-01 17:02:04.166752'),
(22, 'main', '0004_alter_orders_status', '2024-05-02 17:45:31.336529'),
(23, 'main', '0005_alter_orders_status', '2024-05-02 18:27:17.503371');

-- --------------------------------------------------------

--
-- Структура на таблица `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('8wpjd4xfzm000gnn49eaj0akexuzsik9', 'e30:1s1FYW:CAw67NxT0WxmBfgmVXT5d-gtuGBIyY2LbcHNnX-N9No', '2024-05-13 01:11:44.622037'),
('l6j8zzp0eb1rg3mvmvgwmxtxhc3ypklp', '.eJxVjEEOwiAQRe_C2hCghZm6dO8ZCDCDVA0kpV0Z765NutDtf-_9l_BhW4vfOi9-JnEWRpx-txjSg-sO6B7qrcnU6rrMUe6KPGiX10b8vBzu30EJvXzrDGQTJnCB8ogDDDxBHJXKbAbt0JFJKToLBpnA5mA0IEbU4CZgjkq8P-kWN8c:1s2bau:X7NVhOKffOO6db2P5AQcuyWmXmfnj6n2q8ZMd7uaZY4', '2024-05-16 18:55:48.727053'),
('pyejx59ux8cgje6jpoh44xh5z24lvcbc', '.eJxVjEEOwiAQRe_C2hCghZm6dO8ZCDCDVA0kpV0Z765NutDtf-_9l_BhW4vfOi9-JnEWRpx-txjSg-sO6B7qrcnU6rrMUe6KPGiX10b8vBzu30EJvXzrDGQTJnCB8ogDDDxBHJXKbAbt0JFJKToLBpnA5mA0IEbU4CZgjkq8P-kWN8c:1s1x2p:7c1y-2-Pd3YvCWy6xvEOV_rlYID79QHL5KFIWuNvwDQ', '2024-05-14 23:37:55.243507');

-- --------------------------------------------------------

--
-- Структура на таблица `main_customer`
--

DROP TABLE IF EXISTS `main_customer`;
CREATE TABLE `main_customer` (
  `id` bigint(20) NOT NULL,
  `profile_pic` varchar(100) DEFAULT NULL,
  `address` varchar(40) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `main_customer`
--

INSERT INTO `main_customer` (`id`, `profile_pic`, `address`, `mobile`, `user_id`) VALUES
(1, 'profile_pic/img1-small.jpg', 'Банско', '123', 2),
(2, 'profile_pic/img2-large.jpg', 'Гр. Град, ул. Улица 25', '123456789', 3);

-- --------------------------------------------------------

--
-- Структура на таблица `main_feedback`
--

DROP TABLE IF EXISTS `main_feedback`;
CREATE TABLE `main_feedback` (
  `id` bigint(20) NOT NULL,
  `name` varchar(40) NOT NULL,
  `feedback` varchar(500) NOT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `main_orders`
--

DROP TABLE IF EXISTS `main_orders`;
CREATE TABLE `main_orders` (
  `id` bigint(20) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `main_orders`
--

INSERT INTO `main_orders` (`id`, `email`, `address`, `mobile`, `order_date`, `status`, `customer_id`, `product_id`) VALUES
(1, 'ggborikov@abv.bg', '123 321', '173', '2024-05-02', 'Приета', 1, 1),
(2, 'ggborikov@abv.bg', '123 321', '173', '2024-05-02', 'Нова', 1, 3),
(3, 'abc@abv.bg', 'sda das asda', '123', '2024-05-02', 'Нова', 1, 1),
(4, 'abv@abv.bg', 'asd', '123', '2024-05-02', 'Обработва се', 1, 1),
(5, 'aaa@abv.bg', 'xcx asda', '121231', '2024-05-02', 'Изпратена', 1, 1);

-- --------------------------------------------------------

--
-- Структура на таблица `main_product`
--

DROP TABLE IF EXISTS `main_product`;
CREATE TABLE `main_product` (
  `id` bigint(20) NOT NULL,
  `name` varchar(40) NOT NULL,
  `product_image` varchar(100) DEFAULT NULL,
  `price` int(10) UNSIGNED NOT NULL CHECK (`price` >= 0),
  `description` varchar(40) NOT NULL,
  `for_sale` tinyint(1) DEFAULT NULL,
  `is_new` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `main_product`
--

INSERT INTO `main_product` (`id`, `name`, `product_image`, `price`, `description`, `for_sale`, `is_new`) VALUES
(1, 'Рокля', 'product_image/model1.jpg', 88, 'Тъмна къса рокля', 0, 1),
(2, 'Комплект блуза и жилетка', 'product_image/model7.jpg', 120, 'комплект от 100% естествена вълна', 0, 1),
(3, 'Рокля', 'product_image/model5.jpg', 77, 'Лятна рокля. 100% лен', 1, 0);

--
-- Indexes for dumped tables
--

--
-- Индекси за таблица `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Индекси за таблица `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Индекси за таблица `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Индекси за таблица `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Индекси за таблица `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Индекси за таблица `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Индекси за таблица `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Индекси за таблица `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Индекси за таблица `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Индекси за таблица `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Индекси за таблица `main_customer`
--
ALTER TABLE `main_customer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Индекси за таблица `main_feedback`
--
ALTER TABLE `main_feedback`
  ADD PRIMARY KEY (`id`);

--
-- Индекси за таблица `main_orders`
--
ALTER TABLE `main_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_orders_customer_id_da6e5113_fk` (`customer_id`),
  ADD KEY `main_orders_product_id_6e94c960_fk` (`product_id`);

--
-- Индекси за таблица `main_product`
--
ALTER TABLE `main_product`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `main_customer`
--
ALTER TABLE `main_customer`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `main_feedback`
--
ALTER TABLE `main_feedback`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_orders`
--
ALTER TABLE `main_orders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `main_product`
--
ALTER TABLE `main_product`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ограничения за дъмпнати таблици
--

--
-- Ограничения за таблица `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Ограничения за таблица `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Ограничения за таблица `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения за таблица `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения за таблица `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения за таблица `main_customer`
--
ALTER TABLE `main_customer`
  ADD CONSTRAINT `main_customer_user_id_19b4dfa5_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения за таблица `main_orders`
--
ALTER TABLE `main_orders`
  ADD CONSTRAINT `main_orders_customer_id_da6e5113_fk` FOREIGN KEY (`customer_id`) REFERENCES `main_customer` (`id`),
  ADD CONSTRAINT `main_orders_product_id_6e94c960_fk` FOREIGN KEY (`product_id`) REFERENCES `main_product` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
