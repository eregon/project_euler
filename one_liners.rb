# This is a compilation of some oneLiners
# The style differ from the normal solution to be easily read

require_relative 'lib'

@problems = File.read(__FILE__).lines.grep(/^#/)[2..-1]

def euler n, result
  puts "Problem #{n}: #{@problems.shift.sub(/# /,'')}"
  puts result
  puts
end

def method_missing(meth, *args, &blk)
  case meth
  when /^data_(.+)/
    File.read("data/#{$1}.txt")
  else
    super
  end
end

# Add all the natural numbers below one thousand that are multiples of 3 or 5
euler 1, (1...1000).select { |i| i % 3 == 0 or i % 5 == 0 }.sum

# Find the sum of all the even-valued terms in the Fibonacci sequence which do not exceed four million
euler 2, FibEnumerator.take_while { |n| n < 4_000_000 }.select(&:even?).sum

# Find the largest prime factor of a composite number
euler 3, 600851475143.prime_factors.last.first

# Find the largest palindrome made from the product of two 3-digit numbers
euler 4, 1000.times.combination(2).map { |a,b| a*b }.select(&:palindrome?).max

# What is the smallest number divisible by each of the numbers 1 to 20?
euler 5, (2..20).inject({}) { |h,n| h.merge(Hash[n.prime_factors]) { |_,a,b| [a,b].max } }.map { |f,p| f**p }.product


# What is the difference between the sum of the squares and the square of the sums?
euler 6, (1..100).sum**2 - (1..100).map { |i| i*i }.sum

# Find the 10001st prime
euler 7, CachedPrime.take(10001).last

# Discover the largest product of five consecutive digits in the 1000-digit number
euler 8, data_008.scan(/\d/).join.to_i.digits.each_cons(5).map(&:product).max

# Find the only Pythagorean triplet, {a, b, c}, for which a + b + c = 1000
euler 9, -> n { (1..n).combination(2) { |a,b| break(a*b*(n-a-b)) if (c = Math.hypot a,b).whole? and a+b+c == n } }.(1000)

# Calculate the sum of all the primes below two million
euler 10, CachedPrime.each(2_000_000).sum

# Find the first ten digits of the sum of one-hundred 50-digit numbers
euler 13, data_013.lines.map(&:to_i).sum.to_s[0...10]

# Starting in the top left corner in a 20 by 20 grid, how many routes are there to the bottom right corner?
euler 15, (2*20).! / 20.!**2

# What is the sum of the digits of the number 21000?
euler 16, (2**1000).digits.sum

# How many Sundays fell on the first of the month during the twentieth century?
euler 19, (1901..2000).map { |year| (1..12).count { |month| Time.utc(year, month, 1).sunday? } }.sum

# Find the sum of digits in 100!
euler 20, 100.!.digits.sum

