class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :destroy]

  # GET /artists
  # GET /artists.json
  def index
    @artists = Artist.all
  end

  # GET /artists/1
  # GET /artists/1.json
  def show
  end

  # GET /artists/new
  def new
    @artist = Artist.new
  end

  # POST /artists
  # POST /artists.json
  def create
    @artist = Artist.find_or_initialize_by(name: artist_params[:name])
    
    if !@artist.songs.empty?
      song = Song.find_or_initialize_by(name: artist_params[:song_attributes][:name]) 
      song.artist = @artist
      @artist.songs << song if song.is_valid?
    end

    respond_to do |format|
    if @artist.is_valid?
        @artist.save
        format.html { redirect_to @artist, notice: 'Artist was successfully created.' }
        format.json { render :show, status: :created, location: @artist }
      else
        format.html { redirect_to new_artist_path, notice: 'Invalid Artist' }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.json
  def destroy
    # @songs = Song.all.find_by(:artist_id => @artist.id)
    # @songs.destroy
    @artist.destroy
    respond_to do |format|
      format.html { redirect_to artists_url, notice: 'Artist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artist_params
      params.require(:artist).permit(:name, song_attributes: [:name])
    end
end
