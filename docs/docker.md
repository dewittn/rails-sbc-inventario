# Docker Setup

This guide covers running the Inventario application using Docker.

## Prerequisites

- [Docker](https://www.docker.com/get-started) (20.10 or higher)
- [Docker Compose](https://docs.docker.com/compose/install/) (1.29 or higher)
- Git

## Initial Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/dewittn/rails-sbc-inventario
   cd rails-sbc-inventario
   ```

2. Set up environment variables:

   ```bash
   cp .env.example .env
   ```

   Edit `.env` if you need to customize settings (optional). The default values work out of the box.

3. Build and start the containers:

   ```bash
   docker compose build
   docker compose up -d
   ```

4. Set up the database:

   ```bash
   docker compose exec web rake db:schema:load
   docker compose exec web rake db:seed
   ```

5. Access the application:
   - Open your browser to <http://localhost:3000>
   - Login at <http://localhost:3000/login> with:
     - Username: `admin`
     - Password: `password123`

## Common Commands

### Container Management

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

**Restart containers:**

```bash
docker compose restart
```

### Rails Commands

**Access Rails console:**

```bash
docker compose exec web rails console
```

**Run migrations:**

```bash
docker compose exec web rake db:migrate
```

**Seed the database:**

```bash
docker compose exec web rake db:seed
```

**Run tests:**

```bash
docker compose exec web rake test
```

## Environment Variables

The application uses a `.env` file for configuration. Copy `.env.example` to `.env` to get started.

Available environment variables:

| Variable | Description | Default |
|----------|-------------|---------|
| `MYSQL_ROOT_PASSWORD` | MySQL root password | makaveli |
| `MYSQL_DATABASE` | Database name | inventario_dev |
| `MYSQL_USER` | Database user | postgres |
| `MYSQL_PASSWORD` | Database password | makaveli |
| `DATABASE_HOST` | Database host | db |
| `MYSQL_PORT` | MySQL port mapping | 3306 |
| `RAILS_PORT` | Rails application port | 3000 |
| `RAILS_ENV` | Rails environment | development |
| `BUNDLER_VERSION` | Bundler version | 1.17.3 |

## Database Information

- **Database:** MySQL 8.0
- **Database name:** Configured via `MYSQL_DATABASE` (default: inventario_dev)
- **Username:** Configured via `MYSQL_USER` (default: postgres)
- **Password:** Configured via `MYSQL_PASSWORD` (default: makaveli)
- **Host:** Configured via `DATABASE_HOST` (default: db within Docker network)
- **Port:** Configured via `MYSQL_PORT` (default: 3306, accessible from host at localhost:3306)

## Troubleshooting

### Database Connection Fails

The database might still be initializing. Wait a few seconds and try again:

```bash
docker compose logs db    # Check if MySQL is ready
docker compose restart web
```

### Reset the Database

If you need to start fresh:

```bash
docker compose exec web rake db:drop db:schema:load db:seed
```

### Rebuild from Scratch

If containers are in a bad state:

```bash
docker compose down -v           # Remove containers and volumes
docker compose build --no-cache  # Rebuild without cache
docker compose up -d
docker compose exec web rake db:schema:load db:seed
```

### Port Already in Use

If port 3000 or 3306 is already in use, edit `.env` and change `RAILS_PORT` or `MYSQL_PORT` to different values:

```bash
RAILS_PORT=3001
MYSQL_PORT=3307
```

Then restart:

```bash
docker compose down
docker compose up -d
```

### Permission Issues on Linux

If you encounter permission issues with volumes on Linux, you may need to adjust file ownership:

```bash
sudo chown -R $USER:$USER .
```

## Development Workflow

1. Make code changes in your editor
2. Changes are reflected immediately (no rebuild needed for most changes)
3. For Gemfile changes, rebuild:
   ```bash
   docker compose build web
   docker compose restart web
   ```
4. For database schema changes:
   ```bash
   docker compose exec web rake db:migrate
   ```

## Production Considerations

This Docker setup is intended for local development only. For production deployment:

- Use proper secrets management (not `.env` files)
- Configure a production-grade database
- Set `RAILS_ENV=production`
- Configure proper logging and monitoring
- Use a reverse proxy (nginx/Apache) in front of Rails
- Enable SSL/TLS
