# Find the greatest product of five consecutive digits in the 1000-digit number.

require_relative 'lib'
p IO.read('data/008.txt').scan(/\d/).join.to_i.digits.each_cons(5).map { |digits|
  digits.reduce(:*)
}.max # => 40824
