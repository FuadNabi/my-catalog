require_relative '../item'

class MusicAlbum < Item
  def initialize(publish_date, on_spotify: false)
    super(publish_date)
    @id = id || Random.rand(1..1000)
    @on_spotify = on_spotify
  end

  attr_reader :id
  attr_accessor :name

  def can_be_archived?()
    super && @on_spotify
  end
end
