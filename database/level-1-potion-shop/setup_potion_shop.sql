-- ============================================================================
-- PROJECT: The Potion Shop Database (Level 1 Boss)
-- AUTHOR: Computer Engineering Student (Universidade Aberta)
-- DESCRIPTION: PostgreSQL script for table creation, constraints, 
--              data population, and relational testing.
-- ============================================================================
-- ----------------------------------------------------------------------------
-- 1. CLEANUP (Drop tables in reverse order of dependencies if they exist)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS orders;

DROP TABLE IF EXISTS customers;

DROP TABLE IF EXISTS potions;
-- ----------------------------------------------------------------------------
-- 2. DATABASE STRUCTURE (DDL)
-- ----------------------------------------------------------------------------
-- Potions - The Inventory
CREATE TABLE potions (
	potion_id SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	price DECIMAL (10,
2) NOT NULL,
	stock INT NOT NULL
);
-- Customers - The Heroes
CREATE TABLE customers (
	customer_id SERIAL PRIMARY KEY,
	hero_name TEXT NOT NULL,
	CLASS TEXT NOT NULL,
	is_alive BOOLEAN DEFAULT TRUE
);
-- Orders - The Sales History
CREATE TABLE orders (
	order_id SERIAL PRIMARY KEY,
	potion_id INT NOT NULL,
	customer_id INT NOT NULL,
	quantity INT NOT NULL DEFAULT 1,
	order_date TIMESTAMP DEFAULT current_TIMESTAMP,
--FK link to ID
	CONSTRAINT fk_potions FOREIGN KEY (potion_id) REFERENCES potions(potion_id),
	CONSTRAINT fk_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
	);
-- ----------------------------------------------------------------------------
-- 3. DATA POPULATION (DML)
-- ----------------------------------------------------------------------------
-- Populating Potion Inventory 
INSERT
	INTO
	potions (name,
	price,
	stock)
VALUES
('Health Elixir', 12.50, 15),
('Mana Potion', 15.00, 20),
('Poison Antidote', 8.99, 10),
('Fire Resistance', 11.75, 10),
('Invisibility', 15.00, 20);
-- Populating Customers (The Heroes)
INSERT
	INTO
	customers (hero_name,
	CLASS,
	is_alive)
VALUES
('Mario', 'Warrior', TRUE),
('Alvo', 'Mage', FALSE),
('Frodo', 'Healer', TRUE),
('Dean', 'Hunter', TRUE),
('Vecna', 'Mage', FALSE);
-- Registering Orders (Sales)
INSERT
	INTO
	orders (potion_id,
	customer_id,
	quantity)
VALUES
(1, 1, 2),
(2, 2, 1),
(5, 3, 5),
(3, 4, 3),
(4, 5, 2);
-- ----------------------------------------------------------------------------
-- 4. VERIFICATION / TESTING (Queries)
-- ----------------------------------------------------------------------------
-- Relational query to generate a complete sales report with names (JOIN)
SELECT
	*
FROM
	potions
ORDER BY
	price DESC;

SELECT
	hero_name,
	CLASS
FROM
	customers
WHERE
	is_alive = FALSE;

SELECT
	c.hero_name AS hero,
	p.name AS potion_name,
	o.quantity AS quantity,
	o.order_date AS date_and_hour
FROM
	orders o
JOIN customers c ON
	o.customer_id = c.customer_id
JOIN potions p ON
	o.potion_id = p.potion_id;
