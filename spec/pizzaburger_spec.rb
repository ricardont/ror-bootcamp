require_relative '../pizzaburger.rb'
require 'stringio'
RSpec.describe PizzaBurger do 

  pizza=Pizza.new
  burger=Burger.new
  orders=Order.new

  it 'saves a burger order' do
  	burger.create('Bob', '7-52-45-87', 'medium-rare', false) 
  end
  it 'saves a pizza order' do
  	pizza.create('Carlos', '6-66-66-66', 'pepperoni and cheese', 3) 
  end
  it 'list all orders' do 
    orders.list 
  end

  context "open menu" do
  	pending 'research how spec text from output print or puts'  
  end
end

