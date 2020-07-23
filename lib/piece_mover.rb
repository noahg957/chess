module PieceMover
  def capture_piece(captured_piece, white_captured_pieces, black_captured_pieces, white_pieces, black_pieces)
    captured_piece.color == 'white' ? white_captured_pieces.push(captured_piece) : black_captured_pieces.push(captured_piece)
    captured_piece.color == 'white' ? white_pieces.delete(captured_piece) : black_pieces.delete(captured_piece)
    captured_piece.square_on = nil
    captured_piece.position = nil
  end

  def change_piece_location(piece,start_square,end_square)
    end_square.occupying_piece = piece
    end_square.occupied = true
    start_square.occupying_piece = nil
    start_square.occupied = false
    piece.square_on = end_square
    piece.position = end_square.position
  end

  def undo_move(piece, captured_piece, start_square, end_square, white_pieces, black_pieces, white_captured_pieces, black_captured_pieces)
    piece.position = start_square.position
    piece.square_on = start_square
    start_square.occupied = true
    start_square.occupying_piece = piece
    unless captured_piece.nil?
      end_square.occupying_piece = captured_piece
      end_square.occupied = true
      captured_piece.position = end_square.position
      captured_piece.square_on = end_square
      captured_piece.color == 'white' ? white_pieces.push(captured_piece) : black_pieces.push(captured_piece)
      captured_piece.color == 'white' ? white_captured_pieces.delete(captured_piece) : black_captured_pieces.delete(captured_piece)
    else
      end_square.occupied = false
      end_square.occupying_piece = captured_piece
    end
  end

  def king_in_check?(color, white_pieces, black_pieces, white_captured_pieces, black_captured_pieces, square_hash)
    if color == 'white' 
      color_pieces = white_pieces
    else
      color_pieces = black_pieces
    end
    king = color_pieces.select { |piece| piece.type == 'king' }
    king = king[0]
    king_square = king.square_on
    checked = !check_checker(king_square, color, square_hash, white_pieces, black_pieces, white_captured_pieces, black_captured_pieces)
  end


  def move_piece(start_square,end_square, white_pieces, black_pieces, white_captured_pieces, black_captured_pieces, square_hash)
    piece = start_square.occupying_piece
    move_list = piece.list_moves(white_pieces, black_pieces, white_captured_pieces, black_captured_pieces)
    if move_list.include?(end_square)
      if end_square.occupied
        captured_piece = end_square.occupying_piece
        capture_piece(captured_piece, white_captured_pieces, black_captured_pieces, white_pieces, black_pieces)
      end
      change_piece_location(piece, start_square, end_square)
      captured_piece = nil unless !captured_piece.nil?
    else
      return "Sorry, that move doesn't work."
    end
    clear_selected(square_hash)
    'works'
  end

  def test_move_piece(start_square,end_square, white_pieces, black_pieces, white_captured_pieces, black_captured_pieces, square_hash)
    checked = false
    piece = start_square.occupying_piece
    if end_square.occupied
      captured_piece = end_square.occupying_piece
      capture_piece(captured_piece, white_captured_pieces, black_captured_pieces, white_pieces, black_pieces)
    end
    change_piece_location(piece, start_square, end_square)
    captured_piece = nil unless !captured_piece.nil?
    if king_in_check?(piece.color, white_pieces, black_pieces, white_captured_pieces, black_captured_pieces, square_hash)
      checked = true
    end
    undo_move(piece, captured_piece, start_square, end_square, white_pieces, black_pieces, white_captured_pieces, black_captured_pieces)
    clear_selected(square_hash)
    checked
  end
end