require_relative('../db/sql_runner')


class Album

  attr_reader :id, :name, :genre, :artist_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @genre = options["genre"]
    @artist_id = options["artist_id"].to_i
  end

  def save
    sql = "INSERT INTO albums (
    name,
    genre,
    artist_id
    )
    VALUES
      ($1, $2, $3)
    RETURNING *"
    values = [@name, @genre, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def Album.delete_all
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def Album.all
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map { |album| Album.new(album)}
  end
  # find artist in the album:

  def get_artist
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    result = SqlRunner.run(sql, values)
    artist_data = result[0]
    artist = Artist.new(artist_data)
    return artist
  end
  # def customer
  #     sql = "SELECT * FROM customers WHERE id = $1"
  #     values = [@customer_id]
  #     results = SqlRunner.run(sql, values)
  #     customer_data = results[0]
  #     customer = Customer.new(customer_data)
  #     return customer
  #   end

end
