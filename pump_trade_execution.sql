-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: pump_portal_1
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `pump_trade_executions`
--

DROP TABLE IF EXISTS `pump_trade_executions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pump_trade_executions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `collection_run_id` varchar(100) DEFAULT NULL,
  `strategy_name` varchar(100) DEFAULT NULL,
  `mode` varchar(50) DEFAULT NULL,
  `mint` varchar(255) DEFAULT NULL,
  `action` varchar(20) DEFAULT NULL,
  `amount` varchar(100) DEFAULT NULL,
  `denominated_in_sol` tinyint(1) DEFAULT NULL,
  `slippage_percent` decimal(10,4) DEFAULT NULL,
  `priority_fee_sol` decimal(20,10) DEFAULT NULL,
  `http_status` int DEFAULT NULL,
  `response_text` longtext,
  `signature` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `signal_seconds` int DEFAULT NULL,
  `signal_market_cap_change_percent` decimal(20,8) DEFAULT NULL,
  `signal_momentum_score` decimal(20,8) DEFAULT NULL,
  `signal_risk_score` decimal(20,8) DEFAULT NULL,
  `signal_net_volume_sol` decimal(20,8) DEFAULT NULL,
  `signal_unique_buyers` int DEFAULT NULL,
  `trade_note` text,
  PRIMARY KEY (`id`),
  KEY `idx_collection_run_id` (`collection_run_id`),
  KEY `idx_mint` (`mint`),
  KEY `idx_action` (`action`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pump_trade_executions`
--

LOCK TABLES `pump_trade_executions` WRITE;
/*!40000 ALTER TABLE `pump_trade_executions` DISABLE KEYS */;
/*!40000 ALTER TABLE `pump_trade_executions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-18 17:41:04
