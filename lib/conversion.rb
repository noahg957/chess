module Conversion

  Alphabet = [('a','b','c','d','e','f','g','h')]

  def number_to_letter(coordinates)
    column = coordinates[0]
    row = coordinates[1]
    Alphabet[column] = letter
    "#{letter}#{row}"
  end
