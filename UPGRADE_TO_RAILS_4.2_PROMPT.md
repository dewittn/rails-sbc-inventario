# Rails 4.2 Upgrade Instructions for Claude Code

This document contains detailed instructions for upgrading this Rails 2.3.10 application to Rails 4.2.11.3. Follow these steps sequentially and commit changes after each major step.

## Prerequisites

Before starting:
1. Read CLAUDE.md to understand the application architecture
2. Ensure you have Ruby 2.3+ available (Rails 4.2 supports Ruby 2.0-2.6)
3. This is a legacy app - focus on making it run, not on modern conventions

## Important: Commit Strategy

**Commit after completing each numbered section below**. Use descriptive commit messages like:
- "Step 1: Resolve merge conflict in inventario.rb"
- "Step 2: Create initial Gemfile for Rails 4.2"
- "Step 3: Update configuration files"

If a step fails, commit what works and document blockers before proceeding.

---

## Step 1: Fix Existing Issues

### 1.1 Resolve Merge Conflict
The file `app/models/inventario.rb` has unresolved git conflict markers at lines 46-70. Examine the code and resolve the conflict:
- The conflict is between two versions of `por_sacar` and `count_camisas` methods
- Choose the version that makes sense or merge both approaches
- Remove all `<<<<<<<`, `=======`, and `>>>>>>>` markers
- Ensure the file has valid Ruby syntax

**Commit:** "Fix merge conflict in inventario.rb"

---

## Step 2: Create Gemfile

Rails 4.2 uses Bundler. Create a new `Gemfile` in the root directory:

```ruby
source 'https://rubygems.org'

ruby '2.3.8' # Or whatever version you're using

gem 'rails', '4.2.11.3'

# Database
gem 'mysql2', '~> 0.3.20' # Rails 4.2 compatible version
gem 'sqlite3', '~> 1.3.13' # For test environment

# Views
gem 'haml', '~> 4.0'

# Pagination
gem 'will_paginate', '~> 3.1.0'

# Authentication (replaces restful_authentication plugin)
gem 'bcrypt', '~> 3.1.7'

# Exception notification
gem 'exception_notification', '~> 4.1.0'

group :development, :test do
  gem 'byebug'
end

group :test do
  gem 'test-unit', '~> 3.0'
end
```

Run `bundle install` and commit the Gemfile and Gemfile.lock.

**Commit:** "Add Gemfile for Rails 4.2"

---

## Step 3: Update Configuration Files

### 3.1 Delete Obsolete Files
- Delete `config/boot.rb` (no longer needed)
- Delete `public/dispatch.rb` (obsolete)

### 3.2 Create config/application.rb

Create a new file `config/application.rb`:

```ruby
require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module SbcInventario
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true
    config.active_record.raise_in_transactional_callbacks = true

    # Load sweepers from app/sweepers (will need to refactor these later)
    config.autoload_paths += %W(#{config.root}/app/sweepers)

    # Session configuration
    config.session_store :cookie_store, key: '_inventario2.0_session'
    config.secret_key_base = '***REMOVED***'
  end
end
```

### 3.3 Update config/environment.rb

Replace the entire contents with:

```ruby
# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
```

### 3.4 Update Environment Files

Update `config/environments/development.rb`:
```ruby
Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true
  config.assets.digest = true
  config.assets.raise_runtime_errors = true
end
```

Update `config/environments/production.rb`:
```ruby
Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.serve_static_files = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.js_compressor = :uglifier
  config.assets.compile = false
  config.assets.digest = true
  config.log_level = :info
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.active_record.dump_schema_after_migration = false
end
```

Update `config/environments/test.rb` similarly.

### 3.5 Create config/boot.rb (minimal version)

```ruby
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup'
```

### 3.6 Update config/database.yml

Change adapter from `mysql` to `mysql2`:
```yaml
development:
  adapter: mysql2  # Changed from mysql
  database: inventario_dev
  username: postgres
  password: ***REMOVED***
  host: localhost
  encoding: utf8
```

Do the same for production environment.

**Commit:** "Update configuration files for Rails 4.2"

