describe 'song features' do
  describe '#new' do
    before :each do
      @artist = Artist.create(name: 'Justin Bieber')
      visit "artists/#{@artist.id}/songs/new"
    end

    it 'loads the page successfully' do
      expect(status_code).to eql(200)
    end

    it 'loads the correct page' do
      expect(page).to have_text('New song')
    end

    it 'has the correct fields' do
      expect(page).to have_field('song_name')
    end

    it 'creates a new song if song is valid' do
      @song = Song.new(name: 'Love Yourself')
      @song.artist = @artist
      if @song.in_spotify?
        @song.save
        @artist.songs.append @song
      end
      click_button 'Create Song'
      expect(Song.count).to eql(1)
      expect(@artist.songs.count).to eql(1)
      expect(Song.first).to eql(@song)
      expect(@artist.songs.first).to eql(@song)
    end

    it 'does not create a new song if song is invalid' do
      @song = Song.new(name: '123abc')
      @song.artist = @artist
      if @song.in_spotify?
        @song.save
        @artist.songs.append @song
      end
      click_button 'Create Song'
      expect(Song.count).to eql(0)
      expect(@artist.songs.count).to eql(0)
      expect(Song.first).to eql(nil)
      expect(@artist.songs.first).to eql(nil)
    end
  end

  describe '#show' do
    before :each do
      @artist = Artist.create(name: 'Justin Bieber')
      @song = Song.create(name: 'Love Yourself')
      @artist.songs.append @song
      visit "artists/#{@artist.id}/songs/#{@song.id}"
    end

    it 'loads page successfully' do
      expect(status_code).to eql(200)
    end

    it 'loads the correct page' do
      expect(page).to have_text(@song.name)
    end
  end

  describe '#destroy' do
    it 'deletes the song' do
      @artist = Artist.create(name: 'Justin Bieber')
      @artist.songs.create(name: 'Love Yourself')
      visit '/songs'
      click_link 'Destroy'
      expect(@artist.songs.count).to eql(0)
      expect(@artist.songs.first).to eql(nil)
      expect(Song.count).to eql(0)
      expect(Song.first).to eql(nil)
      expect(current_path).to eql('/songs')
    end
  end
end
