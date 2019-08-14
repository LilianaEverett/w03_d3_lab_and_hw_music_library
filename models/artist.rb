require_relative('../db/sql_runner')
require_relative('./album')


class Artist

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save
    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING *"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def Artist.delete_all
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def Artist.all
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map { |artist| Artist.new(artist)}
  end
# find albums by artist:
  def get_albums
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    albums_data = SqlRunner.run(sql, values)
    albums = albums_data.map { |albums_data| Album.new(albums_data)}
    return albums
  end

  def update()
    sql = "UPDATE artists SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def Artist.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    results_array = SqlRunner.run(sql, values)
    return nil if results_array.first() == nil
    artist_hash = results_array[0]
    found_artist = Artist.new(artist_hash)
    return found_artist
  end



end
