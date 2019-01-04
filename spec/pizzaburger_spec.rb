require_relative '../pizzaburger.rb'
require 'stringio'
RSpec.describe PizzaBurger do 
	let(:app) { PizzaBurger.new }
	before do
		app.order(Burger.new('Bob', '7-52-45-87', 'rare', false) )
		app.order(Pizza.new('Ramon', '6-66-66-66', 'pepperoni and mushrooms', 5) )
		app.order(Pizza.new('Ricky', '8-88-88-88', 'chorizo and macadamia', 1) )
		app.order(Burger.new('Pepe', '1-11-11-11', 'medium-rare', true) )
	end
	it 'orders a pizza' do
       expect(app.orders[1].string).to eq('5 Pizzas with pepperoni and mushrooms')
       expect(app.orders[1].toppings).to eq('pepperoni and mushrooms')
       expect(app.orders[1].quantity).to eq(5)
    end
    it 'order a burger' do
       expect(app.orders[3].string).to eq('Burger with fries (medium-rare)')
       expect(app.orders[3].type).to eq('medium-rare')
       expect(app.orders[3].fries).to eq(true)
    end
	it 'orders  missing parms' do
		order = app.order(nil)
		expect(order).to eq('missing params')
	end
	it "list all orders" do
		expect(app.orders.length).to eq(4)
	end
	it "delete order succesfully" do
		app.cancel(1)
		expect(app.orders.length).to eq(3)
	end
  context "open menu" do
  	pending 'research how spec text from output print or puts'  
  end
end

