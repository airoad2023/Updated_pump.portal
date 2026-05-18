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
-- Table structure for table `creators`
--

DROP TABLE IF EXISTS `creators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `creators` (
  `creator_wallet` varchar(100) NOT NULL,
  `first_seen_at` datetime NOT NULL,
  `last_seen_at` datetime NOT NULL,
  `total_launches` int DEFAULT '0',
  `total_migrations` int DEFAULT '0',
  `notes` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`creator_wallet`),
  KEY `idx_creators_total_launches` (`total_launches`),
  KEY `idx_creators_total_migrations` (`total_migrations`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creators`
--

LOCK TABLES `creators` WRITE;
/*!40000 ALTER TABLE `creators` DISABLE KEYS */;
/*!40000 ALTER TABLE `creators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `launches`
--

DROP TABLE IF EXISTS `launches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `launches` (
  `mint` varchar(100) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `symbol` varchar(100) DEFAULT NULL,
  `creator_wallet` varchar(100) DEFAULT NULL,
  `launch_time` datetime NOT NULL,
  `received_at` datetime NOT NULL,
  `raw_event_id` bigint DEFAULT NULL,
  `name_lower` varchar(255) DEFAULT NULL,
  `symbol_lower` varchar(100) DEFAULT NULL,
  `launch_date` date DEFAULT NULL,
  `launch_hour` tinyint DEFAULT NULL,
  `launch_day_of_week` tinyint DEFAULT NULL,
  `is_migrated` tinyint(1) DEFAULT '0',
  `migration_time` datetime DEFAULT NULL,
  `minutes_to_migration` int DEFAULT NULL,
  `duplicate_name_count_at_launch` int DEFAULT '0',
  `duplicate_symbol_count_at_launch` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sol_amount` decimal(40,10) DEFAULT NULL,
  `initial_buy` decimal(40,10) DEFAULT NULL,
  `market_cap_sol` decimal(40,10) DEFAULT NULL,
  `bonding_curve_key` varchar(255) DEFAULT NULL,
  `v_tokens_in_bonding_curve` decimal(40,10) DEFAULT NULL,
  `v_sol_in_bonding_curve` decimal(40,10) DEFAULT NULL,
  `is_mayhem_mode` tinyint(1) DEFAULT NULL,
  `pool` varchar(100) DEFAULT NULL,
  `uri` text,
  PRIMARY KEY (`mint`),
  KEY `raw_event_id` (`raw_event_id`),
  KEY `idx_launches_creator_wallet` (`creator_wallet`),
  KEY `idx_launches_launch_time` (`launch_time`),
  KEY `idx_launches_name` (`name`),
  KEY `idx_launches_symbol` (`symbol`),
  KEY `idx_launches_is_migrated` (`is_migrated`),
  KEY `idx_launches_launch_hour` (`launch_hour`),
  KEY `idx_launches_launch_day_of_week` (`launch_day_of_week`),
  CONSTRAINT `launches_ibfk_1` FOREIGN KEY (`creator_wallet`) REFERENCES `creators` (`creator_wallet`),
  CONSTRAINT `launches_ibfk_2` FOREIGN KEY (`raw_event_id`) REFERENCES `raw_events` (`raw_event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `launches`
--

LOCK TABLES `launches` WRITE;
/*!40000 ALTER TABLE `launches` DISABLE KEYS */;
/*!40000 ALTER TABLE `launches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `migration_id` bigint NOT NULL AUTO_INCREMENT,
  `mint` varchar(100) NOT NULL,
  `migration_time` datetime NOT NULL,
  `received_at` datetime NOT NULL,
  `raw_event_id` bigint DEFAULT NULL,
  `minutes_from_launch` int DEFAULT NULL,
  `migration_status` enum('confirmed','duplicate','unknown') DEFAULT 'confirmed',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`migration_id`),
  UNIQUE KEY `unique_migration_mint` (`mint`),
  KEY `raw_event_id` (`raw_event_id`),
  KEY `idx_migrations_mint` (`mint`),
  KEY `idx_migrations_migration_time` (`migration_time`),
  KEY `idx_migrations_minutes_from_launch` (`minutes_from_launch`),
  CONSTRAINT `migrations_ibfk_1` FOREIGN KEY (`mint`) REFERENCES `launches` (`mint`),
  CONSTRAINT `migrations_ibfk_2` FOREIGN KEY (`raw_event_id`) REFERENCES `raw_events` (`raw_event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pump_account_trades`
--

DROP TABLE IF EXISTS `pump_account_trades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pump_account_trades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `collection_run_id` varchar(100) DEFAULT NULL,
  `watched_account` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `mint` varchar(255) DEFAULT NULL,
  `trader_public_key` varchar(255) DEFAULT NULL,
  `tx_type` varchar(50) DEFAULT NULL,
  `token_amount` decimal(40,10) DEFAULT NULL,
  `sol_amount` decimal(40,10) DEFAULT NULL,
  `price_sol` decimal(40,18) DEFAULT NULL,
  `market_cap_sol` decimal(40,10) DEFAULT NULL,
  `bonding_curve_key` varchar(255) DEFAULT NULL,
  `v_tokens_in_bonding_curve` decimal(40,10) DEFAULT NULL,
  `v_sol_in_bonding_curve` decimal(40,10) DEFAULT NULL,
  `pool` varchar(100) DEFAULT NULL,
  `raw_json` json DEFAULT NULL,
  `received_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `signature` (`signature`),
  KEY `idx_collection_run_id` (`collection_run_id`),
  KEY `idx_watched_account` (`watched_account`),
  KEY `idx_mint` (`mint`),
  KEY `idx_trader_public_key` (`trader_public_key`),
  KEY `idx_tx_type` (`tx_type`),
  KEY `idx_sol_amount` (`sol_amount`),
  KEY `idx_market_cap_sol` (`market_cap_sol`),
  KEY `idx_received_at` (`received_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pump_account_trades`
--

LOCK TABLES `pump_account_trades` WRITE;
/*!40000 ALTER TABLE `pump_account_trades` DISABLE KEYS */;
/*!40000 ALTER TABLE `pump_account_trades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pump_paid_raw_events`
--

DROP TABLE IF EXISTS `pump_paid_raw_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pump_paid_raw_events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `collection_run_id` varchar(100) DEFAULT NULL,
  `event_type` varchar(50) DEFAULT NULL,
  `mint` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `received_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `raw_json` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_collection_run_id` (`collection_run_id`),
  KEY `idx_mint` (`mint`),
  KEY `idx_event_type` (`event_type`),
  KEY `idx_signature` (`signature`),
  KEY `idx_received_at` (`received_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pump_paid_raw_events`
--

LOCK TABLES `pump_paid_raw_events` WRITE;
/*!40000 ALTER TABLE `pump_paid_raw_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `pump_paid_raw_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pump_token_snapshots`
--

DROP TABLE IF EXISTS `pump_token_snapshots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pump_token_snapshots` (
  `id` int NOT NULL AUTO_INCREMENT,
  `collection_run_id` varchar(100) DEFAULT NULL,
  `tracked_token_id` int DEFAULT NULL,
  `mint` varchar(255) DEFAULT NULL,
  `seconds_after_launch` int DEFAULT NULL,
  `total_trades` int DEFAULT '0',
  `buy_count` int DEFAULT '0',
  `sell_count` int DEFAULT '0',
  `unique_traders` int DEFAULT '0',
  `unique_buyers` int DEFAULT '0',
  `unique_sellers` int DEFAULT '0',
  `total_volume_sol` decimal(40,10) DEFAULT '0.0000000000',
  `buy_volume_sol` decimal(40,10) DEFAULT '0.0000000000',
  `sell_volume_sol` decimal(40,10) DEFAULT '0.0000000000',
  `net_volume_sol` decimal(40,10) DEFAULT '0.0000000000',
  `average_buy_sol` decimal(40,10) DEFAULT NULL,
  `average_sell_sol` decimal(40,10) DEFAULT NULL,
  `largest_buy_sol` decimal(40,10) DEFAULT NULL,
  `largest_sell_sol` decimal(40,10) DEFAULT NULL,
  `start_market_cap_sol` decimal(40,10) DEFAULT NULL,
  `current_market_cap_sol` decimal(40,10) DEFAULT NULL,
  `highest_market_cap_sol` decimal(40,10) DEFAULT NULL,
  `lowest_market_cap_sol` decimal(40,10) DEFAULT NULL,
  `market_cap_change_sol` decimal(40,10) DEFAULT NULL,
  `market_cap_change_percent` decimal(20,6) DEFAULT NULL,
  `buy_sell_ratio` decimal(20,6) DEFAULT NULL,
  `buy_volume_sell_volume_ratio` decimal(20,6) DEFAULT NULL,
  `volume_speed_sol_per_second` decimal(40,10) DEFAULT NULL,
  `trade_speed_per_second` decimal(20,6) DEFAULT NULL,
  `buy_speed_per_second` decimal(20,6) DEFAULT NULL,
  `sell_speed_per_second` decimal(20,6) DEFAULT NULL,
  `first_trade_seconds` decimal(20,3) DEFAULT NULL,
  `first_buy_seconds` decimal(20,3) DEFAULT NULL,
  `first_sell_seconds` decimal(20,3) DEFAULT NULL,
  `creator_buy_count` int DEFAULT '0',
  `creator_sell_count` int DEFAULT '0',
  `creator_buy_volume_sol` decimal(40,10) DEFAULT '0.0000000000',
  `creator_sell_volume_sol` decimal(40,10) DEFAULT '0.0000000000',
  `creator_sold` tinyint(1) DEFAULT '0',
  `top_buyer_sol` decimal(40,10) DEFAULT '0.0000000000',
  `top_seller_sol` decimal(40,10) DEFAULT '0.0000000000',
  `top_buyer_share_percent` decimal(20,6) DEFAULT NULL,
  `top_seller_share_percent` decimal(20,6) DEFAULT NULL,
  `has_large_buy` tinyint(1) DEFAULT '0',
  `has_large_sell` tinyint(1) DEFAULT '0',
  `is_high_activity` tinyint(1) DEFAULT '0',
  `is_sell_pressure_high` tinyint(1) DEFAULT '0',
  `has_no_sells` tinyint(1) DEFAULT '0',
  `buy_pressure_score` decimal(20,6) DEFAULT NULL,
  `sell_pressure_score` decimal(20,6) DEFAULT NULL,
  `momentum_score` decimal(20,6) DEFAULT NULL,
  `risk_score` decimal(20,6) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_snapshot` (`collection_run_id`,`mint`,`seconds_after_launch`),
  KEY `idx_collection_run_id` (`collection_run_id`),
  KEY `idx_tracked_token_id` (`tracked_token_id`),
  KEY `idx_mint` (`mint`),
  KEY `idx_seconds_after_launch` (`seconds_after_launch`),
  KEY `idx_buy_count` (`buy_count`),
  KEY `idx_sell_count` (`sell_count`),
  KEY `idx_unique_buyers` (`unique_buyers`),
  KEY `idx_unique_sellers` (`unique_sellers`),
  KEY `idx_buy_volume_sol` (`buy_volume_sol`),
  KEY `idx_sell_volume_sol` (`sell_volume_sol`),
  KEY `idx_net_volume_sol` (`net_volume_sol`),
  KEY `idx_market_cap_change_percent` (`market_cap_change_percent`),
  KEY `idx_momentum_score` (`momentum_score`),
  KEY `idx_risk_score` (`risk_score`),
  KEY `idx_is_high_activity` (`is_high_activity`),
  KEY `idx_is_sell_pressure_high` (`is_sell_pressure_high`),
  KEY `idx_creator_sold` (`creator_sold`),
  CONSTRAINT `pump_token_snapshots_ibfk_1` FOREIGN KEY (`tracked_token_id`) REFERENCES `pump_tracked_tokens` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pump_token_snapshots`
--

LOCK TABLES `pump_token_snapshots` WRITE;
/*!40000 ALTER TABLE `pump_token_snapshots` DISABLE KEYS */;
/*!40000 ALTER TABLE `pump_token_snapshots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pump_token_trades`
--

DROP TABLE IF EXISTS `pump_token_trades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pump_token_trades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `collection_run_id` varchar(100) DEFAULT NULL,
  `tracked_token_id` int DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `mint` varchar(255) DEFAULT NULL,
  `trader_public_key` varchar(255) DEFAULT NULL,
  `tx_type` varchar(50) DEFAULT NULL,
  `token_amount` decimal(40,10) DEFAULT NULL,
  `sol_amount` decimal(40,10) DEFAULT NULL,
  `price_sol` decimal(40,18) DEFAULT NULL,
  `bonding_curve_key` varchar(255) DEFAULT NULL,
  `v_tokens_in_bonding_curve` decimal(40,10) DEFAULT NULL,
  `v_sol_in_bonding_curve` decimal(40,10) DEFAULT NULL,
  `market_cap_sol` decimal(40,10) DEFAULT NULL,
  `trade_sequence` int DEFAULT NULL,
  `seconds_after_launch` decimal(20,3) DEFAULT NULL,
  `pool` varchar(100) DEFAULT NULL,
  `raw_event_id` int DEFAULT NULL,
  `raw_json` json DEFAULT NULL,
  `received_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `signature` (`signature`),
  KEY `idx_collection_run_id` (`collection_run_id`),
  KEY `idx_tracked_token_id` (`tracked_token_id`),
  KEY `idx_mint` (`mint`),
  KEY `idx_trader_public_key` (`trader_public_key`),
  KEY `idx_tx_type` (`tx_type`),
  KEY `idx_seconds_after_launch` (`seconds_after_launch`),
  KEY `idx_market_cap_sol` (`market_cap_sol`),
  KEY `idx_sol_amount` (`sol_amount`),
  KEY `idx_received_at` (`received_at`),
  CONSTRAINT `pump_token_trades_ibfk_1` FOREIGN KEY (`tracked_token_id`) REFERENCES `pump_tracked_tokens` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pump_token_trades`
--

LOCK TABLES `pump_token_trades` WRITE;
/*!40000 ALTER TABLE `pump_token_trades` DISABLE KEYS */;
/*!40000 ALTER TABLE `pump_token_trades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pump_tracked_tokens`
--

DROP TABLE IF EXISTS `pump_tracked_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pump_tracked_tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `collection_run_id` varchar(100) DEFAULT NULL,
  `mint` varchar(255) DEFAULT NULL,
  `token_name` varchar(255) DEFAULT NULL,
  `symbol` varchar(100) DEFAULT NULL,
  `creator_wallet` varchar(255) DEFAULT NULL,
  `launch_time` datetime DEFAULT NULL,
  `tracking_started_at` datetime DEFAULT NULL,
  `tracking_ended_at` datetime DEFAULT NULL,
  `launch_score` int DEFAULT NULL,
  `tracking_reason` varchar(255) DEFAULT NULL,
  `sol_amount` decimal(40,10) DEFAULT NULL,
  `initial_buy` decimal(40,10) DEFAULT NULL,
  `market_cap_sol` decimal(40,10) DEFAULT NULL,
  `bonding_curve_key` varchar(255) DEFAULT NULL,
  `v_tokens_in_bonding_curve` decimal(40,10) DEFAULT NULL,
  `v_sol_in_bonding_curve` decimal(40,10) DEFAULT NULL,
  `is_mayhem_mode` tinyint(1) DEFAULT NULL,
  `pool` varchar(100) DEFAULT NULL,
  `duplicate_name_count` int DEFAULT '0',
  `duplicate_symbol_count` int DEFAULT '0',
  `creator_previous_launches` int DEFAULT '0',
  `creator_previous_migrations` int DEFAULT '0',
  `tracking_status` varchar(50) DEFAULT 'active',
  `did_migrate` tinyint(1) DEFAULT '0',
  `migration_time` datetime DEFAULT NULL,
  `seconds_to_migration` int DEFAULT NULL,
  `raw_json` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mint` (`mint`),
  KEY `idx_collection_run_id` (`collection_run_id`),
  KEY `idx_mint` (`mint`),
  KEY `idx_creator_wallet` (`creator_wallet`),
  KEY `idx_launch_score` (`launch_score`),
  KEY `idx_tracking_status` (`tracking_status`),
  KEY `idx_did_migrate` (`did_migrate`),
  KEY `idx_launch_time` (`launch_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pump_tracked_tokens`
--

LOCK TABLES `pump_tracked_tokens` WRITE;
/*!40000 ALTER TABLE `pump_tracked_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `pump_tracked_tokens` ENABLE KEYS */;
UNLOCK TABLES;

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
  `position_id` varchar(100) DEFAULT NULL,
  `token_name` varchar(255) DEFAULT NULL,
  `symbol` varchar(100) DEFAULT NULL,
  `entry_market_cap_sol` decimal(40,10) DEFAULT NULL,
  `exit_market_cap_sol` decimal(40,10) DEFAULT NULL,
  `estimated_return_percent` decimal(20,8) DEFAULT NULL,
  `exit_reason` varchar(100) DEFAULT NULL,
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

