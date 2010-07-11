=begin
The number 145 is well known for the property that the sum of the factorial of its digits is equal to 145:

1! + 4! + 5! = 1 + 24 + 120 = 145

Perhaps less well known is 169, in that it produces the longest chain of numbers that link back to 169; it turns out that there are only three such loops that exist:

169 → 363601 → 1454 → 169
871 → 45361 → 871
872 → 45362 → 872

It is not difficult to prove that EVERY starting number will eventually get stuck in a loop. For example,

69 → 363600 → 1454 → 169 → 363601 (→ 1454)
78 → 45360 → 871 → 45361 (→ 871)
540 → 145 (→ 145)

Starting with 69 produces a chain of five non-repeating terms, but the longest non-repeating chain with a starting number below one million is sixty terms.

How many chains, with a starting number below one million, contain exactly sixty non-repeating terms?
=end

require_relative 'lib'

FACTORIALS = (0..9).map { |d| d.! }

$chain_lengths = {}
$sum_of_factorial_of_digits = {}

def sum_of_factorial_of_digits(n)
  $sum_of_factorial_of_digits[n] ||= n.digits.map { |d| FACTORIALS[d] }.reduce(:+)
end

def length_of_chain_of_non_repeating_terms(n, target = 0)
  start = n
  numbers = []
  begin
    if l = $chain_lengths[n] and (
        target > l+numbers.size or # This will return a wrong result if target > 0, but ensure returned length <= real length
        numbers.all? { |e| $chain_lengths[e] }
      )
      return numbers.size + $chain_lengths[n]
    end
    numbers << n
    n = sum_of_factorial_of_digits(n)
  end until numbers.include?(n)
  last = n
  length = numbers.size
  numbers.each_with_index { |n, i|
    $chain_lengths[n] = length-i;
    break if n == last # Could be longer as the number which will be repeated did not appear yet if we began there
  }
  length
end

# length_of_chain_of_non_repeating_terms(69)

p (11..1_000_000).count { |n| length_of_chain_of_non_repeating_terms(n, 60) == 60 }

=begin
require "test/unit"
class TestProb78 < Test::Unit::TestCase
  def test_given_examples
    assert_equal 3, length_of_chain_of_non_repeating_terms(169)
    assert_equal 2, length_of_chain_of_non_repeating_terms(871)
    assert_equal 2, length_of_chain_of_non_repeating_terms(872)
    assert_equal 5, length_of_chain_of_non_repeating_terms(69)
    assert_equal 4, length_of_chain_of_non_repeating_terms(78)
    assert_equal 2, length_of_chain_of_non_repeating_terms(540)
  end
end
=end

__END__
10_000, 0.23s
42
100_000, 2s
42
1_000_000, 38s
402
