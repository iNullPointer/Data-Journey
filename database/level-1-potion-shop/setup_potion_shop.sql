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
create table potions (
	potion_id SERIAL primary key,
	name TEXT not null,
	price DECIMAL (10,2) not null,
	stock INT not null
);

-- Customers - The Heroes
create table customers (
	customer_id SERIAL primary key,
	hero_name TEXT not null,
	class TEXT not null,
	is_alive BOOLEAN default true
);

-- Orders - The Sales History
create table orders (
	order_id SERIAL primary key,
	potion_id INT not null,
	customer_id INT not null,
	quantity INT not null default 1,
	order_date TIMESTAMP default current_TIMESTAMP,
	
	--FK link to ID
	constraint fk_potions foreign key (potion_id) references potions(potion_id),
	constraint fk_customers foreign key (customer_id) references customers(customer_id)
	);


-- ----------------------------------------------------------------------------
-- 3. DATA POPULATION (DML)
-- ----------------------------------------------------------------------------

-- Populating Potion Inventory 
insert into potions (name, price, stock) values
('Health Elixir', 12.50, 15),
('Mana Potion', 15.00, 20),
('Poison Antidote', 8.99, 10),
('Fire Resistance', 11.75, 10),
('Invisibility', 15.00, 20);

-- Populating Customers (The Heroes)
insert into customers (hero_name, class, is_alive) values
('Mario', 'Warrior', true),
('Alvo', 'Mage', false),
('Frodo', 'Healer', true),
('Dean', 'Hunter', true),
('Vecna', 'Mage', false);

-- Registering Orders (Sales)
insert into orders (potion_id, customer_id, quantity) values
(1, 1, 2),
(2, 2, 1),
(5, 3, 5),
(3, 4, 3),
(4, 5, 2);


-- ----------------------------------------------------------------------------
-- 4. VERIFICATION / TESTING (Queries)
-- ----------------------------------------------------------------------------

-- Relational query to generate a complete sales report with names (JOIN)
select * from potions order by price asc;

select hero_name, class from customers where is_alive = false;

select
	c.hero_name as hero,
	p.name as potion_name,
	o.quantity as quantity,
	o.order_date as date_and_hour
from orders o
join customers c on o.customer_id = c.customer_id
join potions p on o.potion_id = p.potion_id;

