# 🧪 The Potion Shop - Entity-Relationship Diagram (ERD)

In this stage of the project, I developed the data modeling blueprint for the Potion Shop ecosystem. The primary objective was to design a clean, normalized relational database architecture that efficiently separates master data storage from real-time transaction history.

## 🧠 Hardware Analogy (RAM vs. HDD/SSD)
To conceptualize the dynamics of this database, we can bridge it with the computer architecture fundamentals explored in the previous quest:

* **Master Entity Tables (`potions` and `customers`):** These operate like the **HDD/SSD**. They store permanent, independent master records (the product inventory and the heroes' register).
* **Transactional Table (`orders`):** This operates like the **RAM**. It is a highly dynamic table designed to process interactions in real-time (who is buying what, and when), linking the permanent entities together using **Foreign Keys (FK)** without duplicating master data.

## 📐 The Diagram (ERD)
Below is the conceptual model drafted for the project, showcasing the table structures, primary keys (PK), foreign keys (FK), and data types (including integers, decimals, timestamps, and the boolean `is_alive` state):

![Potion Shop ERD](images/erd_potion_shop.png)

---
*This model serves as the architectural blueprint for the PostgreSQL script implementation.*
