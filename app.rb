require_relative './class/music_album'
require_relative './class/genre'
require 'json'

class App
  def initialize
    @books = []
    @music_albums = []
    @genres = []
  end

  def list_all_books
    # add code here
    puts 'List all books'
  end

  def list_all_music_albums
    @music_albums.each do |e|
      puts "Publish date:[#{e.publish_date}] On Spotify: #{e.on_spotify}, ID: #{e.id}"
    end
  end

  def list_all_movies
    # add code here
    puts 'List all movies'
  end

  def list_all_genres
    @genres.each do |e|
      puts "Genre: #{e.name} ID: #{e.id}"
    end
  end

  def list_all_labels
    # add code here
    puts 'List all labels'
  end

  def list_all_authors
    # add code here
    puts 'List all authors'
  end

  def list_all_sources
    # add code here
    puts 'List all sources'
  end

  def add_book
    # add code here
    puts 'Add book'
  end

  def add_music_album
    print 'Publish date [yyyy-mm-dd]:'
    publish_date = gets.chomp

    print 'On Spotify [y/n]:'
    on_spotify = gets.chomp.downcase == 'y' || false

    @music_albums.push(MusicAlbum.new(publish_date, on_spotify))
    puts 'Music album was created successfully.'
  end

  def add_movie
    # add code here
    puts 'Add movies'
  end

  def load_music_albums
    file_name = './data/music_albums.json'
    return unless File.exist?(file_name)

    JSON.parse(File.read(file_name)).each do |e|
      new_item = MusicAlbum.new(e['publish_date'], e['on_spotify'])
      @music_albums.push(new_item)
    end
  end

  def save_music_albums
    data = []
    file_name = './data/music_albums.json'
    @music_albums.each do |e|
      data.push({ publish_date: e.publish_date, on_spotify: e.on_spotify })
    end
    File.write(file_name, JSON.generate(data))
  end

  def load_genres
    file_name = './data/genres.json'
    return unless File.exist?(file_name)

    JSON.parse(File.read(file_name)).each do |e|
      new_item = Genre.new(e['name'], e['id'])
      @genres.push(new_item)
    end
  end

  def save_genres
    data = []
    file_name = './data/genres.json'
    @genres.each do |e|
      data.push({ name: e.name, id: e.id })
    end
    File.write(file_name, JSON.generate(data))
  end

  def load_data
    load_genres
    load_music_albums
  end

  def save_data
    save_genres
    save_music_albums
  end
end
