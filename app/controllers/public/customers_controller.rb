class Public::CustomersController < ApplicationController

  def show
  end

  def edit
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
  
  private
  
end
