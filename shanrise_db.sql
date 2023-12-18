-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: localhost    Database: learning_express
-- ------------------------------------------------------
-- Server version	8.0.35-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Token`
--

DROP TABLE IF EXISTS `Token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Token` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `userId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires` datetime(3) NOT NULL,
  `revoked` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  UNIQUE KEY `Token_token_key` (`token`),
  KEY `Token_userId_fkey` (`userId`),
  CONSTRAINT `Token_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Token`
--

LOCK TABLES `Token` WRITE;
/*!40000 ALTER TABLE `Token` DISABLE KEYS */;
INSERT INTO `Token` VALUES ('06d09f0c-af30-4476-b0f6-d2739a68b529','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlYzVhNjNjNi00NzIwLTQ5NjktYjMxZS00MWYzNGUxZjA2OGIiLCJpYXQiOjE3MDI4Njk0MjQsImV4cCI6MTcwNTQ2MTQyNCwidHlwZSI6InJlZnJlc2gifQ.Tfb3E8HUVNKYYzTktKZyarikRdvfvn7CbpgLEUcTeGk','ec5a63c6-4720-4969-b31e-41f34e1f068b','refresh','2024-01-17 03:17:04.704',0,'2023-12-18 03:17:04.707','2023-12-18 03:17:04.707'),('c8ddbbc0-42c7-4089-a3ff-91c856a06a64','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlYzVhNjNjNi00NzIwLTQ5NjktYjMxZS00MWYzNGUxZjA2OGIiLCJpYXQiOjE3MDI4ODY2MzQsImV4cCI6MTcwNTQ3ODYzNCwidHlwZSI6InJlZnJlc2gifQ.9nuABRnj1ByFI6yPe93GmfyT3GGwJXy7gLuUYVFb0p0','ec5a63c6-4720-4969-b31e-41f34e1f068b','refresh','2024-01-17 08:03:54.020',0,'2023-12-18 08:03:54.036','2023-12-18 08:03:54.036');
/*!40000 ALTER TABLE `Token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isEmailVerified` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  UNIQUE KEY `User_name_key` (`name`),
  UNIQUE KEY `User_email_key` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES ('00159815-7ad8-4090-8213-e547d5a950a3','fake29','fake29@example.com','$2a$10$eKgZixWj6gmAUK6Pic82beUD4PllgUEcBfNmXHiO9T3gqWH4iS7wi','user',0,'2023-12-18 04:10:54.205','2023-12-18 04:10:54.205'),('017144ec-621f-4490-858c-fce2bce0161c','fake14','fake14@example.com','$2a$10$JbfX6uc4Llgp82U22rPCHesY9oYxSVnFb6MlkylxBo8GzmqrzjnB6','user',0,'2023-12-18 04:10:54.205','2023-12-18 04:10:54.205'),('019963b4-5ddc-4a52-b0c7-dbd65e95d968','fake24','fake24@example.com','$2a$10$0J.FLxLZx2apLHIgKOKGhe21qGAOJRCSmOheZ.7I4q5ii7yE34B.m','user',0,'2023-12-18 04:10:54.205','2023-12-18 04:10:54.205'),('0366ac12-8295-428c-9dd9-2c50ebd65a0c','fake22','fake22@example.com','$2a$10$y0XqM5NVc0OkENBrbaqk8enCohmC2mBKtRGG9WTkZjzvTfLMvd7hK','user',0,'2023-12-18 04:10:54.205','2023-12-18 04:10:54.205'),('0973b458-292a-4046-851f-27373721dda2','fake18','fake18@example.com','$2a$10$N6NAlDx47BJF5vBteqzydugCF0982CLEiHeqASJUjQz4unhrr3LOO','user',0,'2023-12-18 04:10:54.205','2023-12-18 04:10:54.205'),('14dfbc34-6128-4988-978f-b45456044163','fake43','fake43@example.com','$2a$10$zLFCRjC6u7zE9Jy6FhCULOj8S4vw9X5rMetHRhAM3qX4Noi07.loK','user',0,'2023-12-18 04:19:55.758','2023-12-18 04:19:55.758'),('198a4e78-4814-4859-b6a3-dfe3b004c79f','fake37','fake37@example.com','$2a$10$0ApCN5BXU1vMmBTc1ldpbO9FtDbp4NfykHSq5mU9fQ6MxlWeepGXC','user',0,'2023-12-18 04:19:55.758','2023-12-18 04:19:55.758'),('28444e9c-3649-4d9f-81d9-cf4d8589caf7','fake39','fake39@example.com','$2a$10$JRl7vIrxR16xiasCWFsDLeL8lVTh6x08GCbOLczGyCdZef9.AQfwK','user',0,'2023-12-18 04:19:55.758','2023-12-18 04:19:55.758'),('31739f13-acf6-4cdf-af29-686e8af981e5','fake10','fake10@example.com','$2a$10$GFgi69UUCuFY5GpsdcnjhuEFBiVh7dO8H/m8G3jxFUd4nVdR285sC','user',0,'2023-12-18 04:03:05.953','2023-12-18 04:03:05.953'),('31ec26e9-5688-4b89-891b-30e813e25a80','fake20','fake20@example.com','$2a$10$ipiVNbsgaq3oGE8TcKkjDupi6lLmg6xNa4sc3vnr8HC2PY9Dsptce','user',0,'2023-12-18 04:10:54.205','2023-12-18 04:10:54.205'),('3fb1832e-6d14-4f48-9cac-e324187bd5d8','fake7','fake7@example.com','$2a$10$v6j2LlXZw0v4/4FW3Sh.PeHgP0qWzpUzZG6tuthGdBDw3FOLcCBi2','user',0,'2023-12-18 04:02:38.160','2023-12-18 04:02:38.160'),('415214c0-e1d8-4a8a-9bdf-1884cf91a8fc','fake44','fake44@example.com','$2a$10$jVGrxd.S0HcFk8RGR07hpO/t.vGscwsMAoBu3qiQ1BxnTAAYGJ7em','user',0,'2023-12-18 04:19:55.758','2023-12-18 04:19:55.758'),('4454189d-ef05-4c5e-875b-fe60c783d4ae','fake32','fake32@example.com','$2a$10$sysgN44t1bNzcNUX231T3OHdQ5bz8gt5R87bXTW8Mka6jEiWj3hym','user',0,'2023-12-18 04:19:55.758','2023-12-18 04:19:55.758'),('4ddfbfad-376c-472a-99e5-7f2e553134a8','fake42','fake42@example.com','$2a$10$j7a6tuij6cyW9MuGN8vRIe/j2Zv7QfnG3o1ehTYX.kyd9JQGeEzp2','user',0,'2023-12-18 04:19:55.758','2023-12-18 04:19:55.758'),('4e84c210-de58-49a8-87dd-421cba88780e','fake36','fake36@example.com','$2a$10$trg4ZDMTrJ7i7PA.LIybL.Qy684eS5AXZdik1mfBdH97z.JIhwhCW','user',0,'2023-12-18 04:19:55.758','2023-12-18 04:19:55.758'),('580f6013-758b-4d72-a7f3-a9f9a9393ea5','fake40','fake40@example.com','$2a$10$ZNJsrJhc2qfVjp77cDrctehIEFjRwZdU3WlYu9Rh4AjcU.ZWbHrWC','user',0,'2023-12-18 04:19:55.758','2023-12-18 04:19:55.758'),('5930d4cb-01f4-4bcc-bc49-67bb8bf00d45','fake34','fake34@example.com','$2a$10$sPs7dZFF3dRnYRN8r0DogOZj63dy53dQaq/Ng.AzQADLwdnXo8382','user',0,'2023-12-18 04:19:55.758','2023-12-18 04:19:55.758'),('617b0941-b72c-48cc-b5de-00119bd7e735','fake45','fake45@example.com','$2a$10$r2sY8Oa0UyAQndlDlBKIVu5C2Bc2GKIqgzUx6K7vkmCNN437a9.mC','user',0,'2023-12-18 04:19:55.758','2023-12-18 04:19:55.758'),('6784a06d-0dce-4bcb-b681-b5432fcc7c0d','fake23','fake23@example.com','$2a$10$w/Br6hjpsYrpNbfJ6e.uauxwyDyc3GeTEwWT.nQiXZIb6.oMKJwou','user',0,'2023-12-18 04:10:54.205','2023-12-18 04:10:54.205'),('678cd0da-5022-477b-88cb-5c128f2834df','fake2','fake2@example.com','$2a$10$4wmZjl8fpw2DyGzpkN.WPOCDk87jVSbsuB1gW/ljX8aKXgDEDRuMi','user',0,'2023-12-18 02:52:16.363','2023-12-18 02:52:16.363'),('6ae60fbd-3b63-46a5-8327-05a764bc7c85','fake26','fake26@example.com','$2a$10$tnkPn772r3UwzUuFIbZ5E.DiPuRB6HR8ZQSJwgYJY1AsopZbvUSNi','user',0,'2023-12-18 04:10:54.205','2023-12-18 04:10:54.205'),('74c11777-268d-48a4-8b76-39cd98c5f297','fake47','fake47@example.com','$2a$10$G2Niw8dKCgA4IjKU/wz7Wut25SI3Zq8q07elWyNXCpGsahsu6yQ9W','user',0,'2023-12-18 04:19:55.758','2023-12-18 04:19:55.758'),('7faa070d-7739-499f-85c8-7b68e66920d9','fake41','fake41@example.com','$2a$10$LWHaqJRnPnHVBLoweDtLbeHTyhpK/z2vgIGo1r15R3Tt6EFVkbv2e','user',0,'2023-12-18 04:19:55.758','2023-12-18 04:19:55.758'),('8a8b2a12-5caa-47de-9fef-ea83826744ef','fake16','fake16@example.com','$2a$10$v79zNvqta8mUPktOJxbhk.yhbqRLlIv84QgY5axbOaLz29d7QXlXe','user',0,'2023-12-18 04:10:54.205','2023-12-18 04:10:54.205'),('8f8d442c-3ef9-408b-a90b-5515c2571698','fake27','fake27@example.com','$2a$10$SB6AmfHh/Yz8sSQTWW6yZeK6Wene6joTgpADwbcU4eR60842hiewu','user',0,'2023-12-18 04:10:54.205','2023-12-18 04:10:54.205'),('93960f6b-9c5b-4564-a84c-e32d7d211b71','fake38','fake38@example.com','$2a$10$bHHtcrPi.rrr22wUznvLbuaMHq.BBZ793rAnez3tPsATXTYqXjwZO','user',0,'2023-12-18 04:19:55.758','2023-12-18 04:19:55.758'),('98ffdc78-e927-4b8a-9723-76b48e357510','fake6','fake6@example.com','$2a$10$MzcwVLYEb8ODv6V03KTREe53P2CuBY6EMeh30mEWcrdbhw9Rniobm','user',0,'2023-12-18 04:02:28.516','2023-12-18 04:02:28.516'),('9a38f168-1bf2-4dfc-8b4c-b71d7a0b6918','fake15','fake15@example.com','$2a$10$tTKFjRaj8MxMCccEVnSC8OvrzfmT6D.jDb3OUVQu7rBUsYIkaMyJO','user',0,'2023-12-18 04:10:54.205','2023-12-18 04:10:54.205'),('9ee757d3-e955-474f-bef1-c791d8550d24','fake33','fake33@example.com','$2a$10$PE8TDk5UvUjLYG774Cfx/uArbxA/5Pq9Z1ZiN.293LzZpDB853Rre','user',0,'2023-12-18 04:19:55.758','2023-12-18 04:19:55.758'),('a24fdf07-e522-4047-9b70-c2cb0a3079f5','fake35','fake35@example.com','$2a$10$dRtlqO59Bykm/MimSqn7Kej0qyasijxnMDVWhPHMs2FMlCJhHpBUi','user',0,'2023-12-18 04:19:55.758','2023-12-18 04:19:55.758'),('aaf0261f-fd20-4a2a-90fb-ec7223f98db2','fake5','fake5@example.com','$2a$10$CXyY411CT8OS42yYC3ca8e3x.MWWfoeKcJE2eDtRWSYYANdCDH53e','user',0,'2023-12-18 04:01:49.542','2023-12-18 04:01:49.542'),('b7d0e97e-dd75-4420-8dc7-1a24d0248be0','fake21','fake21@example.com','$2a$10$2Ow5xn.jqoJEueDw5K7CrOWFz0RGhJb7BgIZeS77Uc.tQ2TQYT/Y6','user',0,'2023-12-18 04:10:54.205','2023-12-18 04:10:54.205'),('b943aff4-606c-436e-85dc-965c45739368','fake9','fake9@example.com','$2a$10$lDtkyzkpehOLzXYUvh7ju.91/a/EYRKKpO7pqjnpjW8j3mjZ2vpQu','user',0,'2023-12-18 04:02:58.437','2023-12-18 04:02:58.437'),('bc8440c8-c49a-497f-b4aa-8a3c7c8cd810','fake4','fake4@example.com','$2a$10$6JjeUk1bsM/VCEUbxIJetOnRivTJ2qCdWvib7XwdCmAqOnKd0pU6i','user',0,'2023-12-18 02:53:44.874','2023-12-18 02:53:44.874'),('bf134f61-1076-41b6-98e4-931a1262707d','fake12','fake12@example.com','$2a$10$LAPtg41MYZGkXbh7D7NjFODKDKnmkmvx9mQXG0ybIhmE8gVf/bZmO','user',0,'2023-12-18 04:03:27.557','2023-12-18 04:03:27.557'),('c5f33e2a-5eac-40b3-b4f1-f1c8e3e8dd63','fake17','fake17@example.com','$2a$10$zphveqCEt.J1EiJrjU7qU.SMhUebzsi9JMsxKJ5Z4PHf1EgIJ07Z2','user',0,'2023-12-18 04:10:54.205','2023-12-18 04:10:54.205'),('c616dd12-9965-440d-9cbd-189e9b811a5d','fake11','fake11@example.com','$2a$10$he6Fom7HWivKaZMhM8VSKehO1RMKbRARYbotnBXqNDEL02pqBUiva','user',0,'2023-12-18 04:03:19.861','2023-12-18 04:03:19.861'),('c7ae086e-6235-436f-abf5-1be295feb757','fake28','fake28@example.com','$2a$10$6uD3KdsfNocTHiy7KIPViuQOL20y5wU6RUDZspqxJNKQ7NI/N1dLy','user',0,'2023-12-18 04:10:54.205','2023-12-18 04:10:54.205'),('cda59257-853d-4bb6-9e39-374d3ab30969','fake19','fake19@example.com','$2a$10$ZDSVvz7RuJre2JtKi94t2uBJlki.BqdBtF9yg5RzwfZUXahe3q4OG','user',0,'2023-12-18 04:10:54.205','2023-12-18 04:10:54.205'),('cdcb4ec5-f81a-4d6a-889c-545bb55ef529','fake30','fake30@example.com','$2a$10$Vusr5n2xJ372JnOrBuImQ.Pa0zl8jUerR0TZ8eeRLZzfcA7vfYWN2','user',0,'2023-12-18 04:10:54.205','2023-12-18 04:10:54.205'),('cf29fe95-c6ea-41b3-9ab8-9ea58fa26e65','fake25','fake25@example.com','$2a$10$8rpot4GKtguyVTleAqq2ouEAad6ZCdd3qn0kwAt5CyOI5l23GgIOm','user',0,'2023-12-18 04:10:54.205','2023-12-18 04:10:54.205'),('e24f483c-646a-408c-8b18-f0e92c70096b','fake3','fake3@example.com','$2a$10$lEv1Xw/hubPTn6i/ZdfXm.o3YcblSUqFBpZsHR4x3Mn4ruKqRKQ7a','user',0,'2023-12-18 02:53:11.668','2023-12-18 02:53:11.668'),('e48abb9e-5b16-41a4-8fbb-3f80058508a0','fake46','fake46@example.com','$2a$10$UKQcr7xrl0lurbh8lehcqe47BUvPacUT34X7jdMtmX.C.F2pgxUKK','user',0,'2023-12-18 04:19:55.758','2023-12-18 04:19:55.758'),('ec5a63c6-4720-4969-b31e-41f34e1f068b','fake1','fake1example@gmail.com','$2a$10$gpn5XbJr8kRyuLAmUPmAf.LA2hD.ZzLuFiVU2lr87.0./Gvy2z9uS','admin',0,'2023-12-16 08:39:37.332','2023-12-16 08:39:37.332'),('f9339e91-bd53-4e23-bd95-9ed0b1fe5548','fake8','fake8@example.com','$2a$10$QUgWl/tWlTPwUc0FVSEpn.u7wx.5GKNkUgCeiok4SpAYLPuiVMmpW','user',0,'2023-12-18 04:02:50.557','2023-12-18 04:02:50.557'),('fdc3d958-4584-498b-9496-6f55e17d61ac','fake31','fake31@example.com','$2a$10$p444TL29bw1X4/fVWPgEdO3xa65DJGYANyjUrtVGrlWUu6wGRx1qW','user',0,'2023-12-18 04:19:55.758','2023-12-18 04:19:55.758');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_prisma_migrations`
