-- ============================================
-- File: partitioning.sql
-- Purpose: Implement partitioning on the bookings table
-- ============================================

-- 1️⃣ Drop existing bookings table if it exists (optional — for setup/demo)
DROP TABLE IF EXISTS bookings;

-- 2️⃣ Recreate Bookings table with PARTITIONING based on check_in_date
CREATE TABLE bookings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    property_id INT NOT NULL,
    guest_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    guest_count INT DEFAULT 1,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'cancelled', 'completed') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
    FOREIGN KEY (guest_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_check_in_date (check_in_date),
    INDEX idx_property_id (property_id),
    INDEX idx_guest_id (guest_id)
)
PARTITION BY RANGE (YEAR(check_in_date)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION pmax VALUES LESS THAN MAXVALUE
);

-- ============================================
-- 3️⃣ Test query performance
-- ============================================

-- Run EXPLAIN before partitioning (for baseline comparison)
-- (Run this on your old bookings table before you drop it)
-- EXPLAIN SELECT * FROM bookings WHERE check_in_date BETWEEN '2024-01-01' AND '2024-06-30';

-- Run EXPLAIN after partitioning
EXPLAIN SELECT * 
FROM bookings
WHERE check_in_date BETWEEN '2024-01-01' AND '2024-06-30';

-- ============================================
-- 4️⃣ Sample data insert (optional, for testing)
-- ============================================
INSERT INTO bookings (property_id, guest_id, check_in_date, check_out_date, guest_count, total_price, status)
VALUES
(1, 2, '2023-11-01', '2023-11-05', 2, 800.00, 'completed'),
(2, 3, '2024-03-10', '2024-03-15', 1, 450.00, 'confirmed'),
(3, 4, '2024-07-05', '2024-07-10', 3, 1200.00, 'pending'),
(1, 5, '2025-02-20', '2025-02-25', 2, 980.00, 'confirmed');

-- Test partition-specific query
EXPLAIN SELECT * 
FROM bookings 
WHERE check_in_date BETWEEN '2024-01-01' AND '2024-12-31';
