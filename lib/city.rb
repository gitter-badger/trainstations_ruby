class City
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id, nil)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO city (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i()
  end

  define_singleton_method(:all) do
    results = DB.exec("SELECT * FROM city;")
    citys = []
    results.each() do |result|
      id = result.fetch("id").to_i
      name = result.fetch("name")
      citys.push(City.new({:name => name, :id => id}))
    end
    citys
  end

  define_method(:==) do |other_city|
    self.name().==(other_city.name()).&(self.id().==(other_city.id()))
  end

  define_method(:delete) do
    DB.exec("DELETE FROM city WHERE id = #{self.id()};")
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @id = self.id()
    DB.exec("UPDATE city SET name = '#{@name}' WHERE id = #{@id};")
  end

end
