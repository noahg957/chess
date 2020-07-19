require 'colorize'

class Square
  
  attr_reader :position, :color
  attr_accessor :occupied, :occupying_piece

  def initialize(column, row, color)
    @position = [column, row]
    @occupied = false
    @occupying_piece = nil
    @color = color
  end

  def display
    if @occupying_piece.nil?
      "   ".colorize(background: "light_#{@color}".to_sym)
    else
      #will need to change to occupying_piece.display once i make the pieces.
    " #{@occupying_piece.display} ".colorize(background: "light_#{@color}".to_sym)
    end
  end

end