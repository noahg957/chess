require './lib/game'
describe Game do
  describe "#game_loop" do
    it "puts check when a player is put in check" do
      game = Game.new
      game.stub(:gets).and_return("Noah\n", "Andy\n", "d2\n", "d3\n", "e7\n", "e6\n", "c1\n", "g5\n",)
      game.get_players
      game.get_and_move(game.white)
      game.get_and_move(game.black)
      game.get_and_move(game.white)
      expect(game.board.king_in_check?('black')).to eql(true)
    end
  end
end