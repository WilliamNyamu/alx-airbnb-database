-- ============================================
-- SAMPLE DATA INSERTION SCRIPT
-- ============================================

-- Clear existing data (optional - use with caution!)
-- SET FOREIGN_KEY_CHECKS = 0;
-- TRUNCATE TABLE messages;
-- TRUNCATE TABLE reviews;
-- TRUNCATE TABLE payments;
-- TRUNCATE TABLE bookings;
-- TRUNCATE TABLE property_amenities;
-- TRUNCATE TABLE properties;
-- TRUNCATE TABLE user_roles;
-- TRUNCATE TABLE users;
-- TRUNCATE TABLE amenities;
-- TRUNCATE TABLE roles;
-- SET FOREIGN_KEY_CHECKS = 1;


-- ============================================
-- 1. ROLES (Already created in schema)
-- ============================================
-- These should already exist from the schema creation
-- ('guest', 'host', 'admin')


-- ============================================
-- 2. USERS
-- ============================================
INSERT INTO users (first_name, last_name, email, password_hash, phone_number, city, country, email_verified_at) VALUES
-- Hosts and Guests
('Sarah', 'Johnson', 'sarah.johnson@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+254712345001', 'Nairobi', 'Kenya', '2024-01-15 10:30:00'),
('Michael', 'Chen', 'michael.chen@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+254712345002', 'Mombasa', 'Kenya', '2024-02-20 14:20:00'),
('Amina', 'Hassan', 'amina.hassan@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+254712345003', 'Kisumu', 'Kenya', '2024-03-10 09:15:00'),
('David', 'Omondi', 'david.omondi@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+254712345004', 'Nairobi', 'Kenya', '2024-01-25 16:45:00'),
('Emily', 'Martinez', 'emily.martinez@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0101', 'New York', 'USA', '2024-04-05 11:00:00'),

-- More Guests
('James', 'Wilson', 'james.wilson@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+44-20-7946-0958', 'London', 'UK', '2024-05-12 08:30:00'),
('Fatima', 'Ali', 'fatima.ali@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+254712345005', 'Nakuru', 'Kenya', '2024-06-18 13:20:00'),
('Robert', 'Taylor', 'robert.taylor@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0102', 'Los Angeles', 'USA', '2024-07-22 15:40:00'),
('Grace', 'Wanjiru', 'grace.wanjiru@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+254712345006', 'Nairobi', 'Kenya', '2024-08-30 10:10:00'),
('Ahmed', 'Mohammed', 'ahmed.mohammed@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+254712345007', 'Malindi', 'Kenya', '2024-09-15 12:25:00'),

-- Admin
('Admin', 'User', 'admin@platform.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+254712345000', 'Nairobi', 'Kenya', '2024-01-01 00:00:00'),

-- Additional guests (more realistic - many users are guests only)
('Lisa', 'Anderson', 'lisa.anderson@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0103', 'Chicago', 'USA', '2024-10-01 09:00:00'),
('Peter', 'Kamau', 'peter.kamau@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+254712345008', 'Eldoret', 'Kenya', '2024-10-10 14:30:00'),
('Sofia', 'Garcia', 'sofia.garcia@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+34-91-123-4567', 'Madrid', 'Spain', '2024-10-15 11:45:00'),
('John', 'Mutua', 'john.mutua@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+254712345009', 'Thika', 'Kenya', '2024-10-20 16:20:00');


-- ============================================
-- 3. USER_ROLES (Assign roles to users)
-- ============================================
INSERT INTO user_roles (user_id, role_id) VALUES
-- Sarah: Host and Guest (owns properties and books)
(1, 1), -- guest
(1, 2), -- host

-- Michael: Host and Guest
(2, 1), -- guest
(2, 2), -- host

-- Amina: Host and Guest
(3, 1), -- guest
(3, 2), -- host

-- David: Host and Guest
(4, 1), -- guest
(4, 2), -- host

-- Emily: Guest only
(5, 1), -- guest

-- James: Guest only
(6, 1), -- guest

-- Fatima: Host and Guest
(7, 1), -- guest
(7, 2), -- host

-- Robert: Guest only
(8, 1), -- guest

-- Grace: Guest only
(9, 1), -- guest

-- Ahmed: Guest only
(10, 1), -- guest

-- Admin: All roles
(11, 1), -- guest
(11, 2), -- host
(11, 3), -- admin

-- Lisa: Guest only
(12, 1), -- guest

-- Peter: Guest only
(13, 1), -- guest

-- Sofia: Guest only
(14, 1), -- guest

-- John: Guest only
(15, 1); -- guest


