=begin
There are exactly ten ways of selecting three from five, 12345:

123, 124, 125, 134, 135, 145, 234, 235, 245, and 345

In combinatorics, we use the notation, C_(3,5) = 10.

In general,
C_(r,n) = n! / r!(n−r)!, where r ≤ n, n! = n×(n−1)×...×3×2×1, and 0! = 1.

It is not until n = 23, that a value exceeds one-million: C_(10,23) = 1144066.

How many, not necessarily distinct, values of C_(r,n), for 1 ≤ n ≤ 100, are greater than one-million?
=end

require_relative 'lib/integer/factorial'

C = -> n, r { n.!/(r.!*(n-r).!) }

p C[23,9]
p C[23,10]
p C[23,11]
p C[23,12]
p C[23,13]

p (23..100).inject(0) { |counter, n|
  if C[n, r = n/2] > 1_000_000
    counter += n.odd? ? 2 : 1
    counter += 2 while r -= 1 and C[n, r] > 1_000_000
  end
  counter
} # => 4075
