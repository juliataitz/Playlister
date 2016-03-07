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
      visit '/artists'
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

    it 'links to the destroy page' do
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
      within(all('.field').first) do
        fill_in('Name', with: @artist.name)
      end
      click_button('Create Artist')
      expect(Artist.count).to eql(1)
      expect(Song.count).to eql(0)
    end

    it 'can create an artist with a new song' do
      fill_in 'artist_name', with: @artist.name
      fill_in 'artist_song_attributes_name', with: @song.name
      click_button('Create Artist')
      expect(Artist.count).to eql(1)
      expect(Song.count).to eql(1)
    end

    it 'cannot create an invalid artist with a valid song' do
      fill_in 'artist_name', with: @artist2.name
      fill_in 'artist_song_attributes_name', with: @song.name
      click_button('Create Artist')
      expect(Artist.count).to eql(0)
      expect(Song.count).to eql(0)
    end

    it 'cannot create an invalid artist with an invalid song' do
      fill_in 'artist_name', with: @artist2.name
      fill_in 'artist_song_attributes_name', with: @song2.name
      click_button('Create Artist')
      expect(Artist.count).to eql(0)
      expect(Song.count).to eql(0)
    end
  end

  describe '#show' do
    before :each do
      @artist = Artist.create(name: 'Justin Bieber')
      @song = @artist.songs.create(name: 'Love Yourself')
      @artist.songs.append @song
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
    before :each do
      @artist = Artist.create(name: 'Justin Bieber')
      visit '/artists'
    end

    it 'is deleted when Destroy is clicked' do
      click_link 'Destroy'
      expect(current_path).to eql('/artists')
      expect(Artist.count).to eql(0)
    end
  end

  describe '#create' do
    it 'creates a valid artist' do
      @artist = Artist.find_or_initialize_by(name: 'Justin Bieber')
      @artist.save if @artist.in_spotify?
      expect(Artist.count).to eql(1)
    end

    it 'does not create an invalid artist' do
      @artist = Artist.find_or_initialize_by(name: 'abc123')
      @artist.save if @artist.in_spotify?
      expect(Artist.count).to eql(0)
    end
  end
end
