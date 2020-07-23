require './lib/board'
describe Board do
  # describe 'king_in_check?' do
  #   it "returns true if the king is in check" do
  #   board = Board.new
  #   board.display
  #   board.move_piece(board.square_hash[[3,1]],board.square_hash[[3,2]], board.white_pieces, board.black_pieces)
  #   board.move_piece(board.square_hash[[3,6]],board.square_hash[[3,5]], board.white_pieces, board.black_pieces)
  #   board.move_piece(board.square_hash[[2,0]],board.square_hash[[6,4]], board.white_pieces, board.black_pieces)
  #   board.move_piece(board.square_hash[[4,6]],board.square_hash[[4,5]], board.white_pieces, board.black_pieces)
  #   board.display
  #   expect(board.king_in_check?('black')).to eql(true)
  #   end
  # end

  describe "#move piece" do
    it "doesn't work if move puts king in check" do
    board = Board.new
    board.display
    board.move_piece(board.square_hash[[3,1]],board.square_hash[[3,2]], board.white_pieces, board.black_pieces)
    board.move_piece(board.square_hash[[3,6]],board.square_hash[[3,5]], board.white_pieces, board.black_pieces)
    board.move_piece(board.square_hash[[2,0]],board.square_hash[[6,4]], board.white_pieces, board.black_pieces)
    board.display
    expect(board.move_piece(board.square_hash[[4,6]],board.square_hash[[4,5]], board.white_pieces, board.black_pieces)).to eql('error')
    end
  end
end