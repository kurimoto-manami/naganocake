class Public::ItemsController < ApplicationController

  def item_params
    params.require(:item).permit(:name, :introduction, :image, :genre_id, :price, :is_active)
  end
end
