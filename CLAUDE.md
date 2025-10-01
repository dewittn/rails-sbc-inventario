# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Rails 2.3.10 inventory tracking application for SBC in Panamá (2007-2011). Spanish-language domain model for managing clothing inventory with attributes like marca (brand), talla (size), color, tipo (type), estilo (style), and genero (gender).

## Commands

### Database
- **Development**: MySQL (`inventario_dev`)
- **Test**: SQLite3 (`db/test.sqlite3`)
- **Setup**: `rake db:migrate`
- **Console**: `script/console` (Rails 2.x style)

### Testing
- Run all tests: `rake test`
- Run specific test: `ruby -Itest test/unit/inventario_test.rb`
- Test functional: `rake test:functionals`
- Test units: `rake test:units`

### Server
- Start server: `script/server` (Rails 2.x style)
- Default port: 3000

### Dependencies
- Required gems: `will_paginate`, `haml`, `mysql`
- Install: Ensure gems are available (Rails 2.3 doesn't use Bundler)

## Architecture

### Core Domain Models

**Inventario** (central model - inventory items):
- Associations: `tipo`, `talla`, `color`, `marca`, `estilo`, `genero`, `factura`, `ubicacion`, `historia`
- Key features:
  - Pagination via `pag_search` with dynamic scoping
  - Location tracking via `row` (fila) and `column` (columna)
  - Order tracking: `nombre_de_orden`, `numero_de_orden`, `por_sacar` (quantity to pull)
  - Automatic history creation via `create_history` after_create callback
  - Invoice linkage via `find_or_create_factura` before_save

**Historia** (history tracking):
- Records initial inventory entry with snapshot of attributes
- Has_many `cambios` (changes)
- Links to `factura` (invoice) and `inventario`

**Orden** (order tracking):
- Custom `find_or_create` for nombre/numero pairs
- Tracks changes via `cambios` through historia

**Cambio** (change records):
- Tracks quantity changes per order
- Records delta (`cambio`) and new quantity

### Controllers

**BuscarController** (search/CRUD - root):
- Main interface for searching, creating, and updating inventory
- Page caching enabled for index/new
- Uses `search_inventory` from ApplicationController

**SacarController** (pulling/fulfillment):
- Lists items marked for pulling (`por_sacar > 0`)
- Manages order fulfillment workflow
- Clears `por_sacar` and order info after processing

**ReinventariarController**:
- Handles re-inventory workflow for items needing verification

**AvanzadoController** (advanced features):
- Extended functionality beyond basic search

**Settings Controllers** (marcas, colores, tipos, tallas, estilos, generos):
- CRUD for lookup tables
- Each has associated sweeper for cache invalidation

### Authentication

- Uses `AuthenticatedSystem` module (lib/)
- Session-based, basic auth, and cookie-based authentication
- User model with remember_token functionality
- `login_required` filter available for protected actions

### Caching Strategy

- Page caching on BuscarController (index, new)
- Cache sweepers for all lookup tables (marca, color, tipo, talla, estilo, genero)
- Sweepers expire buscar pages when lookup data changes

### Important Patterns

1. **find_or_create pattern**: Used extensively for Factura, Orden, Ubicacion
2. **attr_accessor for form data**: `numero_de_factura`, `fecha`, `record_historia`, `update_ids`
3. **Conditional callbacks**: `before_save :find_or_create_factura, :if => :update_ids`
4. **History tracking**: Enabled via `record_historia` flag, creates Cambio records with order info
5. **Spanish naming**: All domain terms use Spanish (talla=size, marca=brand, genero=gender, etc.)

### Database Notes

- Git conflict markers exist in `app/models/inventario.rb:46-70` (merge not completed)
- Custom load path includes `app/sweepers`
- Migrations include location refactoring (removing ubicacion table, adding row/column directly)
- Uses will_paginate for pagination (`paginate`, `pag_search`)

### Routes Structure

- Resources: `reinventariar`, `avanzado`, `buscar`, `sacar`
- Custom routes: `/nuevo` -> buscar#new
- Auth routes: `/login`, `/logout`, `/signup`, `/register`
- Settings: `marcas`, `colores`, `tipos`, `tallas`, `estilos`, `generos`
- Root: `buscar` controller

## Development Notes

- Rails 2.3.10 uses `script/*` commands, not `rails` command
- HAML views (not ERB)
- Session key: `_inventario2.0_session`
- Capistrano deployment configured (Capfile present)
- Email configuration in `config/initializers/email.expamle.rb` (typo in filename)
