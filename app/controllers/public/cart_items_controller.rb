class Public::CartItemsController < ApplicationController
  # helper_method :current_cart

  def index
    @cart_items = CartItem.all
    @items = Item.all
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_items = CartItem.all
    if @cart_item.save!
      flash[:notice]="商品の追加に成功しました。"
      redirect_to cart_items_path
    else
      render :index
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
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

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end

end
