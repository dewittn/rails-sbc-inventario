FROM ruby:2.7.8

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  default-libmysqlclient-dev \
  nodejs \
  && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock* ./
RUN gem update --system 3.4.22 && \
    gem uninstall bundler -v 2.4.22 -x && \
    gem install bundler -v '~> 1.17' && \
    bundle _1.17.3_ install

# Copy application code
COPY . .

# Expose port
EXPOSE 3000

# Start server
CMD ["rails", "server", "-b", "0.0.0.0"]
