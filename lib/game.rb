require_relative 'conversion'
require_relative 'board'
require_relative 'player'
require 'pry'
require 'yaml'

class Game
  include Conversion
  include PieceData

  def initialize()
    @id = File.read("lib/saved_games/id_number.txt").to_i
    @board = Board.new
    get_players()
    @quit = false
  end
  attr_reader :white, :black, :board, :quit
  def get_players
    puts "Who wants to be white?"
    white_name = gets.chomp
    puts "And who's black?"
    black_name = gets.chomp
    @white = Player.new(white_name, 'white')
    @black = Player.new(black_name, 'black')
    @current_player = @white
  end

  def square_checker(square)
    if square.nil?
      @error = "Sorry, not a valid square"
      get_and_move
      false
    elsif !square.occupied
      @error = "Sorry, no piece on that square"
      get_and_move
      false
    elsif square.occupying_piece.color != @current_player.color
      @error = "Sorry, not your piece"
      get_and_move()
      false
    else
      true
    end
  end

  def get_and_move()
    clear_selected(@board.square_hash)
    board.display
    if !@error.nil?
      puts @error
    end
    puts "#{@current_player.name}, what piece would you like to move? (type \"save\" to save the game, and type \"exit\" to exit the game)."
    input = gets.chomp
    if input == 'exit'
      @board.game_over = true
      @quit = true
      return
    elsif input == 'save'
      save_game()
      @error = "Your game id number is: #{@id}. Remember this to load it in the future."
      get_and_move()
    end
    start_square = @board.square_hash[letter_to_number(input)]
    if square_checker(start_square) == true
      move_list = start_square.occupying_piece.list_moves(@board.white_pieces, @board.black_pieces, @board.white_captured_pieces, @board.black_captured_pieces)
      @board.display
      if move_list.empty?
        phrase = "There are no possible moves for this piece."
      else
        phrase = "Where would you like to move it to?"
      end
      puts phrase + " (type \"change piece\" to start over and \"exit\" to end the game without saving)." 
      input = gets.chomp
      if input == 'change piece'
        @error = nil
        get_and_move()
      elsif input == 'exit'
        @board.game_over = true
      else
        end_square = @board.square_hash[letter_to_number(input)]
        return_value = @board.move_piece(start_square, end_square, @board.white_pieces, @board.black_pieces, @board.white_captured_pieces, @board.black_captured_pieces, @board.square_hash)
        if return_value != 'works'
          @error = return_value
          get_and_move()
        end
        @error = nil
        @board.display
      end
    end
  end


  def start_game_loop()
    while @board.game_over == false
      get_and_move()
      @current_player == @white ? opp_color = @black : opp_color = @white
      if @board.checkmate?(opp_color.color)
        puts "Checkmate! #{@current_player.name} wins."
        break
      elsif @board.draw?(opp_color.color)
        puts "Draw. #{opp_color.name} has no moves."
        break
      elsif @board.king_in_check?(opp_color.color, @board.white_pieces, @board.black_pieces, @board.white_captured_pieces, @board.black_captured_pieces, @board.square_hash)
        @error = "Check!"
      end
      @current_player == @white ? @current_player = @black : @current_player = @white
    end
  end

  def continue_game
    @error = "Here's where you left off:"
    start_game_loop()
  end

  def save_game()
    @id += 1
    id_file_name = 'lib/saved_games/id_number.txt'
    File.open(id_file_name, 'w') {|f| f.write(@id.to_s)}
    file_name = "lib/saved_games/saved_game#{@id}.yml"
    File.open(file_name, 'w') { |file| file.write(self.to_yaml) }
    data_file_name = "lib/saved_games/saved_game_data.txt"
    random_number = 1 + rand(1000)
    random_number.even? ? rand_player = @white : rand_player = @black
    File.open(data_file_name, 'a') do |f|
      f.puts "Game ##{@id}"
      f.puts "white player: #{@white.name}"
      f.puts "black player: #{@black.name}"
      f.puts "white pieces left: #{@board.white_pieces.length}"
      f.puts "black pieces left: #{@board.black_pieces.length}"
      f.puts "#{rand_player.name} is #{random_number} moves away from a checkmate. Maybe. No promises."
      f.puts
    end
    
  end
end



