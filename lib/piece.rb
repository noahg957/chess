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

  attr_accessor :display, :color, :square_on, :position, :dangerous, :type


  def list_moves(white_pieces, black_pieces)
    possible_moves(@position,@type,@color,@square_hash,white_pieces,black_pieces)
  end

end