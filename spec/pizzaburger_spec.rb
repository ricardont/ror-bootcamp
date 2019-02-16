require_relative '../pizzaburger.rb'
require 'stringio'
RSpec.describe PizzaBurger do 
  after do
#   File.truncate('./db/orders.yml', 0)
#   File.truncate('./db/clients.yml', 0)
  end
  it 'Creates a burger' do
  	expect(Burger.create(1111111111, 'medium-rare', false)[:string]).to eq('Burger without fries (medium-rare)')
  end
  it 'Creates a pizza' do
  	expect(Pizza.create(66666666666, 'pepperoni and cheese', 3)[:string]).to eq('3 Pizzas with pepperoni and cheese')
  end
=begin  
  it 'saves a client' do
    client.create('Carlos', 5555555, 'Nueva Frontera 9547')
    client.create('Pepe', 8888888, 'Rio Bravo 1150')
    expect(client.list(8888888)[:string]).to eq('Pepe, Phone: 8888888, Address: Rio Bravo 1150');
  end
  it 'list orders ' do
    client.create('Pepe', 8888888, 'Rio Bravo 1150')
    pizza.create(8888888, 'pepperoni and cheese', 3) 
    expect(orders.list[0][:string]).to eq('3 Pizzas with pepperoni and cheese');
  end
  context "open menu" do
  	pending 'research how spec text from output print or puts'  
  end
=end
end

