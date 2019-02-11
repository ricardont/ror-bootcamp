require_relative '../pizzaburger.rb'
require 'stringio'
RSpec.describe PizzaBurger do 
  pizza=Pizza.new
  burger=Burger.new
  orders=Order.new
  after do
   File.truncate('./db/orders.yml', 0)
  end
  it 'saves a burger order' do
  	burger.create('Bob', '7-52-45-87', 'medium-rare', false) 
  	expect(orders.list).to eq('Burger without fries (medium-rare)')
  end
  it 'saves a pizza order' do
  	pizza.create('Carlos', '6-66-66-66', 'pepperoni and cheese', 3) 
  	expect(orders.list).to eq('3 Pizzas with pepperoni and cheese')
  end
  context "open menu" do
  	pending 'research how spec text from output print or puts'  
  end
end

