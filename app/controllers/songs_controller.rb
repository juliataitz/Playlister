class SongsController < ApplicationController
  before_action :set_song, only: [:show, :destroy]

  def all
    @songs = Song.all
  end

  # GET /songs
  # GET /songs.json
  def index
    @songs = Song.all
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    @song = Song.new
    @song.artist = Artist.find(params[:artist_id])
  end

  # POST /songs
  # POST /songs.json
  def create
    artist = Artist.find_or_create_by(id: params[:artist_id])
    @song = Song.new(name: song_params[:name])
    @song.artist = artist
    respond_to do |format|
      if @song.in_spotify?
        @song.save
        artist.songs.append @song
        format.html { redirect_to artist_songs_path(artist.id), notice: 'Song was successfully created.' }
        format.json { render action: 'show', status: :created, location: @song }
      else
        format.html { redirect_to new_artist_song_path, notice: 'Invalid Song' }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_song
    @song = Song.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def song_params
    params.require(:song).permit(:name)
  end
end
