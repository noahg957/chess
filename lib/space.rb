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
    "  ".colorize(background: "light_#{@color}".to_sym)
  end

end