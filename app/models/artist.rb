require 'open-uri'

class Artist < ActiveRecord::Base
  validate :valid_artist_check
  has_many :songs, dependent: :destroy

  def artist_search
  	self.name.split(' ').join('+')
  end

  def valid_artist_check #change to is_valid?() returns true/false
  	data = JSON.load(open("https://api.spotify.com/v1/search?q=#{artist_search}&type=artist"))
  	artist_data = data["artists"]

  	if artist_data["items"].empty?
  		errors.add(:artist, "Must be Valid Artist")
  	end
  end
end