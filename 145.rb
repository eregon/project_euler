=begin
Some positive integers n have the property that the sum [ n  + reverse(n) ] consists entirely of odd (decimal) digits. For instance, 36 + 63 = 99 and 409 + 904 = 1313. We will call such numbers reversible; so 36, 63, 409, and 904 are reversible. Leading zeroes are not allowed in either n or reverse(n).

There are 120 reversible numbers below one-thousand.

How many reversible numbers are there below one-billion (10^(9))?
=end

require_relative 'lib'

class Integer
  def reverse
    n, r = self, 0
    (ndigits-1).downto(0) { |i|
      n, mod = n.divmod(10)
      r += mod * 10**i
    }
    r
  end
  
  def reverse_s
    to_s.reverse.to_i
  end
  
  def reversible_naive?
    self % 10 != 0 and (self+reverse_s).digits.all?(&:odd?)
  end
  
  TEN_POWS = 10.times.map { |i| 10**i }
  
  def reversible?
    return false if self % 10 == 0
    n = self
    nd = ndigits()
    #return false if nd.odd? # odd number of digits, the central can not be odd
    rest = [0]
    nd.times { |i|
      l = (n / TEN_POWS[nd-1-i]) % 10
      r = (n / TEN_POWS[i]) % 10 + rest[i] # (n % 10**(i+1)) / 10**i + rest[i]
      rest[i+1] = (s=l+r) / 10
      return false unless s.odd?
    }
    true
  end
end

p 1.reversible?
p 2.reversible?

p (1...1_000_000_000).count(&:reversible?) # => 608720, 37m

__END__
1_000
120
10_000 # *5, +600
720, 0.1s
100_000 # *1, +0
720, 0.3s
1_000_000 # + 18_000
18720, 2.2s, 0.2s
10_000_000 # + 50_000
68720, 22s, 1.8s
100_000_000 # + 540_000
608720, 3m43s, 18s
1_000_000_000 # *1, +0
608720, 37m, 3min

