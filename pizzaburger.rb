require 'yaml'
require 'singleton'
class FileManager
  include Singleton
  def self.write(file, data={})
    unless  file == nil
      File.open(file, "w+") {|f| f.write data.to_yaml}  
    end
  end
  def self.clear(file=@@yaml_file)
    File.truncate(file, 0)
  end
  private
  def self.load_file(file_name)
    File.read(file_name).empty? ? [] : YAML.load(File.read(file_name))
  end
end

class Pizza 
  include Singleton
	def self.create(phone, toppings='pepperoni', quantity)
  	 plural = quantity.to_i > 1 ? 's' : '' 
  	 string = "#{quantity} Pizza#{plural} with #{toppings}"  
    {phone: phone, toppings: toppings, quantity:  quantity, string: string, type: 'Pizza' } 
	end
end

class Burger 
  include Singleton
	def self.create(phone, term, fries=false)
  	 with_fries = fries ? 'with' : 'without'
  	 string = "Burger #{with_fries} fries (#{term})"
     {phone: phone, term: term, fries: fries, string: string, type: 'Burger' }
	end	
end

class Orders < FileManager

  @@yaml_file='./db/orders.yml'
  def self.submit( row={} )
    data=load_file(@@yaml_file) 
    data.push(row)
    write(@@yaml_file, data)
  end
  def self.list()
    YAML.load_file(@@yaml_file)
  end
  def self.delete(index)
    data=load_file(@@yaml_file) 
    data.delete_at(index)
    write(@@yaml_file, data)
  end

end


class Clients < FileManager
  @@yaml_file='./db/clients.yml'
  def self.create(name, phone, address)
      string = "#{name}, Phone: #{phone}, Address: #{address}"
      row = {name: name, phone: phone, address: address, string: string}
      data = File.read(@@yaml_file).empty? ? [] : YAML.load(File.read(@@yaml_file)) 
      data.push(row)
      write(@@yaml_file, data)
  end
  def self.list()
    YAML.load_file(@@yaml_file)
  end
  def self.get(phone)
    yml = File.read(@@yaml_file).empty? ? [] : YAML.load(File.read(@@yaml_file)) 
    yml.detect { |row| row[:phone] == phone }
  end
end

class PizzaBurger  
  include Singleton
	def self.menu(opt=666)
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
  		when 5
  			menuListClients()
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
	def self.menuOrderPizza
		system "clear"
		menuHeader('pizza')
		print "Which toppings:"
		toppings=gets.chomp
		print "How many Pizzas:"
		quantity=gets.chomp
		Orders.submit(Pizza.create(@@client_use[:phone], toppings, quantity))
		self.menu(3)
  end
  def self.menuClientSearch
		print "Phone?:"
		phone = gets.chomp
    @@client_use =  Clients.get(phone)
    unless @@client_use  == nil
      print "Welcome back #{@@client_use[:name]}"
    else
      menuClientNew(phone)
    end
  end
  def self.menuClientNew(phone)
    print "Name:"
    name = gets.chomp
    print "Address:"
    address = gets.chomp
    Clients.create(name, phone, address)
    system "clear"
    print "Welcome #{name}"
    @@client_use =  Clients.get(phone)
  end
  def self.menuListClients
		system "clear"
    Clients.list.map.with_index { |row, index|
      i = index + 1;
      puts "#{i}: #{row[:string]} "  
    }
  end
  def self.menuOrderBurger
		system "clear"
		menuHeader('burger')
		print "How would you like your burger:"
		type=gets.chomp
		print "Would you like fries (y/n)"
		fries= gets.chomp == 'y' ? true : false 
		Orders.submit(Burger.create(@@client_use[:phone], type, fries))
		self.menu(3)
  end
  def self.listOrders
    Orders.list.map.with_index { |row, index|
      client = Clients.get(row[:phone])
      i = index + 1;
      puts "#{i}- #{client[:string]} : #{row[:string]} "  
    }
  end
  def self.menuListOrders
  	system 'clear'
  	menuHeader('orders')
    listOrders
    gets.chomp
    self.menu()
  end
  def self.menuCancelOrder
    system 'clear'
    menuHeader('cancel')
    listOrders
    item_to_cancel = gets.chomp.to_i - 1 
    print 'Are you sure? (y/n) :'
    if gets.chomp == 'y' or gets.chomp == 'yes' 
    	Orders.delete(item_to_cancel)
    end
    self.menu(3)
  end
  def self.menuHeader(type='main')
  	puts '                                      0 : back or exit'
  	if type == 'main'
  	  puts 'Welcome'
  	end
    if type == 'pizza' || type == 'burger'
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
PizzaBurger.menu


