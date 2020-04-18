DROP TABLE tickets;
DROP TABLE customers;
DROP TABLE films;

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    funds NUMERIC(10, 4)
);

CREATE TABLE films (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    price NUMERIC(10, 4)
);

CREATE TABLE tickets (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
    film_id INT REFERENCES films(id) ON DELETE CASCADE
);