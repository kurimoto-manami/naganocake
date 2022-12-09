class Admin::ItemsController < ApplicationController
  before_action :correct_admin, only: [:new, :create, :edit, :update]
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    @item.admin_id = currrent_admin.id
    
  end
  
  def index
    @items = Item.all
  end
  
  def show
  end
  
  def edit
  end
  
end
