require("pry")
require_relative("models/customer")
require_relative("models/film")
require_relative("models/ticket")

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new({"name" => "Mr Moneybags", "funds" => "1000000.00"})
customer1.save()
customer2 = Customer.new({"name" => "Colonel Mustard", "funds" => "25.50"})
customer2.save()

film1 = Film.new({"title" => "Princess Mononoke", "price" => "10.50"})
film1.save()
film2 = Film.new({"title" => "Howl's Moving Castle", "price" => "8.50"})
film2.save()

ticket1 = Ticket.new({"customer_id" => customer1.id, "film_id" => film1.id})
ticket1.save()
ticket2 = Ticket.new({"customer_id" => customer1.id, "film_id" => film2.id})
ticket2.save()
ticket3 = Ticket.new({"customer_id" => customer2.id, "film_id" => film2.id})
ticket3.save()

customers = Customer.all()
films = Film.all()
tickets = Ticket.all()

binding.pry
nil