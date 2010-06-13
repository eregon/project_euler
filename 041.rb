=begin
We shall say that an n-digit number is pandigital if
 it makes use of all the digits 1 to n exactly once.
For example, 2143 is a 4-digit pandigital and is also prime.

What is the largest n-digit pandigital prime that exists?
=end

require_relative 'lib/integer'
require_relative 'lib/array/to_i'

def main
  (3..9).reverse_each { |digits|
    (1..digits).to_a.permutation(digits).reverse_each { |pandigital|
      return pandigital.to_i if pandigital.to_i.prime?
    }
  }
end
# p main #=> 7652413, 7.5s

require_relative 'lib/cached_prime'
# p CachedPrime.each(10_000_000).select(&:pandigital?).last # => 7652413, 6.6s
p CachedPrime.each(10_000_000).reverse_each.find(&:pandigital?) # => 7652413, 2s vs 75s

__END__
1423
2143
2341
4231
...
7652413
