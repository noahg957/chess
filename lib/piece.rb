require_relative 'piece_data'

class Piece

  include PieceData

  def initialize(position,square_hash)
    @position = position
    @square_hash = square_hash
    @square_on = @square_hash[position]
    array = type_determiner(@position)
    @color = array[0]
    @type = array[1]
    @display = APPEARANCE["#{@color} #{@type}"]
  end

  attr_accessor :display, :color, :square_on, :position


  def list_moves
    possible_moves(@position,@type,@color,@square_hash)
  end

end