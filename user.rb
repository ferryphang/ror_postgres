class User 
	attr_accessor :name, :age, :address

	def initialize(name, age, address)
		name = name
		age  = age
		address = address
	end

	def say_hi
		puts "Hello, My Name is #{name}"
	end
end