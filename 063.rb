=begin
The 5-digit number, 16807=7^(5), is also a fifth power. Similarly, the 9-digit number, 134217728=8^(9), is a ninth power.

How many n-digit positive integers exist which are also an nth power?
=end

require_relative 'lib'

# 10**n will always produce n+1 digits, which is too much
# 9**n is then the maximum
# This behavior will stop when 9**n will produce less than n digits

max = (1..Float::INFINITY).find { |n| (9**n).ndigits < n }

p (1..max).inject(0) { |count, n|
  count + (1..9).count { |d|
    (d**n).ndigits == n
  }
} # => 49
