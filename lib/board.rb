require_relative 'conversion'
require_relative 'square'
require_relative 'piece'
require_relative 'piece_data'
require_relative 'piece_mover.rb'
require 'pp'
require 'pry'

class Board

  include Conversion
  include PieceData
  include PieceMover

  def initialize
    @square_hash = Hash.new
    @black_captured_pieces = []
    @white_captured_pieces = []
    @game_over = false
    create_board()
    place_pieces()
    generate_piece_lists()
  end

  attr_accessor :square_hash, :board, :game_over
  attr_reader :white_pieces, :black_pieces, :white_captured_pieces, :black_captured_pieces

  def create_board
    @board = []
    row = 0
    while row < 8
      column = 0
      sub_array = []
      row % 2 == 0 ? color = 'black' : color = 'white'
      while column < 8
        var_name = [column,row]
        @square_hash[var_name] = Square.new(column,row,color)
        sub_array.push(@square_hash[var_name])
        color == 'black' ? color = 'white' : color = 'black'
        column += 1
      end
      @board.push(sub_array)
      row += 1
    end
    @board
  end

  def place_pieces_row(row)
    @board[row].each do |square|
      square.occupying_piece = Piece.new(square.position,@square_hash)
      square.occupied = true
    end
  end

  def place_pieces
    place_pieces_row(0)
    place_pieces_row(1)
    place_pieces_row(6)
    place_pieces_row(7)
  end

  def display
    system 'clear'
    system 'cls'
    display_board = Array.new(@board)
    puts "\n\n"
    display_board.reverse.each_with_index do |row,index| 
      print "    " + "#{8 - index}" + " "
      row.each { |square| print square.display }
      if index == 0
        print "      Pieces captured by black:   "
        @white_captured_pieces.each { |piece| print piece.display }
      elsif index == 7
        print "      Pieces captured by white:   "
        @black_captured_pieces.each { |piece| print piece.display }
      end
      puts 
    end
    print "       "
    puts Alphabet.join("  ") + "                         "
  end

  def generate_piece_lists
    pieces = []
    @square_hash.each { |key, square| pieces.push(square.occupying_piece) unless square.occupied == false  }
    @white_pieces = pieces.select { |piece| piece.color == 'white' }
    @black_pieces = pieces.select { |piece| piece.color == 'black' }
  end

  def king_no_moves?(color)
    color == 'white' ? pieces = @white_pieces : pieces = @black_pieces
    color == 'white' ? enemy_pieces = @black_pieces : enemy_pieces = @white_pieces
    king = pieces.select { |piece| piece.type == 'king' }
    king = king[0]
    possible_moves = king.list_moves(@white_pieces, @black_pieces, @white_captured_pieces, @black_captured_pieces)
    
    possible_moves.empty?
  end

  def no_moves_at_all?(color)
    color == 'white' ? pieces = @white_pieces : pieces = @black_pieces
    color == 'white' ? enemy_pieces = @black_pieces : enemy_pieces = @white_pieces
    checked = false
    pieces.each do |piece|
      possible_moves = piece.list_moves(@white_pieces,@black_pieces, @white_captured_pieces, @black_captured_pieces)
      start_square = piece.square_on
      possible_moves.each do |end_square|
        if test_move_piece(start_square,end_square, @white_pieces, @black_pieces, @white_captured_pieces, @black_captured_pieces, @square_hash)
          checked = true
        end
      end
    end
  end


  def checkmate?(color)
    if king_in_check?(color, @white_pieces, @black_pieces, @white_captured_pieces, @black_captured_pieces, @square_hash) && king_no_moves?(color) && no_moves_at_all?(color)
      @game_over = true
      true
    else
      false
    end
  end
end

