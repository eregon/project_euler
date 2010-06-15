=begin
Comparing two numbers written in index form like 2^(11) and 3^(7) is not difficult, as any calculator would confirm that 2^(11) = 2048 < 3^(7) = 2187.

However, confirming that 632382^(518061) > 519432^(525806) would be much more difficult, as both numbers contain over three million digits.

Using base_exp.txt (right click and 'Save Link/Target As...'), a 22K text file containing one thousand lines with a base/exponent pair on each line, determine which line number has the greatest numerical value.

NOTE: The first two lines in the file represent the numbers in the example given above.
=end

numbers = IO.read('data/base_exp.txt').lines.map { |line| line.split(',').map(&:to_i) }

# As log(a**b) = b*log(a), and log(x) is an increasing fonction, we can compare using b*log(a)
p numbers.index(numbers.max_by { |base,exp| exp * Math.log(base) }) + 1 # => 709

