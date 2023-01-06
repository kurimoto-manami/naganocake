class Admin::GenresController < ApplicationController
  # before_action :set_genre, only: [:edit, :update]

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new
    if @genres.save
      flash[:notice] = "ジャンルを追加しました。"
      redirect_to genres_path
    else
      @genres = Genre.all
      render 'index'
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "ジャンルを変更しました。"
      redirect_to genres_path
    else
      render 'edit'
    end
  end

  private

    # def set_genre
    #   @genre = Genre.find(params[:id])
    # end

    def genre_params
      params.require(:genre).permit(:name)
    end
end