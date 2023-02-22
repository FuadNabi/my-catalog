require_relative 'item'
require_relative 'genre'

class MusicAlbum < Item
  def initialize(title, publish_date, on_spotify, _id = nil)
    super(publish_date)
    @title = title
    @on_spotify = on_spotify
    @genre = nil
  end

  attr_reader :id, :publish_date, :on_spotify, :title, :genre

  def can_be_archived?()
    super && @on_spotify
  end

  def add_genre(genre)
    @genre = genre
  end
end
