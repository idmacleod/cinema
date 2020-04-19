DROP TABLE tickets;
DROP TABLE screenings;
DROP TABLE customers;
DROP TABLE films;

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    funds NUMERIC(20, 4)
);

CREATE TABLE films (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    price NUMERIC(20, 4)
);

CREATE TABLE screenings (
    id SERIAL PRIMARY KEY,
    start_time TIMESTAMP,
    film_id INT REFERENCES films(id) ON DELETE CASCADE
);

CREATE TABLE tickets (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
    screening_id INT REFERENCES screenings(id) ON DELETE CASCADE
);