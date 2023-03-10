require_relative './classes/music_album'
require_relative './classes/genre'
require_relative './classes/book'
require_relative './classes/label'
require_relative './classes/game'
require_relative './classes/author'
require './data_store'
require 'json'

class App
  def initialize
    @books = []
    @music_albums = []
    @genres = []
    @labels = []
    @games = []
    @authors = []

    @games_store = DataStore.new('games')
    @games = @games_store.read.map { |game| Game.new(game['multiplayer'], game['last_played_at'], game['publish_date']) }

    @author_store = DataStore.new('authors')
    @authors = @author_store.read.map { |author| Author.new(author['first_name'], author['last_name']) }
  end

  def list_all_books
    if @books.empty?
      puts 'No books have yet been created!'
    else
      @books.each do |e|
        puts "Title: #{e.label.title}, Publish date:[#{e.publish_date}], Color: #{e.label.color}, Publisher: #{e.publisher}, Cover state: #{e.cover_state}, ID: #{e.id}"
      end
    end
  end

  def list_all_music_albums
    if @music_albums.empty?
      puts 'No music albums have yet been created!'
    else
      @music_albums.each do |e|
        puts "Title: #{e.title}, Publish date:[#{e.publish_date}], On Spotify: #{e.on_spotify}, Genre: #{e.genre.name}, ID: #{e.id}"
      end
    end
  end

  # List all games option "3"
  def list_all_games
    if @games.length <= 0
      puts 'No games to show'
    else
      @games.each do |game|
        puts "Multiplayers: #{game.multiplayer} Last played: #{game.last_played_at} Publish date: #{game.publish_date} ID: #{game.id}"
      end
    end
  end

  def list_all_genres
    if @genres.empty?
      puts 'No genres have yet been created!'
    else
      @genres.each do |e|
        puts "Genre: #{e.name}"
      end
    end
  end

  def list_all_labels
    if @labels.empty?
      puts 'No labels have yet been created!'
    else
      @labels.each do |e|
        puts "Title: #{e.title}, Color: #{e.color}, ID: #{e.id}"
      end
    end
  end

  # List all authors option "6"
  def list_all_authors
    puts 'List of all authors'
    if @authors.length <= 0
      puts 'No authors to show'
    else
      @authors.each do |author|
        puts "First Name: #{author.first_name} Last Name: #{author.last_name}"
      end
    end
  end

  def list_all_sources
    # add code here
    puts 'List all sources'
    if @authors.empty?
      puts 'No authors have yet been created!'
    else
      @authors.each do |e|
        puts "First name: #{e.first_name}, Last name: #{e.last_name}"
      end
    end
  end

  def find_or_create_label(title, color)
    label = @labels.find { |l| l.title == title && l.color == color }
    unless label
      label = Label.new(title, color)
      @labels.push(label)
    end
    label
  end

  def add_book
    print 'Title: '
    title = gets.chomp

    print 'Publish date [yyyy-mm-dd]: '
    publish_date = gets.chomp

    print 'Color of the book: '
    color = gets.chomp

    print 'Publisher: '
    publisher = gets.chomp

    print 'Please write cover state ["good"/"bad"]'
    cover_state = gets.chomp
    label = find_or_create_label(title, color)

    book = Book.new(publish_date, publisher, cover_state)
    book.add_label(label)
    @books.push(book)
    puts 'Book was created successfully.'
  end

  def find_or_create_genre(name)
    genre = @genres.find { |item| item.name == name }
    unless genre
      genre = Genre.new(name)
      @genres.push(genre)
    end

    genre
  end

  def add_music_album
    print 'Title:'
    title = gets.chomp

    print 'Publish date [yyyy-mm-dd]:'
    publish_date = gets.chomp

    print 'On Spotify [y/n]:'
    on_spotify = gets.chomp.downcase == 'y' || false

    print 'Genre:'
    genre_name = gets.chomp
    genre = find_or_create_genre(genre_name)

    music_album = MusicAlbum.new(title, publish_date, on_spotify)
    music_album.add_genre(genre)
    @music_albums.push(music_album)

    puts 'Music album was created successfully.'
  end

  # Add game option "10"
  def add_game
    print 'Multiplayer(y/n)?'
    multi = gets.chomp
    print 'Last played at. date [yyyy-mm-dd]:'
    last_played = gets.chomp
    print 'Publish date [yyyy-mm-dd]:'
    published = gets.chomp
    @games << Game.new(multi, last_played, published)
    puts 'A new Game added successfully'

    print 'Frist name of the author of the game? '
    first_name = gets.chomp
    print 'Last name of the author of the game? '
    last_name = gets.chomp
    @authors << Author.new(first_name, last_name)
    puts 'Author added successfully!'
  end

  def save_game
    game = @games.map(&:create_json)
    write_data = JSON.pretty_generate(game)
    File.write('./data/games.json', write_data)
  end

  def save_author
    auth = @authors.map(&:create_json)
    write__auth_data = JSON.pretty_generate(auth)
    File.write('./data/authors.json', write__auth_data)
  end

  def remove_selected_item
    print 'Input the class of item [book, music, game]:'
    type = gets.chomp

    print 'Select ID:'
    id = gets.chomp.to_i

    case type
    when 'book' then @books.delete_if { |e| e.id == id }
    when 'music' then @music_albums.delete_if { |e| e.id == id }
    when 'game' then @games.delete_if { |e| e.id == id }
    end

    puts "Item of #{type} was successfully deleted."
  end

  def load_books
    file_name = './data/books.json'
    return unless File.exist?(file_name) && !File.empty?(file_name)

    JSON.parse(File.read(file_name)).each do |e|
      new_item = Book.new(e['publish_date'], e['publisher'], e['cover_state'])
      label = find_or_create_label(e['title'], e['color'])
      new_item.add_label(label)

      @books.push(new_item)
    end
  end

  def save_books
    data = []
    file_name = './data/books.json'
    @books.each do |e|
      data.push({
                  title: e.label.title,
                  publish_date: e.publish_date,
                  color: e.label.color,
                  publisher: e.publisher,
                  cover_state: e.cover_state
                })
    end
    File.write(file_name, JSON.generate(data))
  end

  def load_labels
    file_name = './data/labels.json'
    return unless File.exist?(file_name)
    return if File.empty?(file_name)

    JSON.parse(File.read(file_name)).each do |e|
      find_or_create_label(e['title'], e['color'])
    end
  end

  def save_labels
    data = []
    file_name = './data/labels.json'
    @labels.each do |e|
      data.push({
                  title: e.title,
                  color: e.color
                })
    end
    File.write(file_name, JSON.generate(data))
  end

  def load_music_albums
    file_name = './data/music_albums.json'
    return unless File.exist?(file_name)
    return if File.empty?(file_name)

    JSON.parse(File.read(file_name)).each do |e|
      new_item = MusicAlbum.new(e['title'], e['publish_date'], e['on_spotify'])
      genre = find_or_create_genre(e['genre'])
      new_item.add_genre(genre)

      @music_albums.push(new_item)
    end
  end

  def save_music_albums
    data = []
    file_name = './data/music_albums.json'
    @music_albums.each do |e|
      data.push({
                  title: e.title,
                  publish_date: e.publish_date,
                  on_spotify: e.on_spotify,
                  genre: e.genre.name
                })
    end
    File.write(file_name, JSON.generate(data))
  end

  def load_genres
    file_name = './data/genres.json'
    return unless File.exist?(file_name)
    return if File.empty?(file_name)

    JSON.parse(File.read(file_name)).each do |e|
      find_or_create_genre(e['name'])
    end
  end

  def save_genres
    data = []
    file_name = './data/genres.json'
    @genres.each do |e|
      data.push({ name: e.name })
    end
    File.write(file_name, JSON.generate(data))
  end

  def load_data
    load_genres
    load_music_albums
    load_books
    load_labels
  end

  def save_data
    save_author
    save_labels
    save_game
    save_genres
    save_music_albums
    save_books
  end
end
