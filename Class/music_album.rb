require_relative 'item'

class MusicAlbum < Item
  def initialize(publish_date, on_spotify, id = nil)
    super(publish_date)
    @id = id || Random.rand(1..1000)
    @on_spotify = on_spotify
  end

  attr_reader :id, :publish_date, :on_spotify

  def can_be_archived?()
    super && @on_spotify
  end
end
