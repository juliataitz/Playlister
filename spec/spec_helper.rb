# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
Bundler.require(:default, ENV['RAILS_ENV'])
require 'webmock/rspec'
require 'capybara/rspec'
require 'capybara/dsl'
# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234

  config.include Capybara::DSL

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.before(:example) do
    url_artist_valid = 'https://api.spotify.com/v1/search?q=Justin+Bieber&type=artist'
    url_song_valid = 'https://api.spotify.com/v1/search?q=Love+Yourself+Justin+Bieber&type=track'
    url_artist_invalid = 'https://api.spotify.com/v1/search?q=abc123&type=artist'
    url_song_invalid = 'https://api.spotify.com/v1/search?q=123abc+abc123&type=track'
    url_artist_invalid_song_valid = 'https://api.spotify.com/v1/search?q=Love+Yourself+abc123&type=track'
    url_artist_valid_song_invalid = 'https://api.spotify.com/v1/search?q=123abc+Justin+Bieber&type=track'
    valid_artist_json = File.read('spec/fixtures/valid_artist.json')
    valid_song_json = File.read('spec/fixtures/valid_song.json')
    invalid_artist_json = File.read('spec/fixtures/invalid_artist.json')
    invalid_song_json = File.read('spec/fixtures/invalid_song.json')
    invalid_artist_valid_song_json = File.read('spec/fixtures/invalid_artist_valid_song.json')
    valid_artist_invalid_song_json = File.read('spec/fixtures/valid_artist_invalid_song.json')
    stub_request(:get, url_artist_valid).to_return(body: valid_artist_json)
    stub_request(:get, url_song_valid).to_return(body: valid_song_json)
    stub_request(:get, url_artist_invalid).to_return(body: invalid_artist_json)
    stub_request(:get, url_song_invalid).to_return(body: invalid_song_json)
    stub_request(:get, url_artist_invalid_song_valid).to_return(body: invalid_artist_valid_song_json)
    stub_request(:get, url_artist_valid_song_invalid).to_return(body: valid_artist_invalid_song_json)
  end
end
