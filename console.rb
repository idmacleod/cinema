require("pry")
require_relative("models/customer")
require_relative("models/film")

customer1 = Customer.new({"name" => "Mr Moneybags", "funds" => "1000000.00"})
customer2 = Customer.new({"name" => "Colonel Mustard", "funds" => "25.50"})

film1 = Film.new({"title" => "Princess Mononoke", "price" => "10.50"})
film2 = Film.new({"title" => "Howl's Moving Castle", "price" => "8.50"})

binding.pry
nil