-- ============================================
-- 4. PROPERTIES
-- ============================================
INSERT INTO properties (host_id, name, description, street_address, city, state, country, postal_code, latitude, longitude, price_per_night, max_guests, bedrooms, bathrooms, is_active) VALUES
-- Sarah's properties (Nairobi)
(1, 'Modern Apartment in Westlands', 'Spacious 2-bedroom apartment in the heart of Westlands with stunning city views. Walking distance to restaurants, shopping malls, and entertainment. Perfect for business travelers and tourists.', '15 Waiyaki Way', 'Nairobi', 'Nairobi County', 'Kenya', '00100', -1.2674, 36.8075, 85.00, 4, 2, 1.0, TRUE),
(1, 'Cozy Studio in Kilimani', 'Charming studio apartment in quiet Kilimani neighborhood. Fully furnished with kitchen, fast WiFi, and parking. Ideal for solo travelers or couples.', '28 Elgeyo Marakwet Road', 'Nairobi', 'Nairobi County', 'Kenya', '00100', -1.2921, 36.7872, 55.00, 2, 1, 1.0, TRUE),

-- Michael's properties (Mombasa - Beach properties)
(2, 'Beachfront Villa in Nyali', 'Luxurious 4-bedroom villa right on Nyali Beach. Private pool, garden, and direct beach access. Perfect for families and groups. Breathtaking ocean views from every room.', '45 Links Road', 'Mombasa', 'Mombasa County', 'Kenya', '80100', -4.0435, 39.6682, 250.00, 8, 4, 3.0, TRUE),
(2, 'Ocean View Cottage in Bamburi', 'Charming 2-bedroom cottage with ocean views. Located in secure compound with shared pool. 5 minutes walk to the beach and nearby restaurants.', '12 Bamburi Beach Road', 'Mombasa', 'Mombasa County', 'Kenya', '80100', -4.0086, 39.7278, 120.00, 4, 2, 1.5, TRUE),

-- Amina's property (Kisumu - Lakeside)
(3, 'Lakeside Retreat in Kisumu', 'Beautiful 3-bedroom house overlooking Lake Victoria. Spacious living areas, modern kitchen, and large veranda for sunset watching. Secure compound with parking.', '67 Oginga Odinga Road', 'Kisumu', 'Kisumu County', 'Kenya', '40100', -0.0917, 34.7680, 95.00, 6, 3, 2.0, TRUE),

-- David's properties (Nairobi - Upscale)
(4, 'Luxury Penthouse in Karen', 'Exclusive 3-bedroom penthouse in prestigious Karen neighborhood. Panoramic views, chef kitchen, home theater, gym access. High-end furnishings and 24/7 security.', '89 Karen Road', 'Nairobi', 'Nairobi County', 'Kenya', '00100', -1.3239, 36.7073, 180.00, 6, 3, 2.5, TRUE),
(4, 'Executive Suite in Upperhill', 'Sophisticated 1-bedroom suite perfect for business executives. Located in premium complex with gym, pool, and meeting rooms. Walking distance to offices and hospitals.', '34 Ralph Bunche Road', 'Nairobi', 'Nairobi County', 'Kenya', '00100', -1.2864, 36.8172, 110.00, 2, 1, 1.0, TRUE),

-- Fatima's properties (Nakuru)
(7, 'Family Home near Lake Nakuru', 'Spacious 4-bedroom family home near Lake Nakuru National Park. Large garden, parking for 3 cars, fully equipped kitchen. Perfect base for safari adventures.', '23 Kenyatta Avenue', 'Nakuru', 'Nakuru County', 'Kenya', '20100', -0.3031, 36.0800, 70.00, 8, 4, 2.0, TRUE),

-- Additional properties for variety
(1, 'Garden Cottage in Lavington', 'Peaceful 2-bedroom cottage with lush garden in upscale Lavington. Quiet neighborhood, secure, with workspace area. Great for remote workers.', '56 James Gichuru Road', 'Nairobi', 'Nairobi County', 'Kenya', '00100', -1.2758, 36.7645, 90.00, 3, 2, 1.0, TRUE),

(2, 'Budget Room in Mombasa Town', 'Clean and comfortable single room in central Mombasa. Shared facilities, perfect for budget travelers. Close to Fort Jesus and old town.', '18 Nkrumah Road', 'Mombasa', 'Mombasa County', 'Kenya', '80100', -4.0550, 39.6630, 30.00, 1, 1, 0.5, TRUE),

(3, 'Spacious Home in Milimani, Kisumu', 'Large 5-bedroom house ideal for group bookings. Multiple living areas, large kitchen, secure parking. Near shopping centers and hospitals.', '45 Milimani Road', 'Kisumu', 'Kisumu County', 'Kenya', '40100', -0.0833, 34.7500, 150.00, 10, 5, 3.0, TRUE);


