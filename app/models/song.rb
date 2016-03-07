class Song < ActiveRecord::Base
  belongs_to :artist
  validates :name, presence: true, uniqueness: true

  def song_search
    "#{name.split(' ').join('+')}+#{artist.name.split(' ').join('+')}"
  end

  def spotify_uri
    return nil if !in_spotify?
    data = JSON.load(open("https://api.spotify.com/v1/search?q=#{song_search}&type=track"))
    data['tracks']['items'][1]['uri']
  end

  def in_spotify?
    return false if name.empty?
    data = JSON.load(open("https://api.spotify.com/v1/search?q=#{song_search}&type=track"))
    song_data = data['tracks']
    #store song_data in database
    # use or equals to check if its actually there 
    !song_data['items'].empty?
  end
end
