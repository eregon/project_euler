=begin
The radical of n, rad(n), is the product of distinct prime factors of n.
For example, 504 = 2^(3) × 3^(2) × 7, so rad(504) = 2 × 3 × 7 = 42.

If we calculate rad(n) for 1 ≤ n ≤ 10, then sort them on rad(n), and sorting on n if the radical values are equal, we get:
Unsorted:
 n rad(n)
 1   1
 2   2
 3   3
 4   2
 5   5
 6   6
 7   7
 8   2
 9   3
10  10

Sorted:
n rad(n) k
 1   1   1
 2   2   2
 4   2   3
 8   2   4
 3   3   5
 9   3   6
 5   5   7
 6   6   8
 7   7   9
10  10  10

Let E(k) be the kth element in the sorted n column; for example, E(4) = 8 and E(6) = 9.

If rad(n) is sorted for 1 ≤ n ≤ 100000, find E(10000).
=end

require_relative 'lib'

E = -> k, sorted { sorted[k-1] }

sorted = (1..10).sort_by { |n| [rad(n), n] }

p E[4, sorted]
p E[6, sorted]

sorted = (1..100_000).sort_by { |n| [rad(n), n] }

p E[10000, sorted] # => 21417, 6.37s

