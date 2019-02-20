require_relative '../pizzaburger.rb'
require 'stringio'
RSpec.describe PizzaBurger do 
  after do
   File.truncate('./db/orders.yml', 0)
   File.truncate('./db/clients.yml', 0)
#    Orders.clear
#    File.truncate(file, 0)
  end
  it 'Creates a burger' do
  	expect(Burger.create(1111111111, 'medium-rare', false)[:string]).to eq('Burger without fries (medium-rare)')
  end
  it 'Creates a pizza' do
  	expect(Pizza.create(66666666666, 'pepperoni and cheese', 3)[:string]).to eq('3 Pizzas with pepperoni and cheese')
  end
  context 'Submitting an order' do
    it 'of a pizza' do
      Orders.submit(Pizza.create(66666666666, 'pepperoni and cheese', 3))
      expect(Orders.list[-1][:string]).to eq('3 Pizzas with pepperoni and cheese')
    end
    it 'of a burger' do
      Orders.submit(Burger.create(1111111111, 'medium-rare', false))
      expect(Orders.list[-1][:string]).to eq('Burger without fries (medium-rare)')
    end

  end
  it 'creates a client' do
      Clients.create('Ricke Onti', 6142471026, 'Rios papigochic 14')
      expect(Clients.get(6142471026)[:string]).to eq('Ricke Onti, Phone: 6142471026, Address: Rios papigochic 14')
      #puts Clients.get(6142471026)
  end
  it 'deletes an order' do 
    Orders.submit(Burger.create(1111111111, 'medium-rare', false))
    Orders.submit(Burger.create(1111111111, 'medium-rare', false))
    Orders.submit(Pizza.create(66666666666, 'pepperoni and cheese', 3))
    expect(Orders.list.length).to eq(3)
    Orders.delete(1)
    expect(Orders.list.length).to eq(2)
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

