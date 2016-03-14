describe Artist do
  describe 'has_many songs' do
    before :each do
      @artist = Artist.create(name: 'Justin Bieber')
    end

    it 'has many songs' do
      expect { @artist.songs.create name: 'Love Yourself' }.to change(Song, :count).by 1
      expect(@artist.songs.first.name).to eql('Love Yourself')
    end

    it 'deletes associated songs' do
      num_songs = @artist.songs.size * -1
      expect { @artist.destroy }.to change(Song, :count).by num_songs
      expect(@artist.songs.first).to eql(nil)
    end
  end

  describe 'validations' do
    it 'will not save artist without a name' do
      expect { Artist.create }.to change(Artist, :count).by 0
      expect(Artist.first).to eql(nil)
    end

    it 'will save an artist with valid name' do
      expect { Artist.create(name: 'Justin Bieber') }.to change(Artist, :count).by 1
      expect(Artist.first.name).to eql('Justin Bieber')
    end
  end

  describe '#artist_search' do
    it 'returns a properly formatted artist name for the uri' do
      artist = Artist.create(name: 'Justin Bieber')
      expect(artist.artist_search).to eq('Justin+Bieber')
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

  describe '#add_song' do
    before :each do
      @artist = Artist.new(name: 'Justin Bieber')
      @artist2 = Artist.new(name: 'abc123')
      @params = { name: 'Justin Bieber', song_attributes: { name: '' } }
      @params_valid_artist_valid_song = { name: 'Justin Bieber', song_attributes: { name: 'Love Yourself' } }
      @params_valid_artist_invalid_song = { name: 'Justin Bieber', song_attributes: { name: '123abc' } }
      @params_invalid_artist = { name: 'abc123', song_attributes: { name: '' } }
      @params_invalid_artist_valid_song = { name: 'abc123', song_attributes: { name: 'Love Yourself' } }
      @params_invalid_artist_invalid_song = { name: 'abc123', song_attributes: { name: '123abc' } }
    end

    it 'returns true and saves if an artist is valid and has no song' do
      expect(@artist.add_song(@params)).to eql(true)
      expect(Artist.last.name).to eql(@params[:name])
      expect(Song.last).to eql(nil)
    end

    it 'returns true and saves if an artist is valid and a song is valid' do
      expect(@artist.add_song(@params_valid_artist_valid_song)).to eql(true)
      expect(Artist.last.name).to eql(@params_valid_artist_valid_song[:name])
      expect(Song.last.name).to eql(@params_valid_artist_valid_song[:song_attributes][:name])
    end

    it 'returns true and saves if an artist is valid and a song is invalid' do
      expect(@artist.add_song(@params_valid_artist_invalid_song)).to eql(true)
      expect(Artist.last.name).to eql(@params_valid_artist_valid_song[:name])
      expect(Song.last).to eql(nil)
    end

    it 'returns false and does not save if an artist is invalid and has no song' do
      expect(@artist2.add_song(@params_invalid_artist)).to eql(false)
      expect(Artist.last).to eql(nil)
      expect(Song.last).to eql(nil)
    end

    it 'returns false and does not save if an artist is invalid and has a valid song' do
      expect(@artist2.add_song(@params_invalid_artist_valid_song)).to eql(false)
      expect(Artist.last).to eql(nil)
      expect(Song.last).to eql(nil)
    end

    it 'returns false and does not save if an artist is invalid and has an invalid song' do
      expect(@artist2.add_song(@params_invalid_artist_invalid_song)).to eql(false)
      expect(Artist.last).to eql(nil)
      expect(Song.last).to eql(nil)
    end
  end
end
