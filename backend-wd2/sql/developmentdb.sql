-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Apr 22, 2025 at 07:53 AM
-- Server version: 11.6.2-MariaDB-ubu2404
-- PHP Version: 8.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `developmentdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `complaints`
--

CREATE TABLE `complaints` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `complaints`
--

INSERT INTO `complaints` (`id`, `user_id`, `description`, `created_at`) VALUES
(5, 6, 'Leaking water pipe in the basement.', '2025-04-20 14:54:10'),
(6, 6, 'Leaking water pipe in the basement.', '2025-04-20 15:02:41'),
(10, 4, 'Noisy neighbor on the second floor late at night.', '2025-04-21 10:15:00'),
(11, 6, 'Elevator not working since yesterday.', '2025-04-21 10:30:00'),
(12, 7, 'Broken light in the hallway near apartment 5C.', '2025-04-21 11:00:00'),
(13, 8, 'Overflowing trash bins near the entrance.', '2025-04-21 11:30:00'),
(14, 13, 'Water pressure too low in the shower.', '2025-04-21 12:00:00'),
(15, 14, 'Parking spot blocked by unknown vehicle.', '2025-04-21 12:30:00'),
(16, 16, 'Smoke smell in the corridor.', '2025-04-21 13:00:00'),
(17, 22, 'Front door lock seems loose and unsafe.', '2025-04-21 13:30:00'),
(18, 27, 'Wi-Fi in the common room is not working.', '2025-04-21 14:00:00'),
(19, 31, 'Gym equipment is broken or missing parts.', '2025-04-21 14:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `event_date` datetime NOT NULL,
  `location` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `title`, `description`, `event_date`, `location`, `created_at`) VALUES
(1, 'Community BBQ', 'Join us for a neighborhood BBQ!', '2025-07-15 17:00:00', 'Community Park', '2025-03-18 15:09:42'),
(2, 'Annual Meeting', 'Discuss community updates and future plans.', '2025-08-20 19:00:00', 'Clubhouse', '2025-03-18 15:09:42'),
(8, 'Movie Night', 'Outdoor screening of a family-friendly film. Bring your blankets!', '2025-06-10 20:30:00', 'Courtyard Lawn', '2025-04-21 15:30:00'),
(9, 'Clean-Up Day', 'Join us to tidy up the shared spaces. Supplies provided.', '2025-05-18 10:00:00', 'Main Entrance', '2025-04-21 15:31:00'),
(10, 'Yoga in the Park', 'Free yoga session for all levels. Bring your mat!', '2025-06-22 09:00:00', 'Community Park', '2025-04-21 15:32:00'),
(11, 'Book Club Meetup', 'Discuss this month\'s book over coffee and snacks.', '2025-05-30 18:00:00', 'Clubhouse Lounge', '2025-04-21 15:33:00'),
(12, 'Game Night', 'Board games, snacks, and fun with neighbors!', '2025-07-05 19:00:00', 'Clubhouse', '2025-04-21 15:34:00'),
(13, 'Ice Cream Social', 'Cool off with free ice cream and music.', '2025-08-01 15:00:00', 'Poolside', '2025-04-21 15:35:00'),
(14, 'Craft Workshop', 'Learn how to make DIY crafts. Materials included.', '2025-06-28 14:00:00', 'Community Hall', '2025-04-21 15:36:00'),
(15, 'Pet Parade', 'Show off your pets and meet other furry friends.', '2025-09-10 16:00:00', 'Park Pavilion', '2025-04-21 15:37:00');

-- --------------------------------------------------------

--
-- Table structure for table `parking_spots`
--

CREATE TABLE `parking_spots` (
  `id` int(11) NOT NULL,
  `spot_number` varchar(10) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status` enum('available','reserved','occupied') NOT NULL DEFAULT 'available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `parking_spots`
--

