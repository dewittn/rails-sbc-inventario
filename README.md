# Inventario - An Embroidery Inventory Management System

From 2008 to 2011, I built Inventario as the first app of a business management suite for S.B.C. Panamá, my family's embroidery business in David, Panama.

While visiting in 2007, I noticed that the business was having trouble fulfilling orders because the inventory room was in total chaos. It had over 5,000 t-shirts crammed into unmarked cardboard boxes with no organization system. Workers spent 15 minutes digging through boxes for each order, often coming up empty even when the item was actually in stock somewhere in the room.

To help the family business, I leveraged my background in software development to build an inventory system that alleviated some bottlenecks. Before writing any code, I spent weeks working alongside staff, doing inventory counts, sorting shirts, and experiencing the frustrations firsthand. Then I hired a contractor in late 2007 to build the first version of the application while I worked with the business to create a flexible grid storage system that allowed workers to place inventory wherever it was convenient.

When the contractor quit in March 2008, I took over the development work and rewrote the entire system from scratch. By October 2008, I launched Inventario 2.0. But even the workflow I had developed for my rewrite was too rigid. Workers struggled to locate and restock inventory. So I kept watching. I observed how they used my application and where they were getting stuck. That second round of observation led to the features that made it work: a fuzzy search that understood "dark blue" rather than hex codes, a custom color picker for visual selection, and the separation of reinventory from order processing.

The result: order fulfillment dropped from 15 minutes to under 5. The application ran in production for over 5 years, managing more than 5,000 items, and was part of a suite that supported approximately $1.55M in total revenue over 6 years.

Read the full [S.B.C. Panamá case study](https://nelsonroberto.com/portfolio/sbc-panama/).

## What This Project Demonstrates

**End-to-end ownership.** When the contractor I hired quit, I took over completely. I rewrote the system from scratch, built the UI, handled deployment from Boston to Panama, and maintained the codebase through multiple Rails upgrades over five years. The final system was 12,000 lines of production code that I owned from problem discovery to ongoing maintenance.

**Iterative product development.** The first version I spec'd was too rigid. The second version I built was still too rigid. The system only worked after I watched workers struggle with it in production and built features to match how they actually thought: fuzzy search for approximate color descriptions, a visual color picker, and separated workflows for order fulfillment versus restocking. The insights came from observing failure, not just observing the problem.

**Production-grade engineering.** This system ran in production for over five years serving a real business. The architecture could have supported 50 to 100 concurrent users even though the immediate team was smaller: MySQL for the database, multi-layer caching, full-text search with Thinking Sphinx, remote deployment via Hamachi VPN and Capistrano, and production monitoring with NewRelic.

**Part of a larger system.** Inventario was the largest of five applications in the S.B.C. business management suite, totaling 15,400 lines of code and 441 commits across 42 months. I built and maintained all of it remotely while traveling between Boston and Panama.

## Screenshots

### Search & Browse Inventory
![Search Inventory](doc/images/search-inventory.png)
*Main search interface with filters for brand, color, size, type, and style. Results show quantity and bin location (row/column).*

### Select Items for Orders
![Select Order Items](doc/images/select-order-items.png)
*Adding items to an order. The "Por Sacar" panel shows items queued for pulling.*

### Fulfillment Queue
![Fulfillment Queue](doc/images/fulfillment-queue.png)
*The "Para Sacar" view lists all items to be pulled, organized by bin location for efficient warehouse picking.*

## Overview

This application helps manage inventory by:

- Tracking groups of shirts stored in bins
- Locating shirts to use for an order
- Restocking shirts after they have been pulled

**Tech Stack:**

- Ruby 2.7.8
- Rails 4.2.11.3
- MySQL 8.0 (production/development), SQLite3 (test)

## Quick Start

**Prerequisites:** Docker and Docker Compose

1. Clone and setup:

   ```bash
   git clone https://github.com/dewittn/rails-sbc-inventario
   cd rails-sbc-inventario
   cp .env.example .env
   ```

2. Start the application:

   ```bash
   docker compose build
   docker compose up -d
   docker compose exec web rake db:schema:load db:seed
   ```

3. Access at <http://localhost:3000>

   Login with username `admin` and password `password123`

## Documentation

See the [docs](./docs) folder for detailed information:

- [Docker Setup](./docs/docker.md) - Complete Docker configuration, environment variables, and troubleshooting
- [Authentication](./docs/authentication.md) - User management and login system
- [Development Guide](./docs/development.md) - Architecture, testing, and development workflow

## AI Usage

This project was developed primarily by hand from 2008 to 2011. The Rails 4.2 migration and Docker setup were completed in 2026 with assistance from Claude Code (Sonnet 4.5) for modernizing deployment and documentation.

## License

This project is provided as-is for portfolio and educational purposes. Contact the author for usage permissions.
