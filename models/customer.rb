require_relative("../db/sql_runner")

class Customer

    attr_accessor :name, :funds
    attr_reader :id

    def initialize(options)
        @id = options["id"].to_i if options["id"]
        @name = options["name"]
        @funds = options["funds"].to_f
    end

    # (C)reate
    def save()
        sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id;"
        values = [@name, @funds]
        @id = SqlRunner.run(sql, values)[0]["id"]
    end

    # (R)ead
    def self.all()
        customers_array = SqlRunner.run("SELECT * FROM customers;")
        return Customer.map_to_objects(customers_array)
    end

    def self.map_to_objects(customers_array)
        return customers_array.map {|customer_hash| Customer.new(customer_hash)}
    end

    def self.delete_all()
        SqlRunner.run("DELETE FROM customers;")
    end

end