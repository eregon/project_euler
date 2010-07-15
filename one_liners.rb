# This is a compilation of some oneLiners
# The style differ from the normal solution to be easily read

require_relative 'lib'

def euler n, result
  puts if n % 5 == 0
  puts "Problem #{n}: #{result}"
end

def method_missing(meth, *args, &blk)
  case meth
  when /^data_(.+)/
    File.read("data/#{$1}.txt")
  else
    super
  end
end

euler 1, (1...1000).select { |i| i % 3 == 0 or i % 5 == 0 }.sum
euler 2, FibEnumerator.take_while { |n| n < 4_000_000 }.select(&:even?).sum
euler 3, 600851475143.prime_factors.last.first
euler 4, 1000.times.combination(2).map { |a,b| a*b }.select(&:palindrome?).max
euler 5, (2..20).inject({}) { |h,n| h.merge(Hash[n.prime_factors]) { |_,a,b| [a,b].max } }.map { |f,p| f**p }.product

euler 6, (1..100).sum**2 - (1..100).map { |i| i*i }.sum
euler 7, CachedPrime.take(10001).last
euler 8, data_008.scan(/\d/).join.to_i.digits.each_cons(5).map(&:product).max
euler 9, -> n { (1..n).combination(2) { |a,b| break(a*b*(n-a-b)) if (c = Math.hypot a,b).whole? and a+b+c == n } }.(1000)
euler 10, CachedPrime.each(2_000_000).sum

euler 13, data_013.lines.map(&:to_i).sum.to_s[0...10]

euler 15, (2*20).! / 20.!**2
euler 16, (2**1000).digits.sum

euler 19, (1901..2000).map { |year| (1..12).count { |month| Time.utc(year, month, 1).sunday? } }.sum
euler 20, 100.!.digits.sum

