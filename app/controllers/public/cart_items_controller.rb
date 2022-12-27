class Public::CartItemsController < ApplicationController
  # helper_method :current_cart

  def index
    @cart_items = CartItem.all
  end

  def create

  end

  def update
    if @cart_item.update(quantity: params[:quantity].to_i)
      flash[:notice] = 'カート内の情報が更新されました。'
    else
      flash[:alert] = 'カート内の情報の更新に失敗しました。'
    end
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    CartItem.destroy_all
    redirect_to cart_items_path
  end

  private

end
