=begin
A number chain is created by continuously adding the square of the digits in a number to form a new number until it has been seen before.

For example,

44 → 32 → 13 → 10 → 1 → 1
85 → 89 → 145 → 42 → 20 → 4 → 16 → 37 → 58 → 89

Therefore any chain that arrives at 1 or 89 will become stuck in an endless loop. What is most amazing is that EVERY starting number will eventually arrive at 1 or 89.

How many starting numbers below ten million will arrive at 89?
=end

require_relative 'lib'

p (1..1_000-1).count { |n|
  p n if n % 100_000 == 0
  until n == 1 or n == 89
    n = n.digits.inject(0) { |sum, digit| sum + digit**2 }
  end
  n == 89
} # => 8581146, 3min
