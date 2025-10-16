# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Create default admin user
admin = User.find_or_create_by(login: 'admin') do |u|
  u.email = 'admin@example.com'
  u.password = 'password123'
  u.password_confirmation = 'password123'
  u.name = 'Admin User'
end

if admin.persisted?
  puts "✓ Admin user created/verified: #{admin.login} (#{admin.email})"
  puts "  Login at: /login"
  puts "  Username: admin"
  puts "  Password: password123"
else
  puts "✗ Failed to create admin user:"
  admin.errors.full_messages.each { |msg| puts "  - #{msg}" }
end
