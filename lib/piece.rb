require_relative 'piece_data'

class Piece

  include PieceData

  def initialize(position)
    @position = position
    array = type_determiner(@position)
    @color = array[0]
    @type = array[1]
    @display = APPEARANCE["#{@color} #{@type}"]
  end
  attr_accessor :display
end