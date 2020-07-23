require './lib/conversion.rb'


describe Tester do
  describe "#number_to_letter" do
    it "converts coordinates (0,0) to chessboard coordinates (a1)" do
      tester = Tester.new
      expect(tester.number_to_letter([5,6])).to eql('f7')
    end
  end
  describe "#letter_to_number" do
    it "converts chessboard coordinates to coordinates" do
      tester = Tester.new
      expect(tester.letter_to_number('f7')).to eql([5,6])
    end
    it "works with uppercase letters" do
      tester = Tester.new
      expect(tester.letter_to_number('F7')).to eql([5,6])
    end
  end
end