require_relative("../db/sql_runner")

class Ticket

    attr_accessor :customer_id, :film_id
    attr_reader :id

    def initialize(options)
        @id = options["id"].to_i if options["id"]
        @customer_id = options["customer_id"].to_i
        @film_id = options["film_id"].to_i
    end

    # (C)reate
    def save()
        sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id;"
        values = [@customer_id, @film_id]
        @id = SqlRunner.run(sql, values)[0]["id"].to_i
    end

    # (R)ead
    def self.all()
        tickets_array = SqlRunner.run("SELECT * FROM tickets;")
        return Ticket.map_to_objects(tickets_array)
    end

    # (U)pdate
    def update()
        sql = "UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3;"
        values = [@customer_id, @film_id, @id]
        SqlRunner.run(sql, values)
    end

    # (D)elete
    def delete()
        sql = "DELETE FROM tickets WHERE id = $1;"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.map_to_objects(tickets_array)
        return tickets_array.map {|ticket_hash| Ticket.new(ticket_hash)}
    end

    def self.delete_all()
        SqlRunner.run("DELETE FROM tickets;")
    end

end