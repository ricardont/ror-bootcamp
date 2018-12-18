

class PizzaBurger
  def init()
  end

  def order(name='Jon Doe', phone='666-666-66')
  	@name = name
  	@phone = phone
     "Hi #{@name}, your phone is #{@phone}"
	end
	def menu
		print """ 
			Welcome to PizzaBurger,
      What would you like to do?
      	1. Order a pizza
      	2. Order a burger
      	3. List all orders
				4. Cancel an order
				0. Exit
		"""
	end
end

