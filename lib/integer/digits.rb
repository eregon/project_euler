class Integer
  def digits
    return [0] if self == 0
    n, digits = abs, []
    n, digits[digits.size] = n.divmod(10) until n == 0
    digits.reverse
  end

  def ndigits
    abs.to_s.size
  end
end

if __FILE__ == $0
  require "benchmark"
  N = 100_000
  Benchmark.bmbm(15) do |results|
    results.report('to_s.chars.map') {
      N.times { |n| n.to_s.chars.map(&:to_i) }
    }
    results.report('to_s.bytes.map') {
      N.times { |n| n.to_s.bytes.map(&:to_i) }
    }
    results.report('divmod') {
      N.times { |n| n.digits }
    }
  end

  M = 1_000_000
  Benchmark.bmbm(15) do |results|
    results.report('abs.to_s.size') {
      M.times { |n| n.ndigits }
    }
    results.report('log') {
      M.times { |n| n == 0 ? 1 : Math.log10(n.abs).floor + 1 }
    }
  end

  require "test/unit"
  class TestDigits < Test::Unit::TestCase
    def test_digits
      assert_equal [1], 1.digits
      assert_equal [9], 9.digits
      assert_equal [1,0], 10.digits
      assert_equal [1,1], 11.digits
      assert_equal [1,2,3], 123.digits
      assert_equal [4,5,6], -456.digits
      assert_equal [4,5,0,6,0], -45060.digits
    end
    def test_zero
      assert_equal [0], 0.digits
    end
  end
end
