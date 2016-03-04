describe 'artist features' do
  describe '#index' do
    before :each do
      @artist = Artist.create(name: 'Justin Bieber')
    end

    it 'loads the page successfully' do
      expect(status_code).to eql(200)
    end

    it 'lists all artists' do
      Artist.create(name: 'Justin Bieber')
      visit '/users'
      expect(page).to have_text(@artist.name)
    end

    it 'does not show Edit link' do
      expect(page).to_not have_text('Edit')
    end

    it 'shows Show and Destroy' do
      expect(page).to have_text('Show')
      expect(page).to have_text('Destroy')
    end

    it 'links to the show page' do
      click_link 'Show'
      expect(current_path).to eql("/artists/#{@artist.id}")
    end

    it 'links to the destroy page' do
      click_link 'Destroy'
      expect(current_path).to eql("/artists/#{@artist.id}/destroy")
    end
  end

  describe '#new' do
    before :each do
      visit '/artists/new'
    end

    it 'loads the page successfully' do
      expect(status_code).to eql(200)
    end

    it 'has the name fields for song and artist' do
      expect(page).to have_field('artist_name')
      expect(page).to have_field('song_name')
    end

    it 'creates a new artist' do
      click_button 'Create Artist'
      expect(Artist.count).to eql(1)
    end

    it 'creates a new song' do
      click_button 'Create Artist'
      expect(Song.count).to eql(1)
    end
  end

  describe '#show' do
    before :each do
      @artist = Artist.create(name: 'Justin Bieber')
      @song = @artist.songs.create(name: 'Baby')
      visit "/artists/#{@artist.id}"
    end

    it 'loads the page successfully' do
      expect(status_code).to eql(200)
    end

    it 'loads the correct page' do
      expect(page).to have_text(@artist.name)
    end

    it 'lists the artist\'s songs' do
      expect(page).to have_text(@song.name)
    end

    it 'has New Song link' do
      expect(page).to have_text('New Song')
      click_link 'New Status'
      expect(current_path).to eql('artists/#{@artist.id}/songs/new')
    end
  end
  describe '#destroy' do
    it 'is deleted when Destroy is clicked' do
      artist = Artist.create(name: 'Justin Bieber')
      click_link 'Destroy', href: "/artists/#{artist.id}"
      expect(current_path).to eql('/artists')
      expect(Artist.count).to eql(0)
    end
  end
end
