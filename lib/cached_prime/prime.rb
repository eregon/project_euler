require_relative '../cached_prime'

def binary_search(ary, value, lower = 0, upper = ary.size-1)
  return false if lower > upper
  middle = (lower+upper)/2
  case ary[middle] <=> value
  when -1 # <
    binary_search(ary, value, middle+1, upper)
  when 0 # =
    true
  when 1 # >
    binary_search(ary, value, lower, middle-1)
  end
end

class Integer
  def prime?
    binary_search(CachedPrime.cache, self)
  end
end

if __FILE__ == $0
  require "test/unit"
  class TestBinarySearch < Test::Unit::TestCase
    def test_binary_search
      assert_equal true, binary_search([1,2,3],1)
      assert_equal true, binary_search([1,2,3],2)
      assert_equal true, binary_search([1,2,3],3)
      
      assert_equal false, binary_search([1,2,3],0)
      assert_equal false, binary_search([1,2,3],4)
      assert_equal false, binary_search([1,2,3],-5000)
      assert_equal false, binary_search([1,2,3],999)
    end
  end
end