--
-- Table structure for table `raw_events`
--

DROP TABLE IF EXISTS `raw_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `raw_events` (
  `raw_event_id` bigint NOT NULL AUTO_INCREMENT,
  `event_type` enum('launch','migration','unknown') NOT NULL,
  `mint` varchar(100) DEFAULT NULL,
  `received_at` datetime NOT NULL,
  `raw_json` json NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`raw_event_id`),
  KEY `idx_raw_events_mint` (`mint`),
  KEY `idx_raw_events_event_type` (`event_type`),
  KEY `idx_raw_events_received_at` (`received_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `raw_events`
--

LOCK TABLES `raw_events` WRITE;
/*!40000 ALTER TABLE `raw_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `raw_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_keywords`
--

DROP TABLE IF EXISTS `token_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token_keywords` (
  `keyword_id` bigint NOT NULL AUTO_INCREMENT,
  `mint` varchar(100) NOT NULL,
  `keyword` varchar(100) NOT NULL,
  `category` enum('meme','ai','animal','celebrity','political','crypto','gaming','internet_trend','adult','other') DEFAULT 'other',
  `source_field` enum('name','symbol','both') DEFAULT 'name',
  `detected_at` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`keyword_id`),
  UNIQUE KEY `unique_token_keyword` (`mint`,`keyword`,`category`),
  KEY `idx_token_keywords_mint` (`mint`),
  KEY `idx_token_keywords_keyword` (`keyword`),
  KEY `idx_token_keywords_category` (`category`),
  CONSTRAINT `token_keywords_ibfk_1` FOREIGN KEY (`mint`) REFERENCES `launches` (`mint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_keywords`
--

LOCK TABLES `token_keywords` WRITE;
/*!40000 ALTER TABLE `token_keywords` DISABLE KEYS */;
/*!40000 ALTER TABLE `token_keywords` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-18 18:18:42
