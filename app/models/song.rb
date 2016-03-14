class Song < ActiveRecord::Base
  belongs_to :artist
  validates :name, presence: true, uniqueness: true

  def song_search
    "#{name.split(' ').join('+')}+#{artist.name.split(' ').join('+')}"
  end

  def spotify_uri
    return nil unless in_spotify?
    data = JSON.load(open("https://api.spotify.com/v1/search?q=#{song_search}&type=track"))
    data['tracks']['items'][1]['uri']
  end

  def in_spotify?
    return false if name.empty?
    data = JSON.load(open("https://api.spotify.com/v1/search?q=#{song_search}&type=track"))
    song_data = data['tracks']
    !song_data['items'].empty?
  end

  def add_artist(params)
    artist = Artist.find_or_create_by(id: params[:artist_id])
    self.artist = artist
    if in_spotify?
      save
      artist.songs.append self
      return true
    end
    false
  end
end
