class Public::AddressesController < ApplicationController

  def index
    @addresses = Address.all
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @addresses = Address.all
    @address = Address.page(params[:page])
    if @address.save
      flash[:notice]="配送先の新規登録に成功しました。"
      redirect_to addresses_path
    else
      render :index
    end
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    if @address.save
      flash[:notice] = "You have updated user successfully."
      redirect_to address_path(@address.id)
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end
end
