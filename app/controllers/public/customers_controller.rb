class Public::CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    customer_id = params[:id].to_i
    unless customer_id == current_customer.id
      redirect_to items_path
    end
    @customer = Customer.find(params[:id])
  end

  def update
    customer_id = params[:id].to_i
    unless customer_id == current_customer.id
      redirect_to items_path
    end
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    if @customer.save
      flash[:notice] = "You have updated user successfully."
      redirect_to customer_path(@customer.id)
    else
      render :edit
    end
  end

  def unsubscribe
    @customer = Customer.find(params[:id])
  end

  def withdrawal
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :password)
  end

end
