module Conversion

  Alphabet = ['a','b','c','d','e','f','g','h']

  def number_to_letter(coordinates)
    column = coordinates[0]
    row = coordinates[1] + 1
    letter = Alphabet[column]
    "#{letter}#{row}"
  end

  def letter_to_number(string)
    string.downcase!
    array = string.split("")
    row = array[1].to_i - 1
    column = Alphabet.index(array[0])
    [column, row]
  end
end
class Tester
  include Conversion
end