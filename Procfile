web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
worker: bundle exec sidekiq --config ./config/sidekiq.yml --require ./app.rb
