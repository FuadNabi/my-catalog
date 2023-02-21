class Genre
  def initialize(name)
    @id = Random.rand(1..1000)
    @name = name
    @items = []
  end

  attr_reader :id, :name

  def add_item(item)
    @items.push(item)
    item.genre = self
  end
end
