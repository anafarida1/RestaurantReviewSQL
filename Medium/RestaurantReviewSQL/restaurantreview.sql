CREATE DATABASE anaf54_restaurant_reviews;

CREATE TABLE restaurant (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    street_address VARCHAR(50),
    description VARCHAR(250)
);


CREATE TABLE review (
    id SERIAL PRIMARY KEY,
    restaurant_id INT NOT NULL,
    user_name VARCHAR(30),
    rating INT CHECK (rating >= 1 AND rating <= 5),
    review_text VARCHAR(500),
    review_date DATE DEFAULT CURRENT_DATE,

    CONSTRAINT fk_restaurant
        FOREIGN KEY (restaurant_id)
        REFERENCES restaurant (id)
        ON DELETE CASCADE
);


INSERT INTO restaurant (name, street_address, description)
VALUES
('Sate Madura Pak Ajit','Jl. Pahlawan No. 17, Bandung','Spesialis sate ayam dan sate kambing khas Madura.'),
('Nasi Goreng Bahagia','Jl. Meranti No. 45, Surabaya','Nasi goreng legendaris dengan banyak pilihan.'),
('Bakso Jos Gandos','Jl. Melati No. 23, Semarang','Bakso sapi dengan kuah gurih dan banyak tetelan.'),
('Pempek Meriah', 'Jl. Kenangan No. 7, Jakarta', 'Pempek ikan tengiri dengan cuko asli Palembang.');


INSERT INTO review (restaurant_id, user_name, rating, review_text, review_date)
VALUES
(1, 'Edo', 4, 'Satenya empuk, tidak bau amis dan bumbunya gurih.', '2025-09-21'),
(2, 'Ika', 3, 'Tempatnya sederhana tapi rasanya enak.', '2025-09-22'),
(2, 'Kety', 5, 'Nasi goreng ternikmat yang pernah saya coba.', '2025-09-23'),
(3, 'Budi', 4, 'Baksonya besar dan kenyal, kuahnya gurih banget.', '2025-09-24'),
(3, 'Yusuf', 5, 'Parkir luas, tempat nyaman, cocok buat makan bareng keluarga.', '2025-09-25'),
(4, 'Brian', 3, 'Pempeknya kebanyakan tepung, Kurang berasa ikan.', '2025-09-28')
(4, 'Joni', 4, 'Kuah cukonya terlalu asam.', '2025-09-27');


INSERT INTO restaurant (name, street_address, description)
VALUES
('Ayam Geprek Maknyos', 'Jl. Malabar No. 12, Tangerang', 'Ayam geprek dengan sambal pedas dan keju meleleh.');


INSERT INTO review (restaurant_id, user_name, rating, review_text, review_date)
VALUES 
(2, 'Bono', 4, 'Nasi goreng gongso babat, porsinya pas dan harganya ramah.', '2025-09-30');


SELECT * FROM review WHERE restaurant_id=2;


SELECT * FROM review WHERE rating >= 4;


SELECT rs.name, rv.rating, rv.review_text, rv.review_date
FROM restaurant rs 
JOIN review rv ON rs.id = rv.restaurant_id;


UPDATE restaurant
SET description = 'Bakso daging urat terenak dengan kuah gurih dan banyak tetelan.'
WHERE id = 3;


UPDATE review
SET rating = 3
WHERE restaurant_id = 1 AND user_name = 'Edo';


DELETE FROM review
WHERE id = 7;


DELETE FROM restaurant
WHERE id = 1 AND name = 'Sate Madura Pak Ajit';


SELECT *
FROM review;
    cte.max_review_data
FROM restaurant rs
INNER JOIN cte ON rs.id = cte.restaurant_id;


CREATE TABLE menu (
    id SERIAL PRIMARY KEY,
    restaurant_id INT NOT NULL,
    menu_name VARCHAR(100)
);


INSERT INTO menu (restaurant_id, menu_name)
VALUES
(2, 'Nasi Goreng Spesial'),
(2, 'Nasi Goreng Seafood'),
(2, 'Nasi Goreng Ayam'),
(3, 'Bakso Urat Spesial'),
(3, 'Bakso Telur Tetelan'),
(3, 'Bakso Daging Komplit'),
(4, 'Pempek Kapal Selam'),
(4, 'Pempek Lenjer'),
(4, 'Pempek Kulit');


WITH cte AS (
    SELECT 
        restaurant_id, 
        ROUND(AVG(rating), 1) AS avg_rating
    FROM review
    GROUP BY restaurant_id)

SELECT rs.name, mn.menu_name, cte.avg_rating
FROM restaurant rs
JOIN cte ON rs.id = cte.restaurant_id
JOIN menu mn ON rs.id = mn.restaurant_id;