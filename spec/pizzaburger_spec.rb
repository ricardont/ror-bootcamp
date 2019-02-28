require_relative '../pizzaburger.rb'
require 'stringio'
RSpec.describe PizzaBurger do 

  before do 
    Orders.submit(Pizza.create(66666666666, 'pepperoni and cheese', 3))
    Orders.submit(Burger.create(88888888888, 'rare', true))
    Orders.submit(Burger.create(6142471026, 'medium-rare', false))
    Clients.create('Ricke Onti', 6142471026, 'Rios papigochic 14')
    Clients.create('Pancho Lopez', 88888888888, 'Calle siempre viva 15')
    #Clients.create('Bruce Wayne', 66666666666, 'Gotham City')
  end
  after do
   File.truncate('./db/orders.yml', 0) 
   File.truncate('./db/clients.yml', 0)
  end
  context 'For Yaml File' do 
    data = PizzaBurgerData.new
    it 'Get Orders' do
      expect(data.orders.length).to eq(3)
    end  
    it 'Get Clients' do
      expect(data.clients.length).to eq(2)
    end
    it 'Saves new Orders entrie' do
      data.save_orders({phone: 222222222, toppings: 'Ham and anchoas', quantity:  2, string: 'String new Pizza', type: 'Pizza' })
      expect(Orders.list[-1][:string]).to eq('String new Pizza') 
    end
    it 'Saves new Clients entrie' do
      data.save_clients({phone: 33333333333, term: 'rare', fries: true, string: 'String new Burger', type: 'Burger' })
      expect(Clients.list[-1][:string]).to eq('String new Burger')
    end
  end
  it 'Creates a burger' do
  	expect(Burger.create(1111111111, 'medium-rare', false)[:string]).to eq('Burger without fries (medium-rare)')
  end
  it 'Creates a pizza' do
  	expect(Pizza.create(66666666666, 'pepperoni and cheese', 3)[:string]).to eq('3 Pizzas with pepperoni and cheese')
  end
  context 'Submitting an order' do
    it 'of a pizza' do
      expect(Orders.list[0][:string]).to eq('3 Pizzas with pepperoni and cheese')
    end
    it 'of a burger' do      
      expect(Orders.list[-1][:string]).to eq('Burger without fries (medium-rare)')
    end

  end
  it 'creates a client' do
      
      expect(Clients.get(6142471026)[:string]).to eq('Ricke Onti, Phone: 6142471026, Address: Rios papigochic 14')
      #puts Clients.get(6142471026)
  end
  it 'deletes an order' do 

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

