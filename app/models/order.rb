class Order < ActiveRecord::Base
  belongs_to :user
  
  validates :delivery_postalcode, zipcode: { country_code: :ca }
  validates :delivery_address, presence: true
  validates :delivery_city, presence: true
  validates :delivery_province, presence: true
  validates :pizza_size, presence: true
  validates :pizza_toppings, presence: true
  validates :pizza_crust, presence: true
  
  before_validation do
      self.delivery_postalcode = self.delivery_postalcode.upcase
  end
  
  before_save do
      self.pizza_toppings.gsub!(/[\[\]\"]/, "") if attribute_present?("pizza_toppings")
  end
  
  def provinces 
      return [
            ['Ontario'],
            ['Quebec'],
            ['Manitoba']
          ]
  end
end
