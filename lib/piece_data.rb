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

    if position[1] == 1 || position[1] == 6
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

  def rook_moves(position, color, square_hash)
    column = position[0]
    row = position[1]
    possible_moves = []
    #right
    square = square_hash[[column + 1, row]]
    i = 1
    until square.nil? || square.occupied
      square.selected = true
      possible_moves.push(square)
      i += 1
      square = square_hash[[column + i, row]]
    end
    unless square.nil? || square.occupying_piece.color == color
      square.selected = true
      possible_moves.push(square)
    end
    #left
    square = square_hash[[column - 1, row]]
    i = 1
    until square.nil? || square.occupied
      square.selected = true
      possible_moves.push(square)
      i += 1
      square = square_hash[[column - i, row]]
    end
    unless square.nil? || square.occupying_piece.color == color
      square.selected = true
      possible_moves.push(square)
    end
    #up
    square = square_hash[[column, row + 1]]
    i = 1
    until square.nil? || square.occupied
      square.selected = true
      possible_moves.push(square)
      i += 1
      square = square_hash[[column, row + i]]
    end
    unless square.nil? || square.occupying_piece.color == color
      square.selected = true
      possible_moves.push(square)
    end
    #down
    square = square_hash[[column, row - 1]]
    i = 1
    until square.nil? || square.occupied
      square.selected = true
      possible_moves.push(square)
      i += 1
      square = square_hash[[column, row - i]]
    end
    unless square.nil? || square.occupying_piece.color == color
      square.selected = true
      possible_moves.push(square)
    end
    possible_moves
  end

  def pawn_moves(position, color, square_hash)
    possible_moves = []
    column = position[0]
    row = position[1]
    current_square = square_hash[[column,row]]
    if color == 'white'
      square_up = square_hash[[column,row + 1]]
      square_diagonal_right = square_hash[[column + 1, row + 1]]
      square_diagonal_left = square_hash[[column - 1, row + 1]]
      if position[1] == 1
        square_two_up = square_hash[[column,row + 2]]
        possible_moves.push(square_two_up)
        square_two_up.selected = true
      end
      unless square_up.nil?
        possible_moves.push(square_up)
        square_up.selected = true
      end
      if  !square_diagonal_right.nil? && square_diagonal_right.occupied && square_diagonal_right.occupying_piece.color != color
        possible_moves.push(square_diagonal_right)
        square_diagonal_right.selected = true
      elsif !square_diagonal_left.nil? && square_diagonal_left.occupied && square_diagonal_left.occupying_piece.color != color 
        possible_moves.push(square_diagonal_left)
        square_diagonal_left.selected = true
      end
    else
      square_up = square_hash[[column,row - 1]]
      square_diagonal_right = square_hash[[column + 1, row - 1]]
      square_diagonal_left = square_hash[[column - 1, row - 1]]
      if position[1] == 6
        square_two_up = square_hash[[column,row - 2]]
        possible_moves.push(square_two_up)
        square_two_up.selected = true
      end
      unless square_up.nil?
        possible_moves.push(square_up)
        square_up.selected = true
      end
      if  !square_diagonal_right.nil? && square_diagonal_right.occupied && square_diagonal_right.occupying_piece.color != color
        possible_moves.push(square_diagonal_right)
        square_diagonal_right.selected = true
      elsif !square_diagonal_left.nil? && square_diagonal_left.occupied && square_diagonal_left.occupying_piece.color != color
        possible_moves.push(square_diagonal_left)
        square_diagonal_left.selected = true
      end
    end
    possible_moves
  end

  def clear_selected(square_hash)
    square_hash.each { |position, square| square.selected = false }
  end

  def possible_moves(position, type, color, square_hash)
    clear_selected(square_hash)
    if type == 'rook'
      rook_moves(position, color, square_hash)
    elsif type == 'pawn'
      pawn_moves(position, color, square_hash)
    end
  end
end

    
