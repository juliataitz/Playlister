class Song < ActiveRecord::Base
  belongs_to :artist

  def song_search
    "#{name.split(' ').join('+')}+#{artist.name.split(' ').join('+')}"
  end

  def spotify_uri
    data = JSON.load(open("https://api.spotify.com/v1/search?q=#{song_search}&type=track"))
    data['tracks']['items'][1]['uri']
  end

  def is_valid?
    return false if name.empty?
    data = JSON.load(open("https://api.spotify.com/v1/search?q=#{song_search}&type=track"))
    song_data = data['tracks']
    !song_data['items'].empty?
  end
end
