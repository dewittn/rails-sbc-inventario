# Development Guide

This guide covers local development for the Inventario application.

## Tech Stack

- **Ruby:** 2.7.8
- **Rails:** 4.2.11.3
- **Database:** MySQL 8.0 (production/development), SQLite3 (test)
- **Views:** HAML
- **Deployment:** Docker (local), Capistrano (historical production)

## Architecture Overview

### Domain Model

The application tracks clothing inventory with Spanish-language domain terms:

**Core Models:**

- `Inventario` - Central inventory items
- `Historia` - History tracking for each item
- `Orden` - Order tracking
- `Cambio` - Change records (quantity adjustments)
- `Factura` - Invoice tracking

**Lookup Tables:**

- `Marca` - Brand
- `Talla` - Size
- `Color` - Color
- `Tipo` - Type (e.g., polo, t-shirt)
- `Estilo` - Style
- `Genero` - Gender

### Controllers

**BuscarController** (root):
- Main interface for searching, creating, and updating inventory
- Page caching enabled for index/new actions

**SacarController**:
- Lists items marked for pulling (`por_sacar > 0`)
- Manages order fulfillment workflow

**ReinventariarController**:
- Re-inventory workflow for items needing verification

**Settings Controllers** (marcas, colores, tipos, tallas, estilos, generos):
- CRUD for lookup tables
- Cache sweepers for invalidation

### Caching Strategy

- Page caching on BuscarController (index, new)
- Cache sweepers for all lookup tables
- Sweepers expire buscar pages when lookup data changes

### Key Features

1. **Fuzzy Search**: Understands "dark blue" rather than hex codes
2. **Visual Color Picker**: Custom color selection UI
3. **Separated Workflows**: Reinventory vs. order processing
4. **Location Tracking**: Row/column (fila/columna) for bin storage
5. **History Tracking**: Automatic snapshot of changes

## Development Setup

### Using Docker (Recommended)

See [Docker Setup](./docker.md) for detailed instructions.

Quick start:

```bash
docker compose build
docker compose up -d
docker compose exec web rake db:schema:load db:seed
```

### Native Setup (Without Docker)

Requirements:
- Ruby 2.7.8
- MySQL 8.0
- Bundler 1.17.3

Steps:

```bash
# Install dependencies
bundle install

# Configure database
cp config/database.yml.example config/database.yml
# Edit database.yml with your MySQL credentials

# Setup database
rake db:schema:load
rake db:seed

# Start server
rails server
```

## Testing

### Run All Tests

```bash
docker compose exec web rake test
```

Or natively:

```bash
rake test
```

### Run Specific Tests

```bash
# Unit tests
rake test:units

# Functional tests
rake test:functionals

# Specific test file
ruby -Itest test/unit/inventario_test.rb
```

### Test Database

Tests use SQLite3 for speed:

```bash
rake db:test:prepare
```

## Common Development Tasks

### Database Console

```bash
docker compose exec db mysql -u postgres -p inventario_dev
```

Password: `makaveli` (default)

### Rails Console

```bash
docker compose exec web rails console
```

### Run Migrations

```bash
docker compose exec web rake db:migrate
```

### Reset Database

```bash
docker compose exec web rake db:reset
```

### Check Routes

```bash
docker compose exec web rake routes
```

## Code Patterns

### find_or_create Pattern

Used extensively for Factura, Orden, Ubicacion:

```ruby
def find_or_create_factura
  self.factura = Factura.find_or_create(numero_de_factura, fecha)
end
```

### Conditional Callbacks

```ruby
before_save :find_or_create_factura, :if => :update_ids
```

### History Tracking

Enabled via `record_historia` flag, creates Cambio records:

```ruby
after_create :create_history
```

### Form Data with attr_accessor

```ruby
attr_accessor :numero_de_factura, :fecha, :record_historia, :update_ids
```

## Migration History

This application was migrated from Rails 2.3.10 to Rails 4.2.11.3. Key changes:

- Converted from `script/*` commands to `rails` command
- Updated ActiveRecord query syntax
- Fixed mass assignment with strong parameters
- Updated routing DSL
- Modernized HAML syntax

See `UPGRADE_COMPLETE.md` for full migration details.

## Known Issues

- Git conflict markers exist in `app/models/inventario.rb:46-70` (merge not completed)
- Custom load path includes `app/sweepers`

## Contributing

This is a historical project demonstrating legacy Rails patterns. For substantial changes:

1. Create a feature branch
2. Write tests for new functionality
3. Ensure all tests pass
4. Submit a pull request with clear description

## Additional Resources

- [Docker Setup](./docker.md) - Container configuration
- [Authentication](./authentication.md) - User management
- Rails 4.2 Guides: https://guides.rubyonrails.org/v4.2/
