class Public::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :image, :genre_id, :price, :is_active)
  end

  def genre_params
      params.require(:genre).permit(:name)
  end
end
