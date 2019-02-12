require_relative '../pizzaburger.rb'
require 'stringio'
RSpec.describe PizzaBurger do 
  pizza=Pizza.new
  burger=Burger.new
  client=Client.new
  orders=Order.new
  after do
   File.truncate('./db/orders.yml', 0)
   File.truncate('./db/clients.yml', 0)
  end
  it 'saves a burger order' do
  	burger.create(1111111111, 'medium-rare', false) 
  	expect(orders.list[0][:string]).to eq('Burger without fries (medium-rare)')
  end
  it 'saves a pizza order' do
  	pizza.create(66666666666, 'pepperoni and cheese', 3) 
  	expect(orders.list[0][:string]).to eq('3 Pizzas with pepperoni and cheese')
  end
  it 'saves a client' do
    client.create('Carlos', 5555555, 'Nueva Frontera 9547')
    client.create('Pepe', 8888888, 'Rio Bravo 1150')
    expect(client.list(8888888)[:string]).to eq('Pepe, Phone: 8888888, Address: Rio Bravo 1150');
  end
  it 'list orders ' do
    client.create('Pepe', 8888888, 'Rio Bravo 1150')
    pizza.create(8888888, 'pepperoni and cheese', 3) 
    expect(orders.list()[:string]).to eq('Pepe, Phone: 8888888, Address: Rio Bravo 1150  -- 3 Pizzas with pepperoni and cheese');
  end
  context "open menu" do
  	pending 'research how spec text from output print or puts'  
  end
end

