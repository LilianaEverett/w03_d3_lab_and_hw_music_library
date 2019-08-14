require_relative('../db/sql_runner')


class Artist

  attr_reader :id, :name

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
  def pizza_orders
    sql = "SELECT * FROM pizza_orders WHERE customer_id = $1"
    values = [@id]
    orders_data = SqlRunner.run(sql, values)
    orders = orders_data.map { |orders_data| PizzaOrder.new(orders_data)}
    return orders
  end



end
