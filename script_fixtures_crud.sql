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
(1, 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380b22', NOW() - MAKE_INTERVAL(days := 3), 'Finalizata', 270.00),
(2, 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380c33', NOW() - MAKE_INTERVAL(days := 2), 'In prelucrare', 180.00),
(3, 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380b22', NOW() - MAKE_INTERVAL(days := 1), 'In asteptare', 175.00);

INSERT INTO order_items (order_item_id, order_id, album_id, quantity, unit_price) VALUES
(1, 1, 1, 1, 195.00),
(2, 1, 2, 1, 75.00),
(3, 2, 4, 1, 180.00);

SELECT setval('genres_genre_id_seq', (SELECT MAX(genre_id) FROM genres));
SELECT setval('artists_artist_id_seq', (SELECT MAX(artist_id) FROM artists));
SELECT setval('albums_album_id_seq', (SELECT MAX(album_id) FROM albums));
SELECT setval('orders_order_id_seq', (SELECT MAX(order_id) FROM orders));
SELECT setval('order_items_order_item_id_seq', (SELECT MAX(order_item_id) FROM order_items));

INSERT INTO users (email, full_name, role) VALUES ('ion.pop@gmail.com', 'Ion Pop', 'client');
SELECT * FROM users WHERE role = 'client';
UPDATE users SET full_name = 'Ion Popescu-Mureșan' WHERE email = 'ion.pop@gmail.com';

INSERT INTO genres (name, description) VALUES ('Deathcore', 'Subgen extrem de metal.');
SELECT * FROM genres WHERE name = 'Thall';
UPDATE genres SET description = 'Descriere actualizată.' WHERE name = 'Thall';

INSERT INTO artists (name, country, formed_year) VALUES ('Periphery', 'SUA', 2005);
SELECT * FROM artists WHERE country = 'Suedia';
UPDATE artists SET country = 'Statele Unite' WHERE name = 'Periphery';

INSERT INTO albums (title, artist_id, genre_id, format, release_year, price, stock_quantity) 
VALUES ('Immutable', 2, 2, 'Vinil', 2022, 210.00, 5);
SELECT title, price, stock_quantity FROM albums WHERE format = 'Vinil';
UPDATE albums SET price = 199.99, stock_quantity = 7 WHERE title = 'Immutable';

INSERT INTO orders (user_id, status, total_amount) 
VALUES ('b1eebc99-9c0b-4ef8-bb6d-6bb9bd380b22', 'In asteptare', 175.00);
SELECT * FROM orders WHERE status = 'Finalizata';
UPDATE orders SET status = 'Expediata' WHERE status = 'In prelucrare';

INSERT INTO order_items (order_id, album_id, quantity, unit_price) VALUES (3, 3, 1, 175.00);
SELECT oi.order_item_id, a.title, oi.quantity, oi.unit_price 
FROM order_items oi 
JOIN albums a ON oi.album_id = a.album_id;
UPDATE order_items SET quantity = 2 WHERE order_item_id = 3;