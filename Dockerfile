FROM ruby:3.1.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y --fix-missing nodejs postgresql-client yarn

# Set working directory
WORKDIR /app

# Add Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Add the rest of the code
COPY . .

# Precompile assets (for production)
# RUN bundle exec rake assets:precompile

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose port 3000 to the outside world
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]