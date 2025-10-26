CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(200) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

    INDEX idx_email (email)
);

CREATE TABLE roles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_roles (
    user_id INT NOT NULL,
    role_id INT NOT NULL,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Composite primary key (prevents duplicate role assignments)
    PRIMARY KEY (user_id, role_id),
    
    -- Foreign keys
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
    
    -- Indexes
    INDEX idx_user_id (user_id),
    INDEX idx_role_id (role_id)
);

CREATE TABLE property (
    property_id INT PRIMARY KEY AUTO_INCREMENT,
    host_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    price_per_night DECIMAL NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP on UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (host_id) REFERENCES users(id) ON DELETE CASCADE,
    
    -- Indexes
    INDEX idx_host_id (host_id),
);

CREATE TABLE bookings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    property_id INT NOT NULL,
    guest_id INT NOT NULL,
    
    -- Booking details
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    guest_count INT DEFAULT 1,
    total_price DECIMAL(10, 2) NOT NULL,
    
    -- Status
    status ENUM('pending', 'confirmed', 'cancelled', 'completed') DEFAULT 'pending',
    
    -- Timestamps
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Foreign keys
    FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE,
    FOREIGN KEY (guest_id) REFERENCES users(id) ON DELETE CASCADE,
    
    -- Indexes
    INDEX idx_property_id (property_id),
    INDEX idx_guest_id (guest_id),
    INDEX idx_dates (check_in_date, check_out_date),
    INDEX idx_status (status),
    
    -- Constraints
    CHECK (check_out_date > check_in_date),
    CHECK (guest_count > 0),
    CHECK (total_price > 0)
);


-- ============================================
-- 6. PAYMENTS TABLE
-- ============================================
CREATE TABLE payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    
    -- Payment details
    amount DECIMAL(10, 2) NOT NULL,
    payment_method ENUM('credit_card', 'debit_card', 'paypal', 'bank_transfer') NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Payment status
    status ENUM('pending', 'completed', 'failed', 'refunded') DEFAULT 'pending',
    
    -- Payment gateway reference
    transaction_id VARCHAR(255),
    
    -- Timestamps
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key
    FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE,
    
    -- Indexes
    INDEX idx_booking_id (booking_id),
    INDEX idx_status (status),
    INDEX idx_transaction_id (transaction_id),
    
    -- Constraints
    CHECK (amount > 0)
);


-- ============================================
-- 7. REVIEWS TABLE
-- ============================================
CREATE TABLE reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    property_id INT NOT NULL,
    booking_id INT NOT NULL,
    reviewer_id INT NOT NULL,
    
    -- Review content
    rating INT NOT NULL,
    comment TEXT NOT NULL,
    
    -- Timestamps
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Foreign keys
    FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE,
    FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE,
    FOREIGN KEY (reviewer_id) REFERENCES users(id) ON DELETE CASCADE,
    
    -- Ensure one review per booking
    UNIQUE KEY unique_booking_review (booking_id),
    
    -- Indexes
    INDEX idx_property_id (property_id),
    INDEX idx_reviewer_id (reviewer_id),
    INDEX idx_rating (rating),
    
    -- Constraints
    CHECK (rating >= 1 AND rating <= 5)
);


-- ============================================
-- 8. MESSAGES TABLE
-- ============================================
CREATE TABLE messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT NOT NULL,
    recipient_id INT NOT NULL,
    
    -- Message content
    message_body TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    
    -- Timestamp
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign keys
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE SET NULL,
    
    -- Indexes
    INDEX idx_sender_id (sender_id),
    INDEX idx_recipient_id (recipient_id),
    INDEX idx_is_read (is_read),
    INDEX idx_sent_at (sent_at)
);
