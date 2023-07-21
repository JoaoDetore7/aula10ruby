class Electronic < Product
	attr_accessor :brand, :model, :power

	def initialize(attributes = {})
		super
		@brand = attributes[:brand]
		@model = attributes[:model]
		@power = false
	end

	def display
		super
		puts "Marca: #{brand}" if brand
		puts "Modelo: #{model}" if model
	end

	def turn_on
		if power
			puts "O aparelho já está ligado."
		else
			@power = true
			puts "Aparelho ligado."
		end
	end

	def turn_off
		if power
			@power = false
			puts "Aparelho desligado."
		else
			puts "O aparelho já está desligado."
		end
	end

	def turn_on_security_mode
		turn_on
		puts "Em modo de segurança."
	end
end