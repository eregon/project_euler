# Work out the first ten digits of the sum of the following one-hundred 50-digit numbers.

puts IO.read('data/013.txt').lines.map(&:to_i).reduce(:+).to_s[0...10] # => 5537376230
