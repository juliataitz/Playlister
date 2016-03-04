describe 'song features' do
  describe '#new' do
    before :each do
      visit 'artists/#{artist.id}/songs/new'
    end

    it 'loads page successfully' do
      expect(status_code).to eql(200)
    end

    it 'loads the correct page' do
      expect(page).to have_text('New Song')
    end

    it 'has the correct fields' do
      expect(page).to have_field('song_name')
    end

    it 'creates a new song' do
      click_button 'Create Song'
      expect(Song.count).to eql(1)
    end
  end

  describe '#destroy' do
    it 'deletes the song' do
      @artist = Artist.create(name: 'Justin Bieber')
      @song = @artist.songs.create(name: 'Baby')
      visit '/songs'

      click_link 'Destroy', href: "/songs/#{@song.id}"
      expect(@aritst.songs.size).to eql(0)
      expect(current_path).to eql('/songs')
    end
  end

  describe '#show' do
    before :each do
      @aritst = Artist.create(name: 'Justin Bieber')
      @song = @artist.songs.create(name: 'Baby')
      visit 'artists/#{@artist.id}/songs/#{@song.id}'
    end

    it 'loads page successfully' do
      expect(status_code).to eql(200)
    end

    it 'loads the correct page' do
      expect(page).to have_text('#{song.name}')
    end
  end
end
