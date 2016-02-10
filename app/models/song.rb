class Song < ActiveRecord::Base
  belongs_to :artist
  # accepts_nested_attributes_for :artist

  attr_reader :artist_name

  # def artist_name=(artist_name)
  #   self.artist = Artist.find_or_create_by(:name => artist_name.split.map(&:capitalize).join(' '))
  # end

  def song_search
  	self.name.split(' ').join('+') + '+' + self.artist.name.split(' ').join('+')
  end

  def get_spotify_uri
  	data = JSON.load(open("https://api.spotify.com/v1/search?q=#{song_search}&type=track"))
  	data["tracks"]["items"][1]["uri"]
  end

  def is_valid?
    data = JSON.load(open("https://api.spotify.com/v1/search?q=#{song_search}&type=track"))
    song_data = data["tracks"]
    !song_data["items"].empty?
  end
end

