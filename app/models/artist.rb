class Artist < ActiveRecord::Base
  has_many :songs, dependent: :destroy

  def artist_search
  	self.name.split(' ').join('+')
  end

  def is_valid?
  	data = JSON.load(open("https://api.spotify.com/v1/search?q=#{artist_search}&type=artist"))
  	artist_data = data["artists"]
  	!artist_data["items"].empty?
  end
end
