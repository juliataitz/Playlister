# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
require 'open-uri'
require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])
