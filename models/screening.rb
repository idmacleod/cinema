require_relative("../db/sql_runner")

class Screening

    attr_accessor :start_time, :film_id
    attr_reader :id

    def initialize(options)
        @id = options["id"].to_i if options["id"]
        @start_time = options["start_time"]
        @film_id = options["film_id"].to_i
    end

    # (C)reate
    def save()
        sql = "INSERT INTO screenings (start_time, film_id) VALUES ($1, $2) RETURNING id;"
        values = [@start_time, @film_id]
        @id = SqlRunner.run(sql, values)[0]["id"].to_i
    end

    # (R)ead
    def self.all()
        screenings_array = SqlRunner.run("SELECT * FROM screenings;")
        return Screening.map_to_objects(screenings_array)
    end

    # (U)pdate
    def update()
        sql = "UPDATE screenings SET (start_time, film_id) = ($1, $2) WHERE id = $3;"
        values = [@start_time, @film_id, @id]
        SqlRunner.run(sql, values)
    end

    # (D)elete
    def delete()
        sql = "DELETE FROM screenings WHERE id = $1;"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.map_to_objects(screenings_array)
        return screenings_array.map {|screening_hash| Screening.new(screening_hash)}
    end

    def self.delete_all()
        SqlRunner.run("DELETE FROM screenings;")
    end

end