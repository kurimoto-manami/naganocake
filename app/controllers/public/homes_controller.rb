class Public::HomesController < ApplicationController
  def top
    @item = Item.all
    # @item = Item.find(params[:id])
  end
end
