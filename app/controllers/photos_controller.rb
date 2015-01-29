class PhotosController < ApplicationController
  before_action :signed_in_user, only: [:show, :index, :new, :edit, :update, :destroy]
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  helper_method :sort_column, :sort_direction

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 10)

    if params[:tag]
      @photos = @photos.tagged_with(params[:tag])
    end

  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)

    if @photo.save
      redirect_to alum_path(@photo.alum)
      flash[:success] = "Photo was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    if @photo.update(photo_params)
      redirect_to alum_path(@photo.alum)

      flash[:success] = "Photo was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    if params[:user]
      redirect_to user_path(params[:user])
    else
      redirect_to alum_path(@photo.alum)
    end
    flash[:success] = "Photo was successfully deleted."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:photo_filename, :user_id, :photo_date, :photo_notes, :photograph, :category_id, :tag_list, :alum_id)
    end

    def sort_column
      Photo.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

end
