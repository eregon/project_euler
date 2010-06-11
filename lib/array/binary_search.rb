class Array
  def binary_search(value, lower = 0, upper = size-1)
    return false if lower > upper
    case self[middle = (lower+upper)/2] <=> value
    when -1 # <
      binary_search(value, middle+1, upper)
    when 0 # =
      true
    when 1 # >
      binary_search(value, lower, middle-1)
    end
  end

  def binary_search_iterative(value)
    lower, upper = 0, size-1
    until (v = at(middle = (lower+upper)/2)) == value or lower > upper
      v < value ? lower = middle+1 : upper = middle-1
    end
    v == value
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
    def binary_search_iterative
      assert_equal true, [1,2,3].binary_search_iterative(1)
      assert_equal true, [1,2,3].binary_search_iterative(2)
      assert_equal true, [1,2,3].binary_search_iterative(3)

      assert_equal false, [1,2,3].binary_search_iterative(0)
      assert_equal false, [1,2,3].binary_search_iterative(4)
      assert_equal false, [1,2,3].binary_search_iterative(-5000)
      assert_equal false, [1,2,3].binary_search_iterative(999)
    end
  end

  require "benchmark"
  N = 1_000_000
  Benchmark.bmbm(15) do |results|
    ary = Array.new(N) { |i| i }
    results.report('binary_search') {
      ary.binary_search(2)
      ary.binary_search(N-2)
    }
    results.report('binary_search_iterative') {
      ary.binary_search_iterative(2)
      ary.binary_search_iterative(N-2)
    }
    results.report('include?') {
      ary.include?(2)
      ary.include?(N-2)
    }
    results.report('any? (find)') {
      ary.any? { |n| n == 2 }
      ary.any? { |n| n == N-2 }
    }
  end

  require_relative '../cached_prime'
  Benchmark.bmbm(15) do |results|
    N = 1_000_000
    ary = CachedPrime.each(N).to_a
    sample = ary.sample
    bad = rand(N/2)*2
    results.report('binary_search') {
      ary.binary_search(sample)
      ary.binary_search(bad)
    }
    results.report('binary_search_iterative') {
      ary.binary_search_iterative(sample)
      ary.binary_search_iterative(bad)
    }
    results.report('include?') {
      ary.include?(sample)
      ary.include?(bad)
    }
    results.report('any? (find)') {
      ary.any? { |n| n == sample }
      ary.any? { |n| n == bad }
    }
  end
end
