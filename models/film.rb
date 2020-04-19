require_relative("../db/sql_runner")

class Film

    attr_accessor :title, :price
    attr_reader :id

    def initialize(options)
        @id = options["id"].to_i if options["id"]
        @title = options["title"]
        @price = options["price"].to_f
    end

    # (C)reate
    def save()
        sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id;"
        values = [@title, @price]
        @id = SqlRunner.run(sql, values)[0]["id"].to_i
    end

    # (R)ead
    def self.all()
        films_array = SqlRunner.run("SELECT * FROM films;")
        return Film.map_to_objects(films_array)
    end

    # (U)pdate
    def update()
        sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3;"
        values = [@title, @price, @id]
        SqlRunner.run(sql, values)
    end

    # (D)elete
    def delete()
        sql = "DELETE FROM films WHERE id = $1;"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    # Distiguishing distinct customers from tickets sold
    def customers()
        sql = "SELECT DISTINCT customers.* FROM customers
        INNER JOIN tickets ON customers.id = tickets.customer_id
        INNER JOIN screenings ON tickets.screening_id = screenings.id
        WHERE screenings.film_id = $1;"
        values = [@id]
        customers_array = SqlRunner.run(sql, values)
        return Customer.map_to_objects(customers_array)
    end

    def tickets_sold()
        sql = "SELECT * FROM tickets
        INNER JOIN screenings ON tickets.screening_id = screenings.id
        WHERE screenings.film_id = $1;"
        values = [@id]
        tickets_array = SqlRunner.run(sql, values)
        return Ticket.map_to_objects(tickets_array)
    end

    def count_tickets_sold()
        return tickets_sold().length
    end

    def most_popular_time()
        sql = "SELECT screenings.start_time, COUNT(tickets.id) FROM screenings
        INNER JOIN tickets ON screenings.id = tickets.screening_id
        INNER JOIN films ON screenings.film_id = films.id
        WHERE films.id = $1
        GROUP BY screenings.start_time
        ORDER BY COUNT(tickets.id) DESC, screenings.start_time" # Returns earliest screening in case of draw
        values = [@id]
        top_result = SqlRunner.run(sql, values).first()
        return top_result["start_time"]
    end

    def self.map_to_objects(films_array)
        return films_array.map {|film_hash| Film.new(film_hash)}
    end
    
    def self.delete_all()
        SqlRunner.run("DELETE FROM films;")
    end

end