INSERT INTO `parking_spots` (`id`, `spot_number`, `user_id`, `status`) VALUES
(1, 'A1', 16, 'occupied'),
(2, 'A2', 19, 'reserved'),
(3, 'B1', 22, 'reserved'),
(54, '1', 18, 'occupied'),
(55, '2', 4, 'occupied'),
(56, '3', 6, 'reserved'),
(57, '4', 13, 'available'),
(58, '5', 8, 'reserved'),
(59, '6', 40, 'occupied'),
(60, '7', 32, 'occupied'),
(61, '8', 30, 'reserved'),
(62, '9', 20, 'available'),
(63, '10', 39, 'occupied'),
(64, '11', 4, 'available'),
(65, '12', 6, 'reserved'),
(66, '13', 7, 'available'),
(67, '14', 8, 'available'),
(68, '15', 36, 'reserved'),
(69, '16', 24, 'reserved'),
(70, '17', 17, 'occupied'),
(71, '18', 21, 'available'),
(72, '19', 38, 'reserved'),
(73, '20', 4, 'occupied'),
(74, '21', 6, 'available'),
(75, '22', 7, 'reserved'),
(76, '23', 8, 'available'),
(77, '24', 17, 'occupied'),
(78, '25', 17, 'reserved'),
(79, '26', 17, 'available'),
(80, '27', 17, 'available'),
(81, '28', 17, 'reserved'),
(82, '29', 4, 'occupied'),
(83, '30', 6, 'reserved'),
(84, '31', 7, 'available'),
(85, '32', 8, 'available'),
(86, '33', 17, 'occupied'),
(87, '34', 17, 'available'),
(88, '35', 17, 'reserved'),
(89, '36', 17, 'occupied'),
(90, '37', 17, 'available'),
(91, '38', 4, 'reserved'),
(92, '39', 6, 'reserved'),
(93, '40', 7, 'available'),
(94, '41', 8, 'reserved'),
(95, '42', 17, 'reserved'),
(96, '43', 17, 'available'),
(97, '44', 17, 'occupied'),
(98, '45', 17, 'reserved'),
(99, '46', 17, 'available'),
(100, '47', 4, 'occupied'),
(101, '48', 6, 'reserved'),
(102, '49', 7, 'available'),
(103, '50', 8, 'occupied');

-- --------------------------------------------------------

--
-- Table structure for table `recommendations`
--

CREATE TABLE `recommendations` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `recommendations`
--

