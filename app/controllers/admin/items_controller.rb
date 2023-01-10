class Admin::ItemsController < ApplicationController
  # before_action :correct_admin, only: [:new, :create, :edit, :update]
  before_action :authenticate_admin!

  def index
    @items = Item.page(params[:page])
    # @admin = current_admin
    # @genre = genre.find(params[:id])
  end

  def new
    @item = Item.new
    @genres = Genre.all

  end

  def create
    @item = Item.new(item_params)
    @items = Item.all
    if @item.save
      flash[:notice]="商品の新規登録に成功しました。"
      redairect_to admin_item_path
    else
      # @items = Item.all
      render :index
    end
  end

  def show
    @item = Item.find(params[:id])
    @genres = @item.genre
    @items = Item.page(params[:page])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    # @items = Item.all
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "更新できました。"
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :image, :genre_id, :price, :is_active)
  end

  # def corrent_admin
  #   @item = Item.find(params[:id])
  #   @admin = @item.admin
  #   if(current_admin.id != @admin.id)
  #     redirect_to items_path
  #   end
  # end

end
