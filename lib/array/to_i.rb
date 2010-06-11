class Array
  def to_i # Transform an array of digits into a (positive) Integer
    reverse_each.with_index.inject(0) { |n, (d, i)| n + d*10**i }
  end
end

if __FILE__ == $0
  require "benchmark"
  N = 100_000
  Benchmark.bmbm(15) do |results|
    results.report('ary.to_i') {
      N.times { |n| n.to_s.chars.map(&:to_i).to_i }
    }
  end

  require "test/unit"
  class TestDigits < Test::Unit::TestCase
    def test_to_i
      assert_equal 1, [1].to_i
      assert_equal 9, [9].to_i
      assert_equal 10, [1,0].to_i
      assert_equal 11, [1,1].to_i
      assert_equal 123, [1,2,3].to_i
      assert_equal 456, [4,5,6].to_i
      assert_equal 45060, [4,5,0,6,0].to_i
    end
    def test_zero
      assert_equal 0, [0].to_i
    end
  end
end

