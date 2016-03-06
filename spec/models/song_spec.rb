describe Song do
  it 'belongs to artist' do
    song = Song.create(name: 'Love Yourself')
    artist = Artist.create(name: 'Justin Bieber')
    artist.songs.append song
    expect(song.artist).to eq(artist)
  end

  describe 'validations' do
    it 'will not save if there is no name' do
      expect { Song.create }.to change(Song, :count).by 0
    end

    it 'will not save if the name is invalid' do
      expect { Song.create(name: 'asdj2sj') }.to change(Song, :count).by 0
    end

    it 'will save if there is a valid song' do
      expect { Song.create(name: 'Love Yourself') }.to change(Song, :count).by 1
    end
  end

  describe '#song_search' do
    before :each do
      @artist = Artist.create(name: 'Justin Bieber')
      @artist.songs.create name: 'Baby'
    end

    it 'returns a properly formatted artist name for the uri' do
      expect(@song.song_search).to eq('Baby+Justin+Bieber')
    end
  end
end
