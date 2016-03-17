json.array!(@orders) do |order|
  json.extract! order, :id, :user_id, :delivery_address, :delivery_postalcode, :delivery_province, :delivery_city, :pizza_size, :pizza_toppings, :pizza_crust, :delivered
  json.url order_url(order, format: :json)
end
