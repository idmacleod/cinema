require("pry")
require_relative("models/customer")
require_relative("models/film")
require_relative("models/ticket")

customer1 = Customer.new({"name" => "Mr Moneybags", "funds" => "1000000.00"})
customer2 = Customer.new({"name" => "Colonel Mustard", "funds" => "25.50"})

film1 = Film.new({"title" => "Princess Mononoke", "price" => "10.50"})
film2 = Film.new({"title" => "Howl's Moving Castle", "price" => "8.50"})

ticket1 = Ticket.new({"customer_id" => customer1.id, "film_id" => film1.id})
ticket2 = Ticket.new({"customer_id" => customer1.id, "film_id" => film2.id})
ticket3 = Ticket.new({"customer_id" => customer2.id, "film_id" => film2.id})

binding.pry
nil