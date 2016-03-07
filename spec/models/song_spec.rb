describe Song do
  describe 'belongs to artist' do
    it 'belongs to artist' do
      @song = Song.create(name: 'Love Yourself')
      @artist = Artist.create(name: 'Justin Bieber')
      @artist.songs.append @song
      expect(@song.artist).to eq(@artist)
    end
  end
  describe 'validations' do
    it 'will not save if there is no name' do
      expect { Song.create }.to change(Song, :count).by 0
    end

    it 'will save if there is a valid song' do
      expect { Song.create(name: 'Love Yourself') }.to change(Song, :count).by 1
    end
  end

  describe '#song_search' do
    before :each do
      @song = Song.create(name: 'Love Yourself')
      @artist = Artist.create(name: 'Justin Bieber')
      @artist.songs.append @song
    end

    it 'returns a properly formatted artist name for the uri' do
      expect(@song.song_search).to eq('Love+Yourself+Justin+Bieber')
    end
  end

  describe '#in_spotify?' do
    it 'returns true if artist and song are in spotify' do
      @song = Song.create(name: 'Love Yourself')
      @artist = Artist.create(name: 'Justin Bieber')
      @artist.songs.append @song
      expect(@song.in_spotify?).to eql(true)
    end

    it 'returns false if artist is in spotify but song is not' do
      @song = Song.create(name: '123abc')
      @artist = Artist.create(name: 'Justin Bieber')
      @artist.songs.append @song
      expect(@song.in_spotify?).to eql(false)
    end

    it 'returns false if artist is not in spotify but song is' do
      @song = Song.create(name: 'Love Yourself')
      @artist = Artist.create(name: 'abc123')
      @artist.songs.append @song
      expect(@song.in_spotify?).to eql(false)    
    end
  end
end
