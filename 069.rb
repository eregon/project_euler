=begin
Euler's Totient function, φ(n) [sometimes called the phi function], is used to determine the number of numbers less than n  which are relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively prime to nine, φ(9)=6.
n   φ(n) n/φ(n)
2   1    2
3   2    1.5
4   2    2
5   4    1.25
6   2    3
7   6    1.1666...
8   4    2
9   6    1.5
10  4    2.5

It can be seen that n=6 produces a maximum n/φ(n) for n ≤ 10.

Find the value of n ≤ 1,000,000 for which n/φ(n) is a maximum.
=end

require_relative 'lib'

p (1..1_000_000).max_by { |n|
  n.to_f / φ(n)
} # => 510510, 97s
