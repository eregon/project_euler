class Integer
  def proper_divisors
      divisors = [1]
      2.upto(Math.sqrt(self).to_i) { |d|
        if self % d == 0
          divisors << d << self/d
        end
      }
      divisors.sort.uniq
  end
end

if __FILE__ == $0
  require "test/unit"

  class TestProperDivisors < Test::Unit::TestCase
    def test_proper_divisors
       assert_equal [1, 2, 4, 5, 10, 11, 20, 22, 44, 55, 110], 220.proper_divisors
       assert_equal [1, 2, 4, 71, 142], 284.proper_divisors
       assert_equal [1, 3], 9.proper_divisors
    end
  end
end
