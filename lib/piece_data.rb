module PieceData
  APPEARANCE = { 
                "white pawn" => "\u2659",
                "black pawn" => "\u265F",
                "white knight" => "\u2658",
                "black knight" => "\u265E",
                "white bishop" => "\u2657",
                "black bishop" => "\u265D",
                "white rook" => "\u2656",
                "black rook" => "\u265C",
                "white queen" => "\u2655",
                "black queen" => "\u265B",
                "white king" => "\u2654",
                "black king" => "\u265A"
                }

  def type_determiner(position)

    position[1] > 4 ? color = 'black' : color = 'white'

    if position[1] == 1 || position[1] == 7
      piece = 'pawn'
    elsif position[0] == 0 || position[0] == 7
      piece = 'rook'
    elsif position[0] == 1 || position[0] == 6
      piece = 'knight'
    elsif position[0] == 2 || position[0] == 5
      piece = 'bishop'
    elsif position[0] == 3
      color == 'white' ? piece = 'king' : piece = 'queen'
    elsif position[0] == 4
      color == 'white' ? piece = 'queen' : piece = 'king'
    end

    [color,piece]
  end
end
    
