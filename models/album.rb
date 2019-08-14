require_relative('../db/sql_runner')
require_relative('./artist')


class Album

  attr_reader :id
  attr_accessor :name, :genre, :artist_id

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

  # find artist in the albums table:
  def get_artist
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    result = SqlRunner.run(sql, values)
    artist_data = result[0]
    artist = Artist.new(artist_data)
    return artist
  end

  def update()
    sql = "UPDATE albums SET (
    name, genre, artist_id
      ) =
      ($1, $2, $3)
      WHERE id = $4"
    values = [@name, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def Album.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    results_array = SqlRunner.run(sql, values)
    return nil if results_array.first() == nil
    album_hash = results_array[0]
    found_album = Album.new(album_hash)
    return found_album
  end


end
