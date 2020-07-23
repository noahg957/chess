require_relative 'game'
require 'yaml'

class GameLoop
  def initialize
    @id_file = ("lib/saved_games/id_number.txt")
    @data_file = ("lib/saved_games/saved_game_data.txt")
    show_menu()
  end
  def show_menu
    system 'clear'
    system 'cls'
    puts "Hello and welcome to chess!"
    puts "Would you like to:"
    puts "[1] start a new game"
    puts "[2] load a saved game"
    input = gets.chomp
    if input == "1"
      start_new_game()
      loop_games()
    elsif input == "2"
      continue_game()
      loop_games()
    end
  end

  def start_new_game
    @game = Game.new
    @game.start_game_loop
  end

  def continue_game
    File.foreach(@data_file) { |line| puts line}
    load_id = gets.chomp
    begin
      file_to_load = "lib/saved_games/saved_game#{load_id}.yml"
      @game = YAML.load(File.read(file_to_load))
      @game.continue_game
    rescue
      system 'clear'
      system 'cls'
      puts "Sorry, can't load a file with that id."
      continue_game()
    end
  end

  def loop_games
    unless @game.quit == true
      puts "Do you want to play another game?"
      again = gets.chomp
      while again == 'yes'
        @game = Game.new
        @game.start_game_loop
        puts "Do you want to play again?"
        again = gets.chomp
      end
    else
      return
    end
  end

end