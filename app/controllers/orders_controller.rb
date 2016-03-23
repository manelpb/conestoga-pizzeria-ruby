class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :check_admin, only: [:deliver, :update, :destroy, :index]

  # GET /orders
  def index
    @orders = Order.all.order(created_at: :desc)
  end

  # GET /orders/1
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # GET /orders/1/delivery  
  def deliver
    @order = Order.find(params[:order_id])
    @order.delivered = true

    respond_to do |format|
      if @order.save()
        format.html { redirect_to orders_path, notice: 'Order was successfully set as delivered.' }
      else
        format.html { render :edit }
      end
    end
  end
  
  # GET /orders/1/success
  def success
    @order = Order.find(params[:order_id])
  end

  # POST /orders
  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_success_path(:order_id => @order.id) }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /orders/1
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to orders_path, notice: 'Order was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end
    
    # just checks if the user is an admin
    def check_admin
      if !current_user.admin?
        redirect_to root_path, error: 'You cannot access this area'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:delivery_address, :delivery_postalcode, :delivery_province, :delivery_city, :pizza_size, :pizza_crust, :delivered, pizza_toppings:[])
    end
end
