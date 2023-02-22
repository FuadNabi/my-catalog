require_relative 'item'
require_relative 'label'

class Book < Item
  attr_accessor :publisher, :cover_state
  attr_reader :id

  def initialize(publish_date, publisher, cover_state)
    super(publish_date)
    @publisher = publisher
    @cover_state = cover_state
    @label = nil
  end

  def can_be_archived?
    super || @cover_state == 'bad'
  end

  def add_label(label)
    @label = label
  end
end
