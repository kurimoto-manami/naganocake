class Public::ItemsController < ApplicationController

  def index
    @items = @genre.item.id
  end
  
  def show
    @item = item.find(params[:id])
  end

  private
  
  def item_params
    params.require(:item).permit(:name, :introduction, :image, :genre_id, :price, :is_active)
  end
end
