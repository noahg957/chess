require_relative 'conversion'
require_relative 'board'
require_relative 'player'
require 'pry'

class Game
  include Conversion
  include PieceData

  def initialize
    @board = Board.new
    get_players()
  end
  attr_reader :white, :black, :board
  def get_players
    puts "Who wants to be white?"
    white_name = gets.chomp
    puts "And who's black?"
    black_name = gets.chomp
    @white = Player.new(white_name, 'white')
    @black = Player.new(black_name, 'black')
  end

  def square_checker(square, player)
    if square.nil?
      @error = "Sorry, not a valid square"
      get_and_move(player)
      false
    elsif !square.occupied
      @error = "Sorry, no piece on that square"
      get_and_move(player)
      false
    elsif square.occupying_piece.color != player.color
      @error = "Sorry, not your piece"
      get_and_move(player)
      false
    else
      true
    end
  end

  def get_and_move(player)
    clear_selected(@board.square_hash)
    board.display
    if !@error.nil?
      puts @error
    end
    puts "#{player.name}, what piece would you like to move?"
    start_square = @board.square_hash[letter_to_number(gets.chomp)]
    if square_checker(start_square, player) == true
      move_list = start_square.occupying_piece.list_moves(@board.white_pieces, @board.black_pieces)
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
        get_and_move(player)
      elsif input == 'exit'
        @board.game_over = true
      else
        end_square = @board.square_hash[letter_to_number(input)]
        return_value = @board.move_piece(start_square, end_square, @board.white_pieces, @board.black_pieces)
        if return_value != 'works'
          @error = return_value
          get_and_move(player)
        end
        @error = nil
        @board.display
      end
    end
  end


  def start_game_loop
    player = @white
    while @board.game_over == false
      get_and_move(player)
      player == @white ? player = @black : player = @white
    end
  end
end

  game = Game.new
  game.board.display
  game.start_game_loop