-- ============================================
-- 5. AMENITIES
-- ============================================
INSERT INTO amenities (name, category, icon) VALUES
-- Basic amenities
('WiFi', 'basic', 'wifi'),
('Air Conditioning', 'basic', 'ac_unit'),
('Heating', 'basic', 'heat'),
('Kitchen', 'basic', 'kitchen'),
('Washing Machine', 'basic', 'local_laundry_service'),
('Dryer', 'basic', 'dry'),
('Iron', 'basic', 'iron'),
('Hair Dryer', 'basic', 'hair_dryer'),

-- Entertainment
('TV', 'entertainment', 'tv'),
('Cable TV', 'entertainment', 'cable'),
('Netflix', 'entertainment', 'movie'),
('Pool', 'entertainment', 'pool'),
('Hot Tub', 'entertainment', 'hot_tub'),
('Garden', 'entertainment', 'yard'),
('BBQ Grill', 'entertainment', 'outdoor_grill'),

-- Convenience
('Free Parking', 'convenience', 'local_parking'),
('Gym', 'convenience', 'fitness_center'),
('Elevator', 'convenience', 'elevator'),
('Workspace', 'convenience', 'desk'),
('Balcony', 'convenience', 'balcony'),
('Beach Access', 'convenience', 'beach_access'),

-- Safety
('Smoke Detector', 'safety', 'smoke_detector'),
('Carbon Monoxide Detector', 'safety', 'co_detector'),
('Fire Extinguisher', 'safety', 'fire_extinguisher'),
('First Aid Kit', 'safety', 'medical_services'),
('Security Cameras', 'safety', 'videocam'),
('24/7 Security', 'safety', 'security');


-- ============================================
-- 6. PROPERTY_AMENITIES (Link properties to amenities)
-- ============================================
INSERT INTO property_amenities (property_id, amenity_id) VALUES
-- Property 1: Modern Apartment in Westlands (Premium amenities)
(1, 1), (1, 2), (1, 4), (1, 5), (1, 7), (1, 8), (1, 9), (1, 10), (1, 17), (1, 19), (1, 20), (1, 22), (1, 23), (1, 24), (1, 27),

-- Property 2: Cozy Studio in Kilimani (Basic amenities)
(2, 1), (2, 2), (2, 4), (2, 7), (2, 9), (2, 17), (2, 20), (2, 22), (2, 23),

-- Property 3: Beachfront Villa in Nyali (Luxury amenities)
(3, 1), (3, 2), (3, 4), (3, 5), (3, 6), (3, 7), (3, 8), (3, 9), (3, 10), (3, 11), (3, 12), (3, 13), (3, 14), (3, 15), (3, 17), (3, 18), (3, 21), (3, 22), (3, 23), (3, 24), (3, 25), (3, 26), (3, 27),

-- Property 4: Ocean View Cottage in Bamburi
(4, 1), (4, 2), (4, 4), (4, 5), (4, 9), (4, 12), (4, 14), (4, 17), (4, 21), (4, 22), (4, 23), (4, 24),

-- Property 5: Lakeside Retreat in Kisumu
(5, 1), (5, 2), (5, 4), (5, 5), (5, 9), (5, 14), (5, 17), (5, 20), (5, 22), (5, 23), (5, 24),

-- Property 6: Luxury Penthouse in Karen
(6, 1), (6, 2), (6, 3), (6, 4), (6, 5), (6, 6), (6, 7), (6, 8), (6, 9), (6, 10), (6, 11), (6, 18), (6, 19), (6, 20), (6, 22), (6, 23), (6, 24), (6, 25), (6, 26), (6, 27),

-- Property 7: Executive Suite in Upperhill
(7, 1), (7, 2), (7, 4), (7, 7), (7, 9), (7, 10), (7, 18), (7, 19), (7, 20), (7, 22), (7, 23), (7, 24),

-- Property 8: Family Home near Lake Nakuru
(8, 1), (8, 2), (8, 4), (8, 5), (8, 9), (8, 14), (8, 15), (8, 17), (8, 22), (8, 23), (8, 24), (8, 27),

-- Property 9: Garden Cottage in Lavington
(9, 1), (9, 2), (9, 4), (9, 5), (9, 7), (9, 9), (9, 14), (9, 17), (9, 20), (9, 22), (9, 23),

-- Property 10: Budget Room in Mombasa Town (Minimal amenities)
(10, 1), (10, 2), (10, 9), (10, 22), (10, 23),

-- Property 11: Spacious Home in Milimani, Kisumu
(11, 1), (11, 2), (11, 4), (11, 5), (11, 9), (11, 14), (11, 17), (11, 20), (11, 22), (11, 23), (11, 24);