---

## Step 4: Update Routes

Replace `config/routes.rb` with Rails 4 syntax:

```ruby
Rails.application.routes.draw do
  resources :reinventariar, :avanzado, :buscar
  resources :sacar do
    collection do
      put :sacar_temporal
    end
  end

  resources :javascripts, only: [] do
    collection do
      post :nombre_de_orden
      post :numero_de_orden
      post :por_sacar
      post :agregar_otro_para_sacar
      post :cantidad_update
      post :factura
      post :reinventariar
      post :limpiar
    end
  end

  get '/nuevo', to: 'buscar#new', as: :nuevo
  get '/logout', to: 'sessions#destroy', as: :logout
  get '/login', to: 'sessions#new', as: :login
  post '/register', to: 'users#create', as: :register
  get '/signup', to: 'users#new', as: :signup

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :admin, only: [:index]
  resources :reports, only: [:index]
  resources :settings, only: [:index]
  resources :marcas, :colores, :tipos, :tallas, :estilos, :generos, except: [:show]

  root 'buscar#index'
end
```

**Commit:** "Update routes to Rails 4 syntax"

---

## Step 5: Update Models

### 5.1 Create ApplicationRecord

Rails 4.2 doesn't have ApplicationRecord (that's Rails 5+), but create a base class in `app/models/application_record.rb` for future compatibility:

```ruby
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
```

### 5.2 Update All Models

For each model file in `app/models/`, replace `< ActiveRecord::Base` with `< ApplicationRecord`.

### 5.3 Update ActiveRecord Queries

In `app/models/inventario.rb`:
- Replace `find(:all)` with `all`
- Replace `find(:first, ...)` with `find_by(...)`
- Replace `.scoped({})` with `.all`

In `app/models/orden.rb`:
- Replace `find(:first, :conditions => [...])` with `where(...).first`

### 5.4 Update Deprecated Methods

