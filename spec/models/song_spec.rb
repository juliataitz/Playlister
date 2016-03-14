describe Song do
  describe 'belongs to artist' do
    it 'belongs to artist' do
      song = Song.create(name: 'Love Yourself')
      artist = Artist.create(name: 'Justin Bieber')
      artist.songs.append song
      expect(song.artist).to eq(artist)
    end
  end

  describe 'validations' do
    it 'will not save if there is no name' do
      expect { Song.create }.to change(Song, :count).by 0
      expect(Song.first).to eql(nil)
    end

    it 'will save if there is a valid song' do
      expect { Song.create(name: 'Love Yourself') }.to change(Song, :count).by 1
      expect(Song.first.name).to eql('Love Yourself')
    end
  end

  describe '#song_search' do
    it 'returns a properly formatted artist name for the uri' do
      song = Song.create(name: 'Love Yourself')
      artist = Artist.create(name: 'Justin Bieber')
      artist.songs.append song
      expect(song.song_search).to eq('Love+Yourself+Justin+Bieber')
    end
  end

  describe '#in_spotify?' do
    it 'returns true if artist and song are in spotify' do
      song = Song.create(name: 'Love Yourself')
      artist = Artist.create(name: 'Justin Bieber')
      artist.songs.append song
      expect(song.in_spotify?).to eql(true)
    end

    it 'returns false if artist is in spotify but song is not' do
      song = Song.create(name: '123abc')
      artist = Artist.create(name: 'Justin Bieber')
      artist.songs.append song
      expect(song.in_spotify?).to eql(false)
    end

    it 'returns false if artist is not in spotify but song is' do
      song = Song.create(name: 'Love Yourself')
      artist = Artist.create(name: 'abc123')
      artist.songs.append song
      expect(song.in_spotify?).to eql(false)
    end
  end

  describe '#spotify_uri' do
    it 'returns the proper uri of a valid song' do
      artist = Artist.create(name: 'Justin Bieber')
      artist.songs.create(name: 'Love Yourself')
      expect(artist.songs.first.spotify_uri).to eql('spotify:track:2p7Qt540YPkuXasIaJ6Q4p')
    end

    it 'returns nil for invalid song' do
      artist = Artist.create(name: 'Justin Bieber')
      artist.songs.create(name: '123abc')
      expect(artist.songs.first.spotify_uri).to eql(nil)
    end
  end

  describe '#add_artist' do
    before :each do
      @song = Song.new(name: 'Love Yourself')
      @song2 = Song.new(name: '123abc')
      @artist = Artist.create(name: 'Justin Bieber')
      @params = { utf8: '',
                  authenticity_token: '',
                  song: { name: '' },
                  commit: 'Create Song',
                  controlle: 'songs',
                  action: 'create',
                  artist_id: 1 }
    end
    it 'returns true if a valid song is made with a valid artist' do
      expect(@song.add_artist(@params)).to eql(true)
      expect(Song.last.name).to eql(@song.name)
    end

    it 'returns false if an invalid song is made with a valid artist' do
      expect(@song2.add_artist(@params)).to eql(false)
      expect(Song.last).to eql(nil)
    end
  end
end
