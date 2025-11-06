-- Index for faster JOIN between bookings and users
CREATE INDEX idx_bookings_guest_id ON bookings (guest_id);

-- Index for faster JOIN and lookups between bookings and properties
CREATE INDEX idx_bookings_property_id ON bookings (property_id);

-- Index on users.user_id (if not already PRIMARY KEY)
CREATE INDEX idx_users_user_id ON users (user_id);

-- Index on properties.property_id (if not already PRIMARY KEY)
CREATE INDEX idx_properties_property_id ON properties (property_id);

-- Optional: If you frequently search or sort by property name
CREATE INDEX idx_properties_name ON properties (name);