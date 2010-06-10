# The following iterative sequence is defined for the set of positive integers:
# 
# n → n/2 (n is even)
# n → 3n + 1 (n is odd)
# 
# Using the rule above and starting with 13, we generate the following sequence:
# 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
# 
# It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.
# 
# Which starting number, under one million, produces the longest chain?
# 
# NOTE: Once the chain starts the terms are allowed to go above one million.

# next_n = -> n {
#   n.even? ? n/2 : 3*n+1
# }

# p (1...1_000_000).max_by { |n|
#   i = 1
#   until n == 1
#     n = n.even? ? n/2 : 3*n+1 # next_n[n]
#     i += 1
#   end
#   i
# } # => 837799, 43s->17s

###### Using cache
# $calc = {}
# 
# def sequence(n, i = 1, original = n)
#   (n == 1 or ($calc.key? n and i += $calc[n]-1)) ? $calc[original] ||= i : sequence(n.even? ? n/2 : 3*n+1, i+1, original)
# end
# 
# p (1..1_000_000).max_by { |i| sequence(i) } # 837799, 5.44s->5.36(nice -20)


###### Using monkey-patching
=begin
class Integer
  attr_accessor :calc
  def sequence(i = 1, original = self)
    (self == 1 or (@calc and i += @calc-1)) ? original.calc = i : (even? ? self/2 : 3*self+1).sequence(i+1, original)
  end
end

p (1..1_000_000).max_by(&:sequence) # 837799, 7.6s
=end

# V2

class Integer
  attr_reader :calc
  def sequence(n = self, i = 1)
    (n == 1 or (n.calc and i += n.calc-1)) ? @calc = i : sequence(n.even? ? n/2 : 3*n+1, i+1)
  end
end

p (1..1_000_000).max_by(&:sequence) # 837799, 7.3s

# p 13.sequence
# p 40.sequence
# p 13.sequence
# p 40.sequence
