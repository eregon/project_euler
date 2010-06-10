class Integer
  def !
    (1..self).inject(1) { |fact, i| fact*i }
  end
end

if __FILE__ == $0
  require "benchmark"
  N = 20_000
  Benchmark.bm(15) do |results|
    results.report("#{N}!") {
      N.!
    }
  end
  
  require "test/unit"
  class TestDigits < Test::Unit::TestCase
    def test_fact
      assert_equal 1, 0.!
      assert_equal 1, 1.!
      assert_equal 2, 2.!
      assert_equal 120, 5.!
    end
  end
end
