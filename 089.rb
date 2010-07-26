=begin
The rules for writing Roman numerals allow for many ways of writing each number (see FAQ: Roman Numerals). However, there is always a "best" way of writing a particular number.

For example, the following represent all of the legitimate ways of writing the number sixteen:

IIIIIIIIIIIIIIII
VIIIIIIIIIII
VVIIIIII
XIIIIII
VVVI
XVI

The last example being considered the most efficient, as it uses the least number of numerals.

The 11K text file, roman.txt (right click and 'Save Link/Target As...'), contains one thousand numbers written in valid, but not necessarily minimal, Roman numerals; that is, they are arranged in descending units and obey the subtractive pair rule (see FAQ for the definitive rules for this problem).

Find the number of characters saved by writing each of these in their minimal form.

Note: You can assume that all the Roman numerals in the file contain no more than four consecutive identical units.
=end

class Roman
  MAX_ROMAN = 4999
  FACTORS = [
    ["M", 1000], ["CM", 900], ["D",  500], ["CD", 400],
    ["C",  100], ["XC",  90], ["L",   50], ["XL",  40],
    ["X",   10], ["IX",   9], ["V",    5], ["IV",   4],
    ["I",    1]
  ]

  def initialize(str)
    @value = 0
    for code, factor in FACTORS
      if pos = (str =~ /^((?:#{code})+)/)
        @value += factor * ($1.length/code.length)
        str = $'
      end
    end
  end
  
  def to_s
    FACTORS.inject(["", @value]) { |(answer, number), (roman, arabic)|
      [ answer + roman * (number / arabic), number % arabic ]
    }.first
  end
end

p File.read('data/roman.txt').lines.inject(0) { |gain, line|
  original_form = line.chomp
  gain + original_form.size - Roman.new(original_form).to_s.size
} # => 743

