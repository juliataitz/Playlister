describe Artist do
  describe 'has_many songs' do
    before :each do
      @artist = Artist.create(name: 'Justin Bieber')
    end

    it 'has many songs' do
      expect { @artist.songs.create name: 'Love Yourself' }.to change(Song, :count).by 1
      #expect that artsit to have that song
    end

    it 'deletes associated songs' do
      num_songs = @artist.songs.size * -1
      expect { @artist.destroy }.to change(Song, :count).by num_songs
    end
  end

  describe 'validations' do
    it 'will not save artist without a name' do
      expect { Artist.create }.to change(Artist, :count).by 0
    end

    it 'will save an artist with valid name' do
      expect { Artist.create(name: 'Justin Bieber') }.to change(Artist, :count).by 1
    end
  end

  describe '#artist_search' do
    it 'returns a properly formatted artist name for the uri' do
      @artist = Artist.create(name: 'Justin Bieber')
      expect(@artist.artist_search).to eq('Justin+Bieber')
    end
  end

  describe '#in_spotify?' do
    before :each do
      @artist = Artist.create(name: 'Justin Bieber')
      @artist2 = Artist.create(name: 'abc123')
    end

    it 'returns true if artist is in spotify' do
      expect(@artist.in_spotify?).to eql(true)
    end

    it 'returns false if artist is not in spotify' do
      expect(@artist2.in_spotify?).to eql(false)
    end
  end
end
