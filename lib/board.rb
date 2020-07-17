require_relative 'conversion'
require_relative 'square'
require 'pp'
require 'pry'

class Board

  include Conversion

  def initialize
    create_board()
  end

  attr_accessor :a1, :a2, :a3, :a4, :board

  def create_board
    @board = []
    row = 0
    @square_array = []
    while row < 8
      column = 0
      sub_array = []
      if row % 2 == 0
        color = 'black'
      else 
        color = 'white'
      end
      while column < 8
        var_name = "@#{number_to_letter([column, row])}"
        self.instance_variable_set(var_name.to_sym,Square.new(column,row,color))
        square_variable = self.instance_variable_get(var_name)
        sub_array.push(square_variable)
        @square_array.push(var_name)
        color == 'black' ? color = 'white' : color = 'black'
        column += 1
      end
      @board.push(sub_array)
      row += 1
    end
    @board
  end

  def display_board
    system 'clear'
    system 'cls'
    color_board = Array.new(@board)
    puts "\n\n"
    color_board.reverse.each_with_index do |row,index| 
      print "    "
      print 8 - index
      print " "
      row.each { |square| print square.display }
      puts ''
    end
    print "       "
    puts Alphabet.join("  ")
  end

end

board = Board.new
board.display_board
binding.pry