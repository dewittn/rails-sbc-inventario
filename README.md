# SBC Inventario

This was an inventory tracking Rails application that I developed from 2007 to 2011 for SBC in Panamá.

## Getting Started with Docker

The easiest way to run this application is using Docker Compose.

### Prerequisites

- Docker Desktop (or Docker Engine + Docker Compose)
- Git

### Setup and Run

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd rails-sbc-inventario
   ```

2. Build and start the containers:
   ```bash
   docker compose build
   docker compose up -d
   ```

3. Set up the database:
   ```bash
   docker compose exec web rake db:schema:load
   docker compose exec web rake db:seed
   ```

4. Access the application:
   - Open your browser to http://localhost:3000
   - Login at http://localhost:3000/login with:
     - Username: `admin`
     - Password: `password123`

### Common Docker Commands

**View running containers:**
```bash
docker compose ps
```

**View logs:**
```bash
docker compose logs web      # Rails application logs
docker compose logs db       # MySQL database logs
docker compose logs -f       # Follow all logs in real-time
```

**Stop the containers:**
```bash
docker compose stop
```

**Stop and remove containers:**
```bash
docker compose down
```

**Access Rails console:**
```bash
docker compose exec web rails console
```

**Run migrations:**
```bash
docker compose exec web rake db:migrate
```

**Seed the database (creates admin user):**
```bash
docker compose exec web rake db:seed
```

**Run tests:**
```bash
docker compose exec web rake test
```

**Restart containers:**
```bash
docker compose restart
```

### Database Information

- **Database:** MySQL 8.0
- **Database name:** inventario_dev
- **Username:** postgres
- **Password:** ***REMOVED***
- **Host:** db (within Docker network)
- **Port:** 3306 (accessible from host at localhost:3306)

### Troubleshooting

**If the database connection fails:**

The database might still be initializing. Wait a few seconds and try again:
```bash
docker compose logs db    # Check if MySQL is ready
docker compose restart web
```

**If you need to reset the database:**
```bash
docker compose exec web rake db:drop db:schema:load db:seed
```

**If you need to rebuild from scratch:**
```bash
docker compose down -v           # Remove containers and volumes
docker compose build --no-cache  # Rebuild without cache
docker compose up -d
docker compose exec web rake db:schema:load db:seed
```

## Authentication

The application uses a username/password authentication system.

### Default Admin User

When you run `rake db:seed`, a default admin user is created:

- **Username:** `admin`
- **Password:** `password123`
- **Login URL:** http://localhost:3000/login

**Important:** Change the admin password after first login in a production environment.

### Creating Additional Users

Users can be created in two ways:

1. **Via signup form:** Visit http://localhost:3000/signup
2. **Via Rails console:**
   ```bash
   docker compose exec web rails console
   # Then:
   User.create(
     login: 'username',
     email: 'user@example.com',
     password: 'password',
     password_confirmation: 'password',
     name: 'Full Name'
   )
   ```

## Technical Details

- **Ruby version:** 2.7.8
- **Rails version:** 4.2.11.3
- **Database:** MySQL 8.0 (production/development), SQLite3 (test)
