require_relative 'app'

class Main < App
  def initialize
    super()

    @menu = {
      '1': 'List all books',
      '2': 'List all music albums',
      '3': 'List all games',
      '4': 'List all genres (e.g Comedy, Thriller)',
      '5': 'List all labels (e.g. Gift, New)',
      '6': 'List all authors (e.g. Stephen King)',
      '7': 'List all sources (e.g. From a friend, Online shop)',
      '8': 'Add a book',
      '9': 'Add a music album',
      '10': 'Add a game',
      '11': 'Exit'
    }
  end

  def choose_option(input)
    case input
    when '1' then list_all_books
    when '2' then list_all_music_albums
    when '3' then list_all_games
    when '4' then list_all_genres
    when '5' then list_all_labels
    when '6' then list_all_authors
    when '7' then list_all_sources
    when '8' then add_book
    when '9' then add_music_album
    when '10' then add_game
    end
  end

  def display_menu
    @menu.each do |index, command|
      puts "#{index} - #{command}"
    end
  end

  def select_menu_option
    input = gets.chomp
    if input == '11'
      puts 'Thank you for using this app!'
      save_data
      exit
    else
      choose_option(input)
    end
  end

  def logo
    puts "
                         _/                _/
    _/_/_/    _/_/_/  _/_/_/_/    _/_/_/  _/    _/_/      _/_/_/
 _/        _/    _/    _/      _/    _/  _/  _/    _/  _/    _/
_/        _/    _/    _/      _/    _/  _/  _/    _/  _/    _/
 _/_/_/    _/_/_/      _/_/    _/_/_/  _/    _/_/      _/_/_/
                                                          _/
                                                     _/_/
    "
  end

  def run
    load_data
    puts logo
    puts 'Welcome to Catalogue App!'
    loop do
      display_menu
      select_menu_option
    end
  end
end

main = Main.new
main.run