-- ============================================
-- 7. BOOKINGS
-- ============================================
INSERT INTO bookings (property_id, guest_id, check_in_date, check_out_date, guest_count, total_price, status, created_at) VALUES
-- Completed bookings (past dates)
(1, 5, '2024-09-15', '2024-09-20', 2, 425.00, 'completed', '2024-09-01 10:30:00'),
(3, 6, '2024-09-10', '2024-09-17', 6, 1750.00, 'completed', '2024-08-25 14:20:00'),
(5, 8, '2024-10-01', '2024-10-05', 4, 380.00, 'completed', '2024-09-20 09:15:00'),
(2, 9, '2024-10-10', '2024-10-12', 1, 110.00, 'completed', '2024-10-05 16:45:00'),
(4, 10, '2024-10-05', '2024-10-10', 3, 600.00, 'completed', '2024-09-28 11:00:00'),

-- Confirmed upcoming bookings
(6, 12, '2025-11-15', '2025-11-20', 4, 900.00, 'confirmed', '2025-10-20 08:30:00'),
(7, 13, '2025-11-10', '2025-11-12', 2, 220.00, 'confirmed', '2025-10-22 13:20:00'),
(8, 14, '2025-12-20', '2025-12-27', 6, 490.00, 'confirmed', '2025-10-18 15:40:00'),
(1, 15, '2025-11-25', '2025-11-28', 2, 255.00, 'confirmed', '2025-10-24 10:10:00'),
(3, 5, '2025-12-15', '2025-12-22', 8, 1750.00, 'confirmed', '2025-10-15 12:25:00'),

-- Pending bookings (awaiting host confirmation)
(9, 6, '2025-11-05', '2025-11-08', 3, 270.00, 'pending', '2025-10-26 09:00:00'),
(10, 8, '2025-11-12', '2025-11-14', 1, 60.00, 'pending', '2025-10-25 14:30:00'),

-- Cancelled bookings
(2, 12, '2024-10-20', '2024-10-23', 2, 165.00, 'cancelled', '2024-10-15 11:45:00'),
(4, 13, '2024-10-25', '2024-10-30', 4, 600.00, 'cancelled', '2024-10-18 16:20:00'),

-- More realistic bookings showing variety
(11, 9, '2025-12-01', '2025-12-05', 8, 600.00, 'confirmed', '2025-10-10 10:00:00'),
(6, 10, '2025-11-08', '2025-11-11', 2, 540.00, 'confirmed', '2025-10-12 15:30:00'),
(7, 14, '2025-12-05', '2025-12-07', 1, 220.00, 'pending', '2025-10-23 09:45:00'),
(1, 8, '2024-08-10', '2024-08-15', 3, 425.00, 'completed', '2024-07-28 12:00:00'),
(5, 12, '2024-09-20', '2024-09-25', 5, 475.00, 'completed', '2024-09-05 14:15:00'),
(9, 15, '2024-10-15', '2024-10-18', 2, 270.00, 'completed', '2024-10-08 11:20:00');


-- ============================================
-- 8. PAYMENTS
-- ============================================
INSERT INTO payments (booking_id, amount, payment_method, status, transaction_id, payment_date) VALUES
-- Completed payments for completed bookings
(1, 425.00, 'credit_card', 'completed', 'TXN_2024091501_1A2B3C', '2024-09-01 10:35:00'),
(2, 1750.00, 'paypal', 'completed', 'TXN_2024082501_4D5E6F', '2024-08-25 14:25:00'),
(3, 380.00, 'debit_card', 'completed', 'TXN_2024092001_7G8H9I', '2024-09-20 09:20:00'),
(4, 110.00, 'credit_card', 'completed', 'TXN_2024100501_0J1K2L', '2024-10-05 16:50:00'),
(5, 600.00, 'bank_transfer', 'completed', 'TXN_2024092801_3M4N5O', '2024-09-28 11:05:00'),

-- Completed payments for upcoming bookings
(6, 900.00, 'credit_card', 'completed', 'TXN_2025102001_6P7Q8R', '2025-10-20 08:35:00'),
(7, 220.00, 'paypal', 'completed', 'TXN_2025102201_9S0T1U', '2025-10-22 13:25:00'),
(8, 490.00, 'credit_card', 'completed', 'TXN_2025101801_2V3W4X', '2025-10-18 15:45:00'),
(9, 255.00, 'debit_card', 'completed', 'TXN_2025102401_5Y6Z7A', '2025-10-24 10:15:00'),
(10, 1750.00, 'credit_card', 'completed', 'TXN_2025101501_8B9C0D', '2025-10-15 12:30:00'),
