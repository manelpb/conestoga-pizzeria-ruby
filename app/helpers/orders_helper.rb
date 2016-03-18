module OrdersHelper
    def checked(area)
      @order.pizza_toppings.nil? ? false : @order.pizza_toppings.include?(area)
    end
end
