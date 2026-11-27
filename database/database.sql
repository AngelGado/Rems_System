-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.46 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for rems_test_db
CREATE DATABASE IF NOT EXISTS `rems_test_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `rems_test_db`;

-- Dumping structure for table rems_test_db.admin_accounts
CREATE TABLE IF NOT EXISTS `admin_accounts` (
  `source_row` int unsigned NOT NULL,
  `username` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`source_row`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table rems_test_db.bookings
CREATE TABLE IF NOT EXISTS `bookings` (
  `source_row` int unsigned NOT NULL,
  `booking_ref` varchar(191) DEFAULT NULL,
  `pet_name` varchar(255) DEFAULT NULL,
  `pet_row` int unsigned DEFAULT NULL,
  `service` varchar(255) DEFAULT NULL,
  `booking_date` date DEFAULT NULL,
  `booking_time` time DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `customer_username` varchar(191) DEFAULT NULL,
  `account_row` int unsigned DEFAULT NULL,
  PRIMARY KEY (`source_row`),
  KEY `fk_live_booking_pet` (`pet_row`),
  KEY `fk_live_booking_account` (`account_row`),
  KEY `ix_live_booking_ref` (`booking_ref`),
  KEY `ix_live_booking_date` (`booking_date`),
  CONSTRAINT `fk_live_booking_account` FOREIGN KEY (`account_row`) REFERENCES `customer_accounts` (`source_row`),
  CONSTRAINT `fk_live_booking_pet` FOREIGN KEY (`pet_row`) REFERENCES `pets` (`source_row`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table rems_test_db.customers
CREATE TABLE IF NOT EXISTS `customers` (
  `source_row` int unsigned NOT NULL,
  `customer_ref` varchar(191) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text,
  `status` varchar(100) DEFAULT NULL,
  `total_spent` decimal(18,2) DEFAULT NULL,
  `last_visit` varchar(40) DEFAULT NULL,
  `registered_on` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`source_row`),
  KEY `ix_live_customer_ref` (`customer_ref`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table rems_test_db.customer_accounts
CREATE TABLE IF NOT EXISTS `customer_accounts` (
  `source_row` int unsigned NOT NULL,
  `username` varchar(191) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created_at` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`source_row`),
  KEY `ix_live_customer_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table rems_test_db.inventory
CREATE TABLE IF NOT EXISTS `inventory` (
  `product_row` int unsigned NOT NULL,
  `stock_quantity` decimal(18,4) DEFAULT NULL,
  `minimum_stock` int DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  PRIMARY KEY (`product_row`),
  CONSTRAINT `fk_live_inventory_product` FOREIGN KEY (`product_row`) REFERENCES `products` (`source_row`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table rems_test_db.pets
CREATE TABLE IF NOT EXISTS `pets` (
  `source_row` int unsigned NOT NULL,
  `pet_name` varchar(255) DEFAULT NULL,
  `owner_name` varchar(255) DEFAULT NULL,
  `customer_row` int unsigned DEFAULT NULL,
  `species` varchar(100) DEFAULT NULL,
  `breed` varchar(255) DEFAULT NULL,
  `care_notes` text,
  `marking` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`source_row`),
  KEY `fk_live_pet_customer` (`customer_row`),
  CONSTRAINT `fk_live_pet_customer` FOREIGN KEY (`customer_row`) REFERENCES `customers` (`source_row`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table rems_test_db.pickup_items
CREATE TABLE IF NOT EXISTS `pickup_items` (
  `order_row` int unsigned NOT NULL,
  `line_no` int unsigned NOT NULL,
  `product_ref` varchar(191) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `unit_price` decimal(18,4) DEFAULT NULL,
  PRIMARY KEY (`order_row`,`line_no`),
  CONSTRAINT `fk_live_pickup_order` FOREIGN KEY (`order_row`) REFERENCES `pickup_orders` (`source_row`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table rems_test_db.pickup_orders
CREATE TABLE IF NOT EXISTS `pickup_orders` (
  `source_row` int unsigned NOT NULL,
  `order_ref` varchar(191) DEFAULT NULL,
  `customer_username` varchar(191) DEFAULT NULL,
  `customer_ref` varchar(191) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `total_amount` decimal(18,2) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `created_at` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`source_row`),
  KEY `ix_live_order_ref` (`order_ref`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table rems_test_db.products
CREATE TABLE IF NOT EXISTS `products` (
  `source_row` int unsigned NOT NULL,
  `product_ref` varchar(191) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `selling_price` decimal(18,4) DEFAULT NULL,
  `barcode` varchar(191) DEFAULT NULL,
  `unit` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`source_row`),
  KEY `ix_live_product_ref` (`product_ref`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table rems_test_db.rems_state
CREATE TABLE IF NOT EXISTS `rems_state` (
  `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` json NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for procedure rems_test_db.rems_sync_tables
DELIMITER //
CREATE PROCEDURE `rems_sync_tables`(
    IN p_name VARCHAR(32),
    IN p_payload JSON
)
BEGIN
    IF p_name = 'admin' THEN

        DELETE FROM admin_accounts;

        IF JSON_TYPE(p_payload) = 'OBJECT' THEN
            INSERT INTO admin_accounts(source_row, username)
            SELECT 1, JSON_UNQUOTE(
                JSON_EXTRACT(p_payload, '$.username')
            )
            WHERE JSON_EXTRACT(
                p_payload, '$.username'
            ) IS NOT NULL;
        END IF;

    ELSEIF p_name = 'staff' THEN

        DELETE FROM staff_accounts;

        INSERT INTO staff_accounts
        SELECT j.n, j.username,
            CASE WHEN j.active IN ('true','1')
            THEN 1 ELSE 0 END
        FROM JSON_TABLE(
            COALESCE(p_payload, JSON_OBJECT()),
            '$.*' COLUMNS(
                n FOR ORDINALITY,
                username VARCHAR(191) PATH '$.username',
                active VARCHAR(10) PATH '$.active'
            )
        ) j;

    ELSEIF p_name = 'shop' THEN

        DELETE FROM pickup_items;
        DELETE FROM pickup_orders;
        DELETE FROM bookings;
        DELETE FROM pets;
        DELETE FROM customers;
        DELETE FROM customer_accounts;
        DELETE FROM inventory;
        DELETE FROM products;
        DELETE FROM sales;

        INSERT INTO customer_accounts
        SELECT j.n, j.username, j.full_name,
               j.email, j.created_at
        FROM JSON_TABLE(
            COALESCE(p_payload, JSON_OBJECT()),
            '$.customerAccounts.*' COLUMNS(
                n FOR ORDINALITY,
                username VARCHAR(191) PATH '$.username',
                full_name VARCHAR(255) PATH '$.name',
                email VARCHAR(255) PATH '$.email',
                created_at VARCHAR(40) PATH '$.created'
            )
        ) j;

        INSERT INTO customers
        SELECT j.n, j.customer_ref, j.full_name,
               j.phone, j.email, j.address,
               j.status, j.total_spent,
               j.last_visit, j.registered_on
        FROM JSON_TABLE(
            COALESCE(p_payload, JSON_OBJECT()),
            '$.shop.records.Customers[*]' COLUMNS(
                n FOR ORDINALITY,
                full_name VARCHAR(255) PATH '$[0]',
                phone VARCHAR(100) PATH '$[1]',
                email VARCHAR(255) PATH '$[2]',
                address TEXT PATH '$[3]',
                status VARCHAR(100) PATH '$[4]',
                total_spent DECIMAL(18,2) PATH '$[5]',
                last_visit VARCHAR(40) PATH '$[6]',
                registered_on VARCHAR(40) PATH '$[7]',
                customer_ref VARCHAR(191) PATH '$[8]'
            )
        ) j;

        INSERT INTO pets
        SELECT j.n, j.pet_name, j.owner_name,
            (
                SELECT MIN(c.source_row)
                FROM customers c
                WHERE BINARY c.full_name = BINARY j.owner_name
                HAVING COUNT(*) = 1
            ),
            j.species, j.breed,
            j.care_notes, j.marking
        FROM JSON_TABLE(
            COALESCE(p_payload, JSON_OBJECT()),
            '$.shop.records.Pets[*]' COLUMNS(
                n FOR ORDINALITY,
                pet_name VARCHAR(255) PATH '$[0]',
                owner_name VARCHAR(255) PATH '$[1]',
                species VARCHAR(100) PATH '$[2]',
                breed VARCHAR(255) PATH '$[3]',
                care_notes TEXT PATH '$[4]',
                marking VARCHAR(255) PATH '$[6]'
            )
        ) j;

        INSERT INTO bookings
        SELECT j.n, j.booking_ref, j.pet_name,
            (
                SELECT MIN(p.source_row)
                FROM pets p
                WHERE BINARY p.pet_name = BINARY j.pet_name
                HAVING COUNT(*) = 1
            ),
            j.service, j.booking_date, j.booking_time,
            COALESCE(NULLIF(j.status,''),'Scheduled'),
            j.customer_username,
            (
                SELECT MIN(a.source_row)
                FROM customer_accounts a
                WHERE BINARY a.username =
                      BINARY j.customer_username
                HAVING COUNT(*) = 1
            )
        FROM JSON_TABLE(
            COALESCE(p_payload, JSON_OBJECT()),
            '$.shop.records."Grooming & Pet Hotel"[*]' COLUMNS(
                n FOR ORDINALITY,
                pet_name VARCHAR(255) PATH '$[0]',
                service VARCHAR(255) PATH '$[1]',
                booking_date DATE PATH '$[2]'
                    NULL ON EMPTY NULL ON ERROR,
                booking_time TIME PATH '$[3]'
                    NULL ON EMPTY NULL ON ERROR,
                status VARCHAR(100) PATH '$[4]',
                booking_ref VARCHAR(191) PATH '$[6]',
                customer_username VARCHAR(191) PATH '$[7]'
            )
        ) j;

        INSERT INTO products
        SELECT j.n, j.product_ref, j.product_name,
               j.category, j.selling_price,
               j.barcode, j.unit
        FROM JSON_TABLE(
            COALESCE(p_payload, JSON_OBJECT()),
            '$.shop.products[*]' COLUMNS(
                n FOR ORDINALITY,
                product_name VARCHAR(255) PATH '$[0]',
                category VARCHAR(255) PATH '$[1]',
                selling_price DECIMAL(18,4) PATH '$[2]',
                product_ref VARCHAR(191) PATH '$[6]',
                barcode VARCHAR(191) PATH '$[7]',
                unit VARCHAR(100) PATH '$[8].unit'
            )
        ) j;

        INSERT INTO inventory
        SELECT j.n, j.stock_quantity,
               j.minimum_stock, j.expiry_date
        FROM JSON_TABLE(
            COALESCE(p_payload, JSON_OBJECT()),
            '$.shop.products[*]' COLUMNS(
                n FOR ORDINALITY,
                stock_quantity DECIMAL(18,4) PATH '$[3]',
                minimum_stock INT PATH '$[8].minimumStock',
                expiry_date DATE PATH '$[8].expiryDate'
                    NULL ON EMPTY NULL ON ERROR
            )
        ) j;

        INSERT INTO sales
        SELECT j.n, j.transaction_ref,
               j.customer_name, j.sale_date,
               j.sale_details, j.total_amount
        FROM JSON_TABLE(
            COALESCE(p_payload, JSON_OBJECT()),
            '$.shop.records.Reports[*]' COLUMNS(
                n FOR ORDINALITY,
                transaction_ref VARCHAR(191) PATH '$[0]',
                customer_name VARCHAR(255) PATH '$[1]',
                sale_date DATE PATH '$[2]'
                    NULL ON EMPTY NULL ON ERROR,
                sale_details TEXT PATH '$[3]',
                total_amount DECIMAL(18,2) PATH '$[4]'
            )
        ) j;

        INSERT INTO pickup_orders
        SELECT j.n, j.order_ref, j.customer_username,
               j.customer_ref, j.customer_name,
               j.total_amount, j.status, j.created_at
        FROM JSON_TABLE(
            COALESCE(p_payload, JSON_OBJECT()),
            '$.customerOrders[*]' COLUMNS(
                n FOR ORDINALITY,
                order_ref VARCHAR(191) PATH '$.id',
                customer_username VARCHAR(191) PATH '$.username',
                customer_ref VARCHAR(191) PATH '$.customerId',
                customer_name VARCHAR(255) PATH '$.customer',
                total_amount DECIMAL(18,2) PATH '$.total',
                status VARCHAR(100) PATH '$.status',
                created_at VARCHAR(40) PATH '$.created'
            )
        ) j;

        INSERT INTO pickup_items
        SELECT j.n, j.line_no, j.product_ref,
               j.product_name, j.quantity, j.unit_price
        FROM JSON_TABLE(
            COALESCE(p_payload, JSON_OBJECT()),
            '$.customerOrders[*]' COLUMNS(
                n FOR ORDINALITY,
                NESTED PATH '$.items[*]' COLUMNS(
                    line_no FOR ORDINALITY,
                    product_ref VARCHAR(191) PATH '$.id',
                    product_name VARCHAR(255) PATH '$.name',
                    quantity INT PATH '$.quantity',
                    unit_price DECIMAL(18,4) PATH '$.price'
                )
            )
        ) j
        WHERE j.line_no IS NOT NULL;

    END IF;
END//
DELIMITER ;

-- Dumping structure for table rems_test_db.sales
CREATE TABLE IF NOT EXISTS `sales` (
  `source_row` int unsigned NOT NULL,
  `transaction_ref` varchar(191) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `sale_date` date DEFAULT NULL,
  `sale_details` text,
  `total_amount` decimal(18,2) DEFAULT NULL,
  PRIMARY KEY (`source_row`),
  KEY `ix_live_sale_date` (`sale_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table rems_test_db.staff_accounts
CREATE TABLE IF NOT EXISTS `staff_accounts` (
  `source_row` int unsigned NOT NULL,
  `username` varchar(191) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`source_row`),
  KEY `ix_live_staff_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for trigger rems_test_db.rems_sync_after_delete
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `rems_sync_after_delete` AFTER DELETE ON `rems_state` FOR EACH ROW CALL rems_sync_tables(OLD.name, NULL)//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger rems_test_db.rems_sync_after_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `rems_sync_after_insert` AFTER INSERT ON `rems_state` FOR EACH ROW CALL rems_sync_tables(NEW.name, NEW.payload)//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger rems_test_db.rems_sync_after_update
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `rems_sync_after_update` AFTER UPDATE ON `rems_state` FOR EACH ROW CALL rems_sync_tables(NEW.name, NEW.payload)//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

