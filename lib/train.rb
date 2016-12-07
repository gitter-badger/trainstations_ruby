class Train
  attr_reader(:route, :id)

  define_method(:initialize) do |attributes|
    @route = attributes.fetch(:route)
    @id = attributes.fetch(:id, nil)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO train (route) VALUES ('#{@route}') RETURNING id;")
    @id = result.first.fetch("id").to_i()
  end

  define_singleton_method(:all) do
    results = DB.exec("SELECT * FROM train;")
    trains = []
    results.each() do |result|
      id = result.fetch("id").to_i
      route = result.fetch("route")
      trains.push(Train.new({:route => route, :id => id}))
    end
    trains
  end

  define_method(:==) do |other_train|
    self.route().==(other_train.route()).&(self.id().==(other_train.id()))
  end

  define_method(:delete) do
    DB.exec("DELETE FROM train WHERE id = #{self.id()};")
  end

  define_method(:update) do |attributes|
    @route = attributes.fetch(:route)
    @id = self.id()
    DB.exec("UPDATE train SET route = '#{@route}' WHERE id = #{@id};")
  end

end