--

DROP TABLE IF EXISTS `_prisma_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksum` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logs` text COLLATE utf8mb4_unicode_ci,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `applied_steps_count` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_prisma_migrations`
--

LOCK TABLES `_prisma_migrations` WRITE;
/*!40000 ALTER TABLE `_prisma_migrations` DISABLE KEYS */;
INSERT INTO `_prisma_migrations` VALUES ('39ec0a45-4d81-465d-9c1f-5a4f24894cae','fa3d5b9d628473be1d22428ba65dc8cb919eaeba0fa602559c3b9e1275fae4c1','2023-12-11 10:08:06.055','20231211100805_',NULL,NULL,'2023-12-11 10:08:05.931',1),('64e8dd20-aa00-4e8e-be3e-d399ef48b249','19a4a85fcac68acc385bde35eec4e36eec85170ef6d2a8f30a02b1febb85440b','2023-12-11 10:01:44.140','20231211100144_',NULL,NULL,'2023-12-11 10:01:44.012',1),('6cf33f3b-6e18-424f-88d1-ed5788c9b5ca','55b13b27631abbc69dcb34105371b30732ca93be3c18091e1df705f0b81c8086','2023-12-11 09:54:48.520','20231211095448_',NULL,NULL,'2023-12-11 09:54:48.188',1);
/*!40000 ALTER TABLE `_prisma_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `timestamp` bigint NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-18 15:04:17
