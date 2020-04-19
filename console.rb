require("pry")
require_relative("models/customer")
require_relative("models/film")
require_relative("models/screening")
require_relative("models/ticket")

Ticket.delete_all()
Screening.delete_all()
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
film3 = Film.new({"title" => "Spirited Away", "price" => "5.25"})
film3.save()

screening1 = Screening.new({"start_time" => "2020-04-20 10:00", "film_id" => film1.id})
screening1.save()
screening2 = Screening.new({"start_time" => "2020-04-20 13:00", "film_id" => film2.id})
screening2.save()
screening3 = Screening.new({"start_time" => "2020-04-21 14:00", "film_id" => film3.id})
screening3.save()
screening4 = Screening.new({"start_time" => "2020-04-22 14:00", "film_id" => film3.id})
screening4.save()

ticket1 = customer1.buy_ticket(screening1)
ticket2 = customer2.buy_ticket(screening1)
ticket3 = customer1.buy_ticket(screening2)
ticket4 = customer1.buy_ticket(screening3)
ticket5 = customer2.buy_ticket(screening4)
ticket6 = customer1.buy_ticket(screening1) # Second ticket for same screening

customers = Customer.all()
films = Film.all()
screenings = Screening.all()
tickets = Ticket.all()

binding.pry
nil