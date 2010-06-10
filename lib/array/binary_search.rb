class Array
  def binary_search(value, lower = 0, upper = size-1)
    return false if lower > upper
    middle = (lower+upper)/2
    case self[middle] <=> value
    when -1 # <
      binary_search(value, middle+1, upper)
    when 0 # =
      true
    when 1 # >
      binary_search(value, lower, middle-1)
    end
  end
end

if __FILE__ == $0
  require "test/unit"
  class TestBinarySearch < Test::Unit::TestCase
    def test_binary_search
      assert_equal true, [1,2,3].binary_search(1)
      assert_equal true, [1,2,3].binary_search(2)
      assert_equal true, [1,2,3].binary_search(3)

      assert_equal false, [1,2,3].binary_search(0)
      assert_equal false, [1,2,3].binary_search(4)
      assert_equal false, [1,2,3].binary_search(-5000)
      assert_equal false, [1,2,3].binary_search(999)
    end
  end
end


