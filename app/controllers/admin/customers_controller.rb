class Admin::CustomersController < ApplicationController
  before_action :correct_admin, only: [:index]
  
  def index
    @customers = Customer.all
    @adimin = current_admin
    @customer = customer.find(params[:id])
  end
  
  def show
    @customer = customer.find(params[:id])
    @admin = @customer.admin
  end
  
  def edit
    @customer = customer.find(params[:id])
  end
  
  def update
    @customers = Customer.all
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "更新できました。"
      redirect_to customer_path(@customer.id)
    else
      @admin = @customer.admin
      render :edit
    end
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :is_deleted)
  end
  
  def corrent_admin
    @customer = Customer.find(params[:id])
    @admin = @customer.admin
    if(current_admin.id != @admin.id)
      redirect_to customer_path
    end
  end
  
  def admin_check
    if admin_signed_in? && current_admin.role == "admin"
        riderect_to new_admin_product_path
    else
        render action: :edit
        flash[:alert] = "管理者画面です"
    end
  end
end
