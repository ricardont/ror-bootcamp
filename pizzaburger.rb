require 'yaml'

class Order 
	def create(name='Jhon Doe', phone )
  end
  @@yaml_file='./db/orders.yml'
  def write(data={})
    File.open(@@yaml_file, "w") {|f| f.write(data.to_yaml) }
  end
  def list()
    yml = YAML.load_file @@yaml_file
    yml.map{  | item |
       item["string"]
    }
  end
end
class Pizza <  Order
	def create(name, phone, toppings='pepperoni', quantity)
		 super(name, phone)
  	 plural = quantity.to_i > 1 ? 's' : '' 
  	 string = "#{quantity} #{self.class.name}#{plural} with #{toppings}"  
     data = {"name" => name, "phone" => phone, "toppings" => toppings, "quantity"=> quantity, "string" => string, "type" => self.class.name }     
     write(data)
	end
end


class Burger < Order
	def create(name, phone, term, fries=false)
		 super(name, phone)
  	 with_fries = fries ? 'with' : 'without'
  	 string = "#{self.class.name} #{with_fries} fries (#{term})"
     data = {"name" => name, "phone" => phone, "term" => term, "fries" => fries, "string" => string, "type" => self.class.name }
     write(data)
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
		  	"""
		    self.menu(gets.chomp.to_i)
		  	#"main menu"
		end
		
	end
	private 
	def menuOrderPizza
		system "clear"
		menuHeader('pizza')
		print "Name:"
 		name=gets.chomp
 		print "Phone:"
    phone=gets.chomp     
		print "Which toppings:"
		toppings=gets.chomp
		print "How many Pizzas:"
		quantity=gets.chomp
		self.order(Pizza.new(name, phone, toppings, quantity))
		self.menu(3)
  end
  def menuOrderBurger
		system "clear"
		menuHeader('burger')
		 		 print "Name:"
 		 name=gets.chomp
 		 print "Phone:"
     phone=gets.chomp     
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

