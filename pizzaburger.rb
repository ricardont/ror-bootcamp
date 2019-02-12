require 'yaml'

module FileManager
    def write(file, data={})
      unless  file == nil
        File.open(file, "w+") {|f| f.write data.to_yaml}  
      end
    end
end
class Order 
  include FileManager
	def create(phone )
  end
  @@yaml_file='./db/orders.yml'
  @@client = Client.new
  def list()

    yml = YAML.load_file(@@yaml_file)
    new_orders=[]  
    yml.map{ |row|
      client = @@client.list(row[:phone]) 
      new_order = @@client.except[:string].merge!row.exept[:phone]
      new_order[:string] = "#{client[:string]} -- #{row[:string]}"  
      new_orders << new_order
    }
    return new_orders
  end
end
class Pizza <  Order
	def create(phone, toppings='pepperoni', quantity)
		 super(phone)
  	 plural = quantity.to_i > 1 ? 's' : '' 
  	 string = "#{quantity} #{self.class.name}#{plural} with #{toppings}"  
     row = {phone: phone, toppings: toppings, quantity:  quantity, string: string, type: self.class.name } 
     data = File.read(@@yaml_file).empty? ? [] : YAML.load(File.read(@@yaml_file)) 
     data.push(row)
     write(@@yaml_file, data)
	end
end


class Burger < Order
	def create( phone, term, fries=false)
		 super(phone)
  	 with_fries = fries ? 'with' : 'without'
  	 string = "#{self.class.name} #{with_fries} fries (#{term})"
     row = {phone: phone, term: term, fries: fries, string: string, type: self.class.name }
     data = File.read(@@yaml_file).empty? ? [] : YAML.load(File.read(@@yaml_file)) 
     data.push(row)
     write(@@yaml_file, data)
	end	
end
class Client 
  include FileManager
  @@yaml_file='./db/clients.yml'
  def create(name='Jhon Doe', phone, address)
    unless phone==nil or phone==0
      string = "#{name}, Phone: #{phone}, Address: #{address}"
      row = {name: name, phone: phone, address: address, string: string}
      data = File.read(@@yaml_file).empty? ? [] : YAML.load(File.read(@@yaml_file)) 
      data.push(row)
      write(@@yaml_file, data)
    end
  end
  def list(phone=nil)
    yml = YAML.load_file(@@yaml_file)
    if phone == nil
      return yml
    else
      yml.map.with_index { |row, index|
        if row[:phone] == phone 
          return row
        end
      }
    end
  end
end
class PizzaBurger
	attr_accessor :orders
	def initialize(orders=[])
  	@orders=orders
  end

  def order( item )
    
  	if not  item ==  nil 
  		@orders.push(item)
    else
		'missing params'
	  end
	end
  def cancel(index)
  	 self.orders.delete_at(index)
  end
	def menu(opt=666)
		case opt
			when 0
  			exit
			when 1
  			menuOrderPizza()
  		when 2
  			menuOrderBurger()
  		when 3
  			menuListOrders()
  		when 4
  			menuCancelOrder()
			else
  		 	system "clear"
  		 	menuHeader()
				print """
      	1. Order a pizza
      	2. Order a burger
      	3. List all orders
        4. Cancel an order
        5. List Clients
		  	"""
		    self.menu(gets.chomp.to_i)
		  	#"main menu"
		end
		
	end
	private 
	def menuOrderPizza
		system "clear"
		menuHeader('pizza')
		print "Which toppings:"
		toppings=gets.chomp
		print "How many Pizzas:"
		quantity=gets.chomp
		self.order(pizza.create(phone, toppings, quantity))
		self.menu(3)
  end
  def menuClientSearch
		print "Phone?:"
    result =  client.list(gets.chomp)
    unless result  == nil
      print "Welcome back {#result[:name]}"
    else
      menuClientNew
    end
  end
  def menuClientNew
    print "Phone:"
    phone =gets.chomp
    print "Name:"
    name =gets.chomp
    print "Address:"
    address =gets.chomp
    client.create(name, phone, address)
    system "clear"
    print "Welcome {#name}"
  end
  def menuClientList
		system "clear"
    
  end
  def menuOrderBurger
		system "clear"
		menuHeader('burger')

		print "How would you like your burger:"
		type=gets.chomp
		print "Would you like fries (y/n)"
		
		fries= gets.chomp == 'y' ? true : false 
		self.order(Burger.new(name, phone, type, fries))
		self.menu(3)
  end
  def listOrders
  	  self.orders.map.with_index { | order, i |
  	  index = i + 1
			puts "#{index}) #{order.string}"
			puts "#{order.name}, #{order.phone} " 
  	}
  end
  def menuListOrders
  	system 'clear'
  	menuHeader('orders')
    listOrders
    gets.chomp
    self.menu()
  end
  def menuCancelOrder
    system 'clear'
    menuHeader('cancel')
    listOrders
    item_to_cancel = gets.chomp.to_i - 1 
    print 'Are you sure? (y/n) :'
    if gets.chomp == 'y' or gets.chomp == 'yes' 
    	self.cancel(item_to_cancel)
    end
    self.menu(3)
  end

  def menuHeader(type='main')
  	puts '                                      0 : back or exit'
  	if type == ''
  	  puts 'Welcome'
  	else 
  	  menuClientSearch
  	end
  	case type
  	when 'pizza'
    	puts "	Ordering a pizza! "
  	when 'burger'	
  		puts "	Ordering a burger!"
    when 'orders'
    	puts "The current orders are:"
    when 'cancel'
    	puts "Choose the order to cancel:"
    when 'customers'
    	puts "The current clients are:"	
  	else
  		puts """Welcome to PizzaBurger,
    	What would you like to do? """
    end
  end
end
#puts Pizza.new('pepperoni and mushrooms', 5)

