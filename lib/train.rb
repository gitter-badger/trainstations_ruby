class Train
  attr_reader(:route)

  define_method(:initialize) do |attributes|
    @route = attributes.fetch(:route)

  end


end
