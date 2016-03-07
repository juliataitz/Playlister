class Artist < ActiveRecord::Base
  has_many :songs, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  
  def artist_search
    name.split(' ').join('+')
  end

  def in_spotify?
    return false if name.empty?
    data = JSON.load(open("https://api.spotify.com/v1/search?q=#{artist_search}&type=artist"))
    artist_data = data['artists']
    !artist_data['items'].empty?
  end
end
