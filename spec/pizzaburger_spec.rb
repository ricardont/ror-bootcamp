require_relative '../pizzaburger.rb'
RSpec.describe PizzaBurger do 
	it 'shows menu' do
		pending "research hot to test prompt meu puts"
		app = PizzaBurger.new

	end	
	it 'orders a pizza succefully' do
		app = PizzaBurger.new;
		#pizza =  Pizza.new;
		order = app.order('Bob', '7-52-45-87' )
		expect(order).to eq("Hi Bob, your phone is 7-52-45-87" )
	end
end