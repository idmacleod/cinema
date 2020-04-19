require_relative("../db/sql_runner")
require_relative("film")
require_relative("customer")
require_relative("ticket")

class Screening

    attr_accessor :start_time, :film_id
    attr_reader :id

    def initialize(options)
        @id = options["id"].to_i if options["id"]
        @start_time = options["start_time"]
        @film_id = options["film_id"].to_i
        @initial_capacity = options["initial_capacity"].to_i
        if options["current_capacity"]
            @current_capacity = options["current_capacity"].to_i
        else
            @current_capacity = options["initial_capacity"].to_i
        end
    end

    # (C)reate
    def save()
        sql = "INSERT INTO screenings (start_time, film_id, initial_capacity, current_capacity)
        VALUES ($1, $2, $3, $4) RETURNING id;"
        values = [@start_time, @film_id, @initial_capacity, @current_capacity]
        @id = SqlRunner.run(sql, values)[0]["id"].to_i
    end

    # (R)ead
    def self.all()
        screenings_array = SqlRunner.run("SELECT * FROM screenings;")
        return Screening.map_to_objects(screenings_array)
    end

    # (U)pdate
    def update()
        sql = "UPDATE screenings
        SET (start_time, film_id, initial_capacity, current_capacity) = ($1, $2, $3, $4)
        WHERE id = $5;"
        values = [@start_time, @film_id, @initial_capacity, @current_capacity, @id]
        SqlRunner.run(sql, values)
    end

    # (D)elete
    def delete()
        sql = "DELETE FROM screenings WHERE id = $1;"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def film()
        sql = "SELECT * FROM films WHERE id = $1;"
        values = [@film_id]
        film_hash = SqlRunner.run(sql, values).first()
        return Film.new(film_hash)
    end

    # Distiguishing distinct customers from tickets sold
    def customers()
        sql = "SELECT DISTINCT customers.* FROM customers
        INNER JOIN tickets
        ON customers.id = tickets.customer_id
        WHERE tickets.screening_id = $1;"
        values = [@id]
        customers_array = SqlRunner.run(sql, values)
        return Customer.map_to_objects(customers_array)
    end

    def tickets_sold()
        sql = "SELECT * FROM tickets WHERE screening_id = $1;"
        values = [@id]
        tickets_array = SqlRunner.run(sql, values)
        return Ticket.map_to_objects(tickets_array)
    end

    def count_tickets_sold()
        return @initial_capacity - @current_capacity
    end

    def sold_out?()
        return @current_capacity == 0
    end

    def sell_ticket()
        return if sold_out?()
        @current_capacity -= 1
        update()
    end

    def self.map_to_objects(screenings_array)
        return screenings_array.map {|screening_hash| Screening.new(screening_hash)}
    end

    def self.delete_all()
        SqlRunner.run("DELETE FROM screenings;")
    end

end