require_relative 'conversion'
require_relative 'square'
require_relative 'piece'
require_relative 'piece_data'
require 'pp'
require 'pry'

class Board

  include Conversion
  include PieceData

  def initialize
    @square_hash = Hash.new
    @black_captured_pieces = []
    @white_captured_pieces = []
    create_board()
    place_pieces()
    generate_piece_lists()
  end

  attr_accessor :square_hash, :board
  attr_reader :white_pieces, :black_pieces

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
      puts 
    end
    print "       "
    puts Alphabet.join("  ")
  end

  def move_piece(start_position,end_position, white_pieces, black_pieces)
    
    start_square = @square_hash[start_position]
    end_square = @square_hash[end_position]
    piece = start_square.occupying_piece
    move_list = piece.list_moves(white_pieces, black_pieces)
    if move_list.include?(end_square)
      if end_square.occupied
        captured_piece = end_square.occupying_piece
        captured_piece.color == 'white' ? @white_captured_pieces.push(captured_piece) : @black_captured_pieces.push(captured_piece)
        captured_piece.color == 'white' ? @white_pieces.delete(captured_piece) : @black_pieces.delete(captured_piece)
        captured_piece.square_on = nil
        captured_piece.position = nil
      end
      end_square.occupying_piece = piece
      end_square.occupied = true
      start_square.occupying_piece = nil
      start_square.occupied = false
      piece.square_on = end_square
      piece.position = end_square.position
    else
      return "error"
    end
    clear_selected(@square_hash)
  end

  def generate_piece_lists
    pieces = []
    @square_hash.each { |key, square| pieces.push(square.occupying_piece) unless square.occupied == false  }
    @white_pieces = pieces.select { |piece| piece.color == 'white' }
    @black_pieces = pieces.select { |piece| piece.color == 'white' }
  end

end

board = Board.new
board.display
board.move_piece([5,1],[5,2], board.white_pieces, board.black_pieces)
board.move_piece([4,6],[4,5], board.white_pieces, board.black_pieces)
board.move_piece([4,0],[7,3], board.white_pieces, board.black_pieces)
board.display
binding.pry