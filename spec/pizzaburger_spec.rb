require_relative '../pizzaburger.rb'
require 'stringio'
RSpec.describe PizzaBurger do 

		pizza=Pizza.new
		burger=Burger.new
	it 'saves a pizza order' do		
		pizza.create('Ramon', '6-66-66-66', 'pepperoni and mushrooms', 5) 
  end
  it 'saves a burger order' do
  	burger.create('Bob', '7-52-45-87', 'rared', false) 
  end
  context "open menu" do
  	pending 'research how spec text from output print or puts'  
  end
end