INSERT INTO `recommendations` (`id`, `title`, `user_id`, `content`, `created_at`) VALUES
(14, 'Sunset Beach', 4, 'A hidden gem on the outskirts of town. Beautiful sunsets and peaceful atmosphere. Perfect for evening walks.', '2025-04-20 14:37:48'),
(15, 'The Greenhouse Bistro', 6, 'A modern bistro with a beautiful garden setting. Try the seasonal salads and the signature homemade lemonade!', '2025-04-20 14:37:48'),
(16, 'Mountain View Park', 7, 'A park with breathtaking views of the mountains. Perfect for a weekend hike or a relaxing picnic.', '2025-04-20 14:37:48'),
(20, 'The Royal Garden', 4, 'A beautiful royal garden with exotic plants and flowers. Ideal for photography and nature walks.', '2025-04-20 14:37:48'),
(21, 'Old Town Café', 6, 'A charming café located in an old building. They have the best croissants and vintage décor!', '2025-04-20 14:37:48'),
(22, 'Echo Valley', 7, 'A peaceful valley perfect for nature lovers. It’s quiet and serene, ideal for a solo getaway or a family picnic.', '2025-04-20 14:37:48');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','bewoner','lid') NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `created_at`) VALUES
(4, 'm Brown', 'm@example.com', '$2y$12$rEf9Y9upBzoRHcpSNf3hJuGVgl9wZJLdZ0cJ4tpXScKRcorWzG/P.', 'admin', '2025-04-20 13:42:16'),
(6, 'w Brown', 'w@example.com', '$2y$12$qmiAl4E2rkl1BfQncyLwPOOAy9nNbPzJv3SxmtOm6J4AcE0YapApO', 'bewoner', '2025-04-20 13:52:13'),
(7, 'n', 'n@n.com', '$2y$12$ZGXXkdVpxIeaxHA8GSqiW.FMe6sMFcU6nA9tALnNxhQ64753usCku', 'bewoner', '2025-04-20 13:52:26'),
(8, 'a', 'a@c.nl', '$2y$12$riPauezTKOhALH33xryoeONYqYFpLGx2UoSdrkAvEIf8.pRE2wsF2', 'bewoner', '2025-04-20 17:12:51'),
(13, 'admin', 'admin@admin.com', '$2y$12$2RTaz9F0w4KDnMaOyiMiWebJUUmErXuxFncybTbn8xLKCOz0YeVhm', 'admin', '2025-04-21 13:14:34'),
(14, 'user', 'user@user.com', '$2y$12$A3nG2w5YPlmYAccSHUbP8uiUo.k.pVn64rid9wIWHNuCyKaUIcWIm', 'bewoner', '2025-04-21 13:15:29'),
(15, 'test', 'test@test.com', '$2y$12$.geRNF7TU8MH2Gf/1fUDFOki4EP/jfXD2wHDaW9.vvxmW1v976lni', 'lid', '2025-04-21 13:15:50'),
(16, 'Alice Smith', 'alice@example.com', '$2y$12$KZFbZ63gl4m.c/b.JybG9.Cxx1q7HRD20y4a9q3lZXsS3zDl4qDYi', 'bewoner', '2025-04-21 13:30:57'),
(17, 'Bob Jones', 'bob@example.com', '$2y$12$Pvxjl8y32LxwnljUEnRFM.KyZ2xXYVDvwF/kEZl2ECq9myAoDEwse', 'lid', '2025-04-21 13:30:57'),
(18, 'Carol White', 'carol@example.com', '$2y$12$M9v.M0a7gD7Fu7A7E1tQuOBmHkcrRMElclgHKFyrZnMNjcZtOKvYq', 'bewoner', '2025-04-21 13:30:57'),
(19, 'David Lee', 'david@example.com', '$2y$12$YxZ86iTEyujvlFyPeZXqguplGQz4m8mEzxHKDoaPavO2W9WtdNUVu', 'admin', '2025-04-21 13:30:57'),
(20, 'Eva Brown', 'eva@example.com', '$2y$12$JSdoRoPQFeucGk8WWpS7z.3Wp7Q7PVZoUGns0h6k7S0ZEdS2rttGS', 'bewoner', '2025-04-21 13:30:57'),
(21, 'Frank Wilson', 'frank@example.com', '$2y$12$LU9YI7r5Tn7iXIN6GgA5EOJ4geZBRbYZAcTT9SNg9YO8cmEnLf1sy', 'lid', '2025-04-21 13:30:57'),
(22, 'Grace Kim', 'grace@example.com', '$2y$12$zxF7o0hPU7PY3MFdVoXrAe/9o1HDOTzCnxINxuUFKB2u9dZTjDP4S', 'bewoner', '2025-04-21 13:30:57'),
(23, 'Henry Clark', 'henry@example.com', '$2y$12$goDQRD1aHg5QUA6MNnOeE.2ogXNNEixemPvKFx0c91iHCQG4s1Lme', 'lid', '2025-04-21 13:30:57'),
(24, 'Ivy Adams', 'ivy@example.com', '$2y$12$5K.7OeEd2y5wIAV.jTA9MeW1mcQy0ExIRdph8zrN1e9O/EaSTq7X2', 'bewoner', '2025-04-21 13:30:57'),
(25, 'Jack Hill', 'jack@example.com', '$2y$12$MpV/tXDnCdxy1SvDh9w4EeINRL1De9QvJ5gi7AG/Ho0MyJNaRKO7O', 'admin', '2025-04-21 13:30:57'),
(26, 'Kate Young', 'kate@example.com', '$2y$12$9UnbX5KPVmvVGeE5EK3JYO43YOljZkYmXiUczruWzXt1PfivR2XK2', 'bewoner', '2025-04-21 13:30:57'),
(27, 'Liam Baker', 'liam@example.com', '$2y$12$emAVZHOEGzomItxLEfZKx.wLmjfVkqDyd.KG3NlgKRTyUI.f5PjTC', 'lid', '2025-04-21 13:30:57'),
(28, 'Mia Scott', 'mia@example.com', '$2y$12$Zglp.Lm8wT6MbiEKUnmOCeZzQAS66jOet9bKZnk.7SpGfP7QKDCr6', 'bewoner', '2025-04-21 13:30:57'),
(29, 'Noah Allen', 'noah@example.com', '$2y$12$FWmM7BKHRekN1AqZCUihQe46CAXKnPZ3wX5Sw3kz6zERaI2CyCkkO', 'admin', '2025-04-21 13:30:57'),
(30, 'Olivia Turner', 'olivia@example.com', '$2y$12$7zz.MNU.8Ql3NHfx1N.JXOUP78O7gh2Ut.VE9nYgYqN2UioVVgnNe', 'lid', '2025-04-21 13:30:57'),
(31, 'Paul Walker', 'paul@example.com', '$2y$12$9RWpghTssyHdhQ3ZVO4kkO1kaIVj9NW/JdQdFmdR5YJh5de2UV37G', 'bewoner', '2025-04-21 13:30:57'),
(32, 'Quinn Rivera', 'quinn@example.com', '$2y$12$9yFdYKr63CszTVg2Fkq1ee/OwXUm7nBPq1M2YSEY0zplmgEL8IB9u', 'bewoner', '2025-04-21 13:30:57'),
(33, 'Ruby Perez', 'ruby@example.com', '$2y$12$fdv4m99BQROJuUBUL8w7SOaBFeOH7eMBYABK9GeALYm3ukB.Tvvfa', 'lid', '2025-04-21 13:30:57'),
(34, 'Sam Cooper', 'sam@example.com', '$2y$12$WucU8GPdcD0B2ZMiS6Es/ud9NbdJG6Sqs4UxeE3cWf2Ff97W5nIdK', 'bewoner', '2025-04-21 13:30:57'),
(35, 'Tina Brooks', 'tina@example.com', '$2y$12$9ge8IXwDVL5BzwfP7TSCgOieOVTJNd5StF9exm8An96ZhEefkKq1C', 'bewoner', '2025-04-21 13:30:57'),
(36, 'Uma Foster', 'uma@example.com', '$2y$12$TnSOvXMbZItOxxCLs2rFluMZlgVZnZ2F/jFTKHe7HyKkErPvZLvoa', 'lid', '2025-04-21 13:30:57'),
(37, 'Victor Diaz', 'victor@example.com', '$2y$12$6ZDbn41MAbPI0Uahdr9Tx.B6nTDddPFegrckFS4xUMAoZqCCqBiS6', 'admin', '2025-04-21 13:30:57'),
(38, 'Wendy Torres', 'wendy@example.com', '$2y$12$gDbTzKczBZ72IQjAwULP3uP7N5MEQAGni/Ocq4yRZ1BtktnMXY1uq', 'bewoner', '2025-04-21 13:30:57'),
(39, 'Xavier Reed', 'xavier@example.com', '$2y$12$meYatQFwCgKUXvcc6TLm7.J8MZDei61XhpeKRYykewb12OS3UvYoK', 'lid', '2025-04-21 13:30:57'),
(40, 'Yara Morgan', 'yara@example.com', '$2y$12$7DPzI/F3Lw7g4gxZ5nA4Ce1RJUzmnAgj7JdeIZCc/2cgN6BzDvhqW', 'bewoner', '2025-04-21 13:30:57');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `complaints`
--
ALTER TABLE `complaints`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `parking_spots`
--
ALTER TABLE `parking_spots`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `spot_number` (`spot_number`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `recommendations`
--
ALTER TABLE `recommendations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `complaints`
--
ALTER TABLE `complaints`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `parking_spots`
--
ALTER TABLE `parking_spots`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT for table `recommendations`
--
ALTER TABLE `recommendations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `complaints`
--
ALTER TABLE `complaints`
  ADD CONSTRAINT `complaints_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `parking_spots`
--
ALTER TABLE `parking_spots`
  ADD CONSTRAINT `parking_spots_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `recommendations`
--
ALTER TABLE `recommendations`
  ADD CONSTRAINT `recommendations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
