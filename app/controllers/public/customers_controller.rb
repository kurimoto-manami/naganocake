class Public::CustomersController < ApplicationController

  def show
    @customer_url
  end

  def edit
    @customer = customer.find(params[:id])
  end

  def unsubscribe
    @Customer = Customer.find(params[:id])
  end

  def withdrawal
    @Customer = Customer.find(params[:id])
    @Customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def customer_params
    params.require(:customer).permit(:name, :name_kana, :email, :postal_code, :address, :telephone_number, :password)
  end

  private

end
