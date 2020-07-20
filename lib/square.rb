require 'colorize'

class Square
  
  attr_reader :position, :color
  attr_accessor :occupied, :occupying_piece, :selected

  def initialize(column, row, color)
    @position = [column, row]
    @occupied = false
    @occupying_piece = nil
    @color = color
    @selected = false
  end

  def display
    unless @selected == true
      if @occupying_piece.nil?
        "   ".colorize(background: "light_#{@color}".to_sym)
      else
      " #{@occupying_piece.display} ".colorize(background: "light_#{@color}".to_sym)
      end
    else
      if @occupying_piece.nil?
        @color == 'white' ? type_of_green = "light_green".to_sym : type_of_green = "green".to_sym
        "   ".colorize(background: type_of_green)
      else
      " #{@occupying_piece.display} ".colorize(background: "light_red".to_sym)
      end
    end
  end
end