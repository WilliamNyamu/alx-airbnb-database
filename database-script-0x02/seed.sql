-- ==========================================================
-- SEED DATA FOR AIRBNB-LIKE DATABASE
-- Author: Billy Liam
-- ==========================================================

-- Use your database
USE alx_airbnb_database;

-- ==========================================================
-- 1. USERS
-- ==========================================================
INSERT INTO users (first_name, last_name, email, password_hash, phone_number)
VALUES
('John', 'Doe', 'john.doe@example.com', 'hashedpassword123', '+254700111222'),
('Mary', 'Njeri', 'mary.njeri@example.com', 'hashedpassword456', '+254711223344'),
('Kevin', 'Otieno', 'kevin.otieno@example.com', 'hashedpassword789', '+254722334455'),
('Grace', 'Wambui', 'grace.wambui@example.com', 'hashedpassword999', '+254733445566'),
('David', 'Kamau', 'david.kamau@example.com', 'hashedpassword111', '+254744556677');

-- ==========================================================
-- 2. ROLES
-- ==========================================================
INSERT INTO roles (name, description)
VALUES
('guest', 'User who books properties'),
('host', 'User who lists and manages properties'),
('admin', 'Administrator with full system access');

-- ==========================================================
-- 3. USER_ROLES
-- ==========================================================
-- John: host, Mary: guest, Kevin: guest, Grace: host, David: admin
INSERT INTO user_roles (user_id, role_id)
VALUES
(1, 2),  -- John is a host
(2, 1),  -- Mary is a guest
(3, 1),  -- Kevin is a guest
(4, 2),  -- Grace is a host
(5, 3);  -- David is admin

-- ==========================================================
-- 4. PROPERTIES
-- ==========================================================
INSERT INTO properties (host_id, name, description, location, price_per_night)
VALUES
(1, 'Nairobi City Apartment', 'A modern apartment in the heart of the city.', 'Nairobi, Kenya', 5500.00),
(4, 'Cozy Cottage in Limuru', 'Peaceful countryside home surrounded by tea farms.', 'Limuru, Kenya', 4000.00),
(1, 'Beachfront Villa', 'Luxury villa with ocean view and private pool.', 'Diani, Kenya', 12000.00);

-- ==========================================================
-- 5. BOOKINGS
-- ==========================================================
INSERT INTO bookings (property_id, guest_id, check_in_date, check_out_date, guest_count, total_price, status)
VALUES
(1, 2, '2025-11-10', '2025-11-15', 2, 27500.00, 'confirmed'),
(2, 3, '2025-12-01', '2025-12-05', 1, 16000.00, 'pending'),
(3, 2, '2025-12-20', '2025-12-25', 4, 60000.00, 'confirmed');

-- ==========================================================
-- 6. PAYMENTS
-- ==========================================================
INSERT INTO payments (booking_id, amount, payment_method, status, transaction_id)
VALUES
(1, 27500.00, 'credit_card', 'completed', 'TXN001'),
(2, 16000.00, 'paypal', 'pending', 'TXN002'),
(3, 60000.00, 'bank_transfer', 'completed', 'TXN003');

-- ==========================================================
-- 7. REVIEWS
-- ==========================================================
INSERT INTO reviews (property_id, booking_id, reviewer_id, rating, comment)
VALUES
(1, 1, 2, 5, 'Amazing stay! The apartment was clean, central, and had great amenities.'),
(2, 2, 3, 4, 'Very cozy and peaceful. Perfect getaway from the city.'),
(3, 3, 2, 5, 'Exceptional experience — beautiful views and friendly host.');

-- ==========================================================
-- 8. MESSAGES
-- ==========================================================
INSERT INTO messages (sender_id, recipient_id, booking_id, message_body, is_read)
VALUES
(2, 1, 1, 'Hi John, just confirming my check-in time tomorrow.', 0),
(1, 2, 1, 'Hi Mary, check-in is from 2pm. See you then!', 1),
(3, 4, 2, 'Hi Grace, is the cottage available for early check-in?', 0),
(4, 3, 2, 'Hi Kevin, yes, you can check in from noon.', 1);
