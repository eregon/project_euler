=begin
In England the currency is made up of pound, £, and pence, p, and there are eight coins in general circulation:

  1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).

It is possible to make £2 in the following way:

  1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p

How many different ways can £2 be made using any number of coins?
=end

coins = [200, 100, 50, 20, 10, 5, 2, 1]

# Sorry, I could not find out the solution by myself. So I preferred to take some others and tune them to my way

# From http://tardate.blogspot.com/2008/10/rolling-project-euler-on-ruby.html
class Integer
  # calculates integer partitions for given number using array of elements
  # http://en.wikipedia.org/wiki/Integer_partition
  # @see project euler #31
  def integer_partitions(pArray, p = 0)
    if p == pArray.size-1
      1
    else
      self < 0 ? 0 : (self - pArray[p]).integer_partitions(pArray, p) + self.integer_partitions(pArray, p+1)
    end
  end
end
p 200.integer_partitions(coins) # => 73682

# From http://d.hatena.ne.jp/htz/20090304/1236177176
def solv(coins, pence)
  @solv_cache ||= {}
  return 1 if coins.size == 1
  @solv_cache[[coins.size, pence]] ||= begin
    coins = coins.dup
    first_coin = coins.shift
    (0..pence/first_coin).inject(0) { |count, i|
      count + solv(coins, pence - i*first_coin)
    }
  end
end
p solv(coins, 200) # => 73682

require "benchmark"
Benchmark.bm(20) { |x|
  N = 2000
  x.report("integer_partitions") {
    #N.integer_partitions(coins)
  }
  x.report("solv") {
    solv(coins, N)
  }
}

