class Order < ActiveRecord::Base
  belongs_to :user
  
  validates :delivery_postalcode, zipcode: { country_code: :ca }
  validates :delivery_address, presence: true
  validates :delivery_city, presence: true
  validates :pizza_size, presence: true
  validates :pizza_toppings, presence: true
  validates :pizza_crust, presence: true
  
  before_validation do
      self.delivery_postalcode = self.delivery_postalcode.upcase
  end
  
  before_save do
      self.pizza_toppings.gsub!(/[\[\]\"]/, "") if attribute_present?("pizza_toppings")
  end
  
  def total
    @subtotal = 0
    
    if self.pizza_size == 'small'
      @subtotal += 5
    elsif self.pizza_size == 'medium'
      @subtotal += 10
    elsif self.pizza_size == 'large'
      @subtotal += 15
    end
    
    # first topping is free 
    @subtotal += (self.pizza_toppings.split(',').count - 1) * 5;
    
    # crust option is free
    #@subtotal =+ 0
  end
  
  def provinces 
      return [
            ['Ontario'],
            ['Quebec'],
            ['Manitoba']
          ]
  end
end
