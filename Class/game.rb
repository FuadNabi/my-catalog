require_relative './item'

class Game < Item
  attr_reader :multiplayer, :last_played_at, :published_date

  def initialize(multiplayer, last_played_at, published_date)
    super(published_date)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
    @published_date = published_date
  end

  def can_be_archived?
    super && @last_played_at > 2
  end
end
