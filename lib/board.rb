require_relative 'conversion'
require_relative 'square'
require 'pp'
require 'pry'

class Board

  include Conversion

  def initialize
    @square_hash = Hash.new
    create_board()
  end

  attr_accessor :square_hash, :board

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

end

board = Board.new
board.display
binding.pry