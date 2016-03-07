describe 'artist features' do
  describe '#index' do
    before :each do
      @artist = Artist.create(name: 'Justin Bieber')
      visit '/artists'
    end

    it 'loads the page successfully' do
      expect(status_code).to eql(200)
    end

    it 'renders the right page' do
      expect(page).to have_text('Listing Artists')
    end

    it 'lists all artists' do
      expect(page).to have_text(@artist.name)
    end

    it 'does not show Edit link' do
      expect(page).to_not have_text('Edit')
    end

    it 'has Show and Destroy' do
      expect(page).to have_text('Show')
      expect(page).to have_text('Destroy')
    end

    it 'links to the show page' do
      click_link 'Show'
      expect(current_path).to eql("/artists/#{@artist.id}")
    end

    it 'destroy redirects to index' do
      click_link 'Destroy'
      expect(current_path).to eql('/artists')
    end
  end

  describe '#new' do
    before :each do
      @artist = Artist.new(name: 'Justin Bieber')
      @song = Song.new(name: 'Love Yourself')
      @artist2 = Artist.new(name: 'abc123')
      @song2 = Song.new(name: '123abc')
      visit '/artists/new'
    end

    it 'loads the page successfully' do
      expect(status_code).to eql(200)
    end

    it 'has the name fields for song and artist' do
      expect(page).to have_field('artist_name')
      expect(page).to have_field('artist_song_attributes_name')
    end

    it 'can create an artist without a new song' do
      fill_in 'artist_name', with: @artist.name
      click_button('Create Artist')
      expect(Artist.count).to eql(1)
      expect(Song.count).to eql(0)
      expect(Artist.first.name).to eql(@artist.name)
      expect(Song.first).to eql(nil)
    end

    it 'can create an artist with a new song' do
      fill_in 'artist_name', with: @artist.name
      fill_in 'artist_song_attributes_name', with: @song.name
      click_button('Create Artist')
      expect(Artist.count).to eql(1)
      expect(Song.count).to eql(1)
      expect(Artist.first.name).to eql(@artist.name)
      expect(Song.first.name).to eql(@song.name)
    end

    it 'cannot create an invalid artist with a valid song' do
      fill_in 'artist_name', with: @artist2.name
      fill_in 'artist_song_attributes_name', with: @song.name
      click_button('Create Artist')
      expect(Artist.count).to eql(0)
      expect(Song.count).to eql(0)
      expect(Artist.first).to eql(nil)
      expect(Song.first).to eql(nil)
    end

    it 'cannot create an invalid artist with an invalid song' do
      fill_in 'artist_name', with: @artist2.name
      fill_in 'artist_song_attributes_name', with: @song2.name
      click_button('Create Artist')
      expect(Artist.count).to eql(0)
      expect(Song.count).to eql(0)
      expect(Artist.first).to eql(nil)
      expect(Song.first).to eql(nil)
    end
  end

  describe '#show' do
    before :each do
      @artist = Artist.create(name: 'Justin Bieber')
      @song = @artist.songs.create(name: 'Love Yourself')
      visit "/artists/#{@artist.id}"
    end

    it 'loads the page successfully' do
      expect(status_code).to eql(200)
    end

    it 'loads the correct page' do
      expect(page).to have_text(@artist.name)
    end

    it 'lists the artist\'s songs' do
      expect(page).to have_selector('iframe')
    end

    it 'has new song link' do
      expect(page).to have_text('New Song')
      click_link 'New Song'
      expect(current_path).to eql("/artists/#{@artist.id}/songs/new")
    end
  end

  describe '#destroy' do
    it 'is deleted when Destroy is clicked' do
      @artist = Artist.create(name: 'Justin Bieber')
      visit '/artists'
      click_link 'Destroy'
      expect(current_path).to eql('/artists')
      expect(Artist.count).to eql(0)
      expect(Artist.first).to eql(nil)
    end
  end
end
