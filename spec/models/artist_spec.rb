require 'spec_helper'

describe Artist do
  describe 'has_many songs' do
    before :each do
      @artist = Artist.create(name: 'Justin Bieber')
      # @artist.songs.create name: 'Baby'
      @song = Song.create(name: 'Baby')
      @artist.songs.append @song
    end

    it 'has many songs' do
      expect { @artist.songs.create name: 'Baby' }.to change(Song, :count).by 1
    end

    it 'deletes associated songs' do
      num_songs = @artist.songs.size * -1
      expect { @artist.destroy }.to change(Song, :count).by num_songs
    end
  end

  describe 'validations' do
    it 'will not save without a name' do
      expect { Artist.create }.to change(Artist, :count).by 0
    end

    it 'will not save an arist with an invalid name' do
      expect { Artist.create(name: 'tasdasdas') }.to change(Artist, :count).by 0
    end

    it 'will save the user with proper data' do
      expect { Artist.create(name: 'Selena Gomez') }.to change(Artist, :count).by 1
    end
  end

  describe '#artist_search' do
    before :each do
      @artist = Artist.create(name: 'Justin Bieber')
      @artist.songs.create name: 'Baby'
    end
    
    it 'returns a properly formatted artist name for the uri' do
      expect(@artist.artist_search).to eq('Justin+Bieber')
    end
  end
end
