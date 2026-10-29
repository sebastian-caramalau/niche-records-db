DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS albums CASCADE;
DROP TABLE IF EXISTS artists CASCADE;
DROP TABLE IF EXISTS genres CASCADE;
DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'client' CHECK (role IN ('client', 'admin', 'staff')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

CREATE TABLE artists (
    artist_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    country VARCHAR(100),
    formed_year INT CHECK (formed_year >= 1980 AND formed_year <= 2026)
);

CREATE TABLE albums (
    album_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    artist_id INT NOT NULL REFERENCES artists(artist_id) ON DELETE CASCADE,
    genre_id INT REFERENCES genres(genre_id) ON DELETE SET NULL,
    format VARCHAR(20) NOT NULL CHECK (format IN ('Vinil', 'CD')),
    release_year INT CHECK (release_year >= 1900 AND release_year <= 2026),
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    order_date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    status VARCHAR(50) NOT NULL DEFAULT 'In asteptare' CHECK (status IN ('In asteptare', 'In prelucrare', 'Expediata', 'Finalizata', 'Anulata')),
    total_amount NUMERIC(10, 2) NOT NULL CHECK (total_amount >= 0)
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    album_id INT NOT NULL REFERENCES albums(album_id) ON DELETE RESTRICT,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10, 2) NOT NULL CHECK (unit_price >= 0)
);

INSERT INTO users (user_id, email, full_name, role) VALUES 
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'admin@nicherecords.ro', 'Admin Niche', 'admin'),
('b1eebc99-9c0b-4ef8-bb6d-6bb9bd380b22', 'andrei.popescu@gmail.com', 'Andrei Popescu', 'client'),
('c2eebc99-9c0b-4ef8-bb6d-6bb9bd380c33', 'maria.ionescu@yahoo.com', 'Maria Ionescu', 'client');

INSERT INTO genres (genre_id, name, description) VALUES
(1, 'Thall', 'Subgen extrem, atmosferic și groove-heavy originar din Suedia, caracterizat prin riff-uri pitch-shifted.'),
(2, 'Djent', 'Subgen al metal-ului progresiv caracterizat prin tonuri de chitară distinse, poliritmuri și syncopation.'),
(3, 'Mathcore', 'Stil extrem de complex de metalcore/hardcore punk centrat pe măsuri de timp atipice și dizonanțe.');

INSERT INTO artists (artist_id, name, country, formed_year) VALUES
(1, 'Vildhjarta', 'Suedia', 2005),
(2, 'Meshuggah', 'Suedia', 1987),
(3, 'Frontierer', 'Scotia/SUA', 2011);

INSERT INTO albums (album_id, title, artist_id, genre_id, format, release_year, price, stock_quantity) VALUES
(1, 'Måsstaden under vatten', 1, 1, 'Vinil', 2021, 195.00, 8),
(2, 'Måsstaden under vatten', 1, 1, 'CD', 2021, 75.00, 15),
(3, 'ObZen', 2, 2, 'Vinil', 2008, 175.00, 10),
(4, 'Oxidized', 3, 3, 'Vinil', 2021, 180.00, 6),
(5, 'Oxidized', 3, 3, 'CD', 2021, 65.00, 12);

INSERT INTO orders (order_id, user_id, order_date, status, total_amount) VALUES
(1, 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380b22', NOW() - MAKE_INTERVAL(days := 2), 'Finalizata', 270.00),
(2, 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380c33', NOW() - MAKE_INTERVAL(days := 1), 'In prelucrare', 180.00);

INSERT INTO order_items (order_id, album_id, quantity, unit_price) VALUES
(1, 1, 1, 195.00),
(1, 2, 1, 75.00),
(2, 4, 1, 180.00);