Search for and replace:
- `update_attribute` → `update_column` (skips validations) or `update_attributes` → `update` (runs validations)
- Any `attr_accessible` stays (Rails 4.2 supports it with protected_attributes gem, but we'll use strong params)

**Commit:** "Update models for Rails 4.2 compatibility"

---

## Step 6: Update Controllers

### 6.1 Create ApplicationController Base

Ensure `app/controllers/application_controller.rb` is updated:

```ruby
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper :all
  include AuthenticatedSystem
  # Remove: include ExceptionNotifiable (now configured differently)

  def search_inventory
    @por_sacar = Inventario.find(session[:por_sacar]) unless session[:por_sacar].blank?
    @inventarios = Inventario.pag_search(search_parmas)
  end

  def search_parmas
    read_values(:color_id, :tipo_id, :talla_id, :marca_id, :genero_id, :estilo_id, :row, :column, :id, :page).merge(!params[:updated_at].blank? ? {order: :updated_at} : {})
  end

  def read_values(*values)
    search = {}
    values.each do |key|
      search = search.merge(key => params[key]) unless params[key].blank?
    end
    search
  end
end
```

### 6.2 Global Find and Replace in Controllers

- `before_filter` → `before_action`
- `skip_before_filter` → `skip_before_action`

### 6.3 Add Strong Parameters

For each controller that accepts params, add private methods. Example for `colores_controller.rb`:

```ruby
private

def color_params
  params.require(:color).permit(:descr)
end
```

Then replace `params[:color]` with `color_params` in create/update actions.

Do this for:
- `buscar_controller.rb` - add `inventario_params`
- `colores_controller.rb` - add `color_params`
- `marcas_controller.rb` - add `marca_params`
- `tipos_controller.rb` - add `tipo_params`
- `tallas_controller.rb` - add `talla_params`
- `estilos_controller.rb` - add `estilo_params`
- `generos_controller.rb` - add `genero_params`
- `users_controller.rb` - add `user_params`

### 6.4 Update Render Calls

- `render :text => "something"` → `render plain: "something"`
- `render :json => obj` → `render json: obj` (should work but check)

### 6.5 Handle Cache Sweepers

Cache sweepers are deprecated. For now, comment out or remove the `cache_sweeper` lines in controllers. The page caching will need alternative implementation (skip for now, just get it running).

**Commit:** "Update controllers for Rails 4.2 with strong parameters"

---

## Step 7: Update Authentication System

### 7.1 Extract Plugin Code

The `restful_authentication` plugin code needs to be extracted. The authentication modules are in `lib/authenticated_system.rb` and the User model includes modules from the plugin.

Copy the plugin's authentication modules from `vendor/plugins/restful_authentication/lib/authentication*` to `lib/` directory so they're available.

### 7.2 Update User Model

Ensure the User model works with the authentication modules. The model should already have the proper includes.

**Commit:** "Extract authentication code from plugins"

---

## Step 8: Update Initializers

### 8.1 Check config/initializers/

- `inflections.rb` - should work as-is
- `mime_types.rb` - should work as-is
- `new_rails_defaults.rb` - DELETE (obsolete)
- `site_keys.rb` - review and update if needed

### 8.2 Add Secret Token (if not in application.rb)

If you didn't add `config.secret_key_base` to application.rb, create `config/initializers/secret_token.rb`:

```ruby
Rails.application.config.secret_key_base = '***REMOVED***'
```

**Commit:** "Update initializers for Rails 4.2"

---

## Step 9: Update Migrations

### 9.1 Rename Old Migrations

The old numbered migrations (001-013) should be renamed to use timestamps. However, for a legacy app, they can stay as-is if the database is already set up.

If starting fresh, you can use the existing schema.rb instead of running migrations.

### 9.2 Update Migration Syntax

In migrations, you can optionally update `self.up`/`self.down` to `change`, but this is not required for Rails 4.2.

**Commit:** "Review and update migrations"

---

## Step 10: Update Scripts and Rake Tasks

### 10.1 Delete Old Scripts

Delete the `script/` directory. Rails 4.2 uses `bin/` instead.

### 10.2 Create bin/ Scripts

Run: `rake rails:update:bin` or manually create:

`bin/rails`:
```ruby
#!/usr/bin/env ruby
APP_PATH = File.expand_path('../../config/application', __FILE__)
require_relative '../config/boot'
require 'rails/commands'
```

`bin/rake`:
```ruby
#!/usr/bin/env ruby
require_relative '../config/boot'
require 'rake'
Rake.application.run
```

Make them executable: `chmod +x bin/rails bin/rake`

**Commit:** "Add Rails 4.2 bin scripts"

---

## Step 11: Asset Pipeline Setup

### 11.1 Create Asset Directories

```
mkdir -p app/assets/javascripts
mkdir -p app/assets/stylesheets
mkdir -p app/assets/images
```

### 11.2 Move Assets

Move files from `public/javascripts/` to `app/assets/javascripts/` (except prototype.js and libraries - keep in public/ or vendor/assets/)

### 11.3 Create Manifest Files

Create `app/assets/javascripts/application.js`:
```javascript
//= require jquery
//= require jquery_ujs
//= require_tree .
```

Create `app/assets/stylesheets/application.css`:
```css
/*
 *= require_tree .
 *= require_self
 */
```

### 11.4 Update Gemfile

Add to Gemfile:
```ruby
gem 'jquery-rails'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
```

Run `bundle install`

**Commit:** "Set up asset pipeline"

---

## Step 12: Update Views

### 12.1 Check HAML Views

Most HAML views should work as-is. Test each page after the app runs.

### 12.2 Update Helper Usage

Check for deprecated helper methods. Most should work in Rails 4.2.

**Commit:** "Review views for Rails 4.2 compatibility"

---

## Step 13: Update Tests

### 13.1 Update Test Helper

Update `test/test_helper.rb`:

```ruby
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all

  # Add authentication test helpers if needed
end
```

### 13.2 Run Tests

Try running: `rake test`

Fix any failures related to:
- Fixture loading
- Changed assertions
- Route helpers

**Commit:** "Update tests for Rails 4.2"

---

## Step 14: Database Setup

### 14.1 Load Schema

If you have an existing database, you're good. Otherwise:

```bash
rake db:create
rake db:schema:load  # Preferred over db:migrate for existing schema
```

### 14.2 Test Database Connection

```bash
rails console
> Inventario.count
> User.count
```

**Commit:** "Verify database setup"

---

## Step 15: Create Dockerfile

Create a `Dockerfile` in the root:

```dockerfile
FROM ruby:2.3.8

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  default-libmysqlclient-dev \
  nodejs \
  && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy application code
COPY . .

# Precompile assets
RUN RAILS_ENV=production bundle exec rake assets:precompile

# Expose port
EXPOSE 3000

# Start server
CMD ["rails", "server", "-b", "0.0.0.0"]
```

Create `docker-compose.yml`:

```yaml
version: '3.8'

services:
  db:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: ***REMOVED***
      MYSQL_DATABASE: inventario_dev
      MYSQL_USER: postgres
      MYSQL_PASSWORD: ***REMOVED***
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql

  web:
    build: .
    command: bundle exec rails server -b 0.0.0.0
    volumes:
      - .:/app
      - bundle_cache:/usr/local/bundle
    ports:
      - "3000:3000"
    depends_on:
      - db
    environment:
      DATABASE_HOST: db
      RAILS_ENV: development

volumes:
  mysql_data:
  bundle_cache:
```

Update `config/database.yml` to use environment variables:

```yaml
development:
  adapter: mysql2
  database: inventario_dev
  username: postgres
  password: ***REMOVED***
  host: <%= ENV['DATABASE_HOST'] || 'localhost' %>
  encoding: utf8
```

### 15.1 Test Docker Setup

```bash
docker-compose build
docker-compose up -d db
docker-compose run web rake db:create db:schema:load
docker-compose up web
```

Visit http://localhost:3000

**Commit:** "Add Docker support for testing"

---

## Step 16: Final Testing

### 16.1 Start the Server

```bash
rails server
```

Or with Docker:
```bash
docker-compose up
```

### 16.2 Test Key Functionality

1. Visit root page (buscar)
2. Try searching inventory
3. Try creating a new inventory item
4. Test login/logout
5. Test settings pages (marcas, colores, etc.)
6. Test sacar (fulfillment) workflow
7. Test admin pages

### 16.3 Check Logs

Look for deprecation warnings in `log/development.log` and address critical ones.

**Commit:** "Complete Rails 4.2 upgrade - application functional"

---

## Troubleshooting

### Common Issues:

1. **LoadError for gems**: Check Gemfile versions, run `bundle update`
2. **Routing errors**: Check `rake routes` output vs. old routes
3. **Mass assignment errors**: Ensure strong params are implemented
4. **Authentication issues**: Verify plugin code was extracted properly
5. **Asset not found**: Check asset pipeline configuration
6. **MySQL connection**: Ensure mysql2 gem installed and database.yml correct
7. **Deprecation warnings**: Note them but don't block on them unless they cause errors

### Rollback Strategy:

Each step is committed separately. If a step fails catastrophically:
```bash
git log --oneline  # Find last good commit
git reset --hard <commit-hash>
```

---

## Success Criteria

The upgrade is complete when:
- [ ] Application starts without errors (`rails server` works)
- [ ] Database connections work (console queries succeed)
- [ ] Main pages load (root, login, settings)
- [ ] User can log in
- [ ] Can create/edit/delete inventory items
- [ ] Can search inventory
- [ ] Docker container runs successfully
- [ ] All changes committed to git

---

## Post-Upgrade Tasks (Optional)

After the app is running on Rails 4.2:
1. Replace cache sweepers with alternative caching strategy
2. Modernize JavaScript (replace Prototype with jQuery/vanilla JS)
3. Add integration tests
4. Security audit
5. Plan upgrade to Rails 5+ if desired

---

## Notes

- This upgrade prioritizes **getting the app running** over modernization
- Some deprecation warnings are acceptable
- Focus on one step at a time
- Test after each major change
- Commit frequently with clear messages
- Document any blockers or workarounds in commit messages
