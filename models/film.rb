require_relative("../db/sql_runner")

class Film

    attr_accessor :title, :price
    attr_reader :id

    def initialize(options)
        @id = options["id"].to_i if options["id"]
        @title = options["title"]
        @price = options["price"].to_f
    end

end