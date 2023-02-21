require 'date'

class Item
  attr_reader :genre, :source, :label, :author

  def initialize(publish_date)
    @id = Random.rand(1..1000)
    @publish_date = publish_date
    @archived = false
  end

  def add_genre(genre)
    @genre = genre
  end

  def add_source(source)
    @source = source
  end

  def add_label(label)
    @label = label
  end

  def add_author(author)
    @author = author
  end

  def move_to_archive()
    @archived = can_be_archived?
  end

  private

  def can_be_archived?()
    current_year = Date.today.year
    current_publish_year = Date.parse(@publish_date).year
    current_year - current_publish_year > 10
  end
end
