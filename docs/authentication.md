# Authentication

The application uses a username/password authentication system built on Rails 4.2's session handling.

## Default Admin User

When you run `rake db:seed`, a default admin user is created:

- **Username:** `admin`
- **Password:** `password123`
- **Login URL:** <http://localhost:3000/login>

**Important:** Change the admin password after first login in a production environment.

## Creating Users

Users can be created in two ways:

### Via Signup Form

Visit <http://localhost:3000/signup> and fill out the registration form.

### Via Rails Console

```bash
docker compose exec web rails console
```

Then create a user:

```ruby
User.create(
  login: 'username',
  email: 'user@example.com',
  password: 'password',
  password_confirmation: 'password',
  name: 'Full Name'
)
```

## Changing Passwords

### Via Rails Console

```bash
docker compose exec web rails console
```

Find and update the user:

```ruby
user = User.find_by(login: 'admin')
user.password = 'new_password'
user.password_confirmation = 'new_password'
user.save
```

## User Model

The User model includes:

- Password encryption using SHA1
- Remember me token for persistent sessions
- Email validation
- Login uniqueness validation

## Session Management

- Sessions are stored in cookies
- Session key: `_inventario2.0_session`
- Remember me tokens expire after 2 weeks

## Authentication System

The application uses the `AuthenticatedSystem` module which provides:

- Session-based authentication
- Basic HTTP authentication support
- Cookie-based remember me functionality
- `login_required` before filter for protected actions

## Protected Routes

Most routes require authentication. Public routes include:

- `/login` - Login page
- `/signup` - User registration
- `/register` - Registration endpoint (POST)

All inventory management features require an authenticated session.
