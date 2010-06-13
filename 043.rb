=begin
The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.

Let d_(1) be the 1^(st) digit, d_(2) be the 2^(nd) digit, and so on. In this way, we note the following:

    * d_(2)d_(3)d_(4)=406 is divisible by 2
    * d_(3)d_(4)d_(5)=063 is divisible by 3
    * d_(4)d_(5)d_(6)=635 is divisible by 5
    * d_(5)d_(6)d_(7)=357 is divisible by 7
    * d_(6)d_(7)d_(8)=572 is divisible by 11
    * d_(7)d_(8)d_(9)=728 is divisible by 13
    * d_(8)d_(9)d_(10)=289 is divisible by 17

Find the sum of all 0 to 9 pandigital numbers with this property.
=end

require_relative 'lib/array/to_i'
require_relative 'lib/cached_prime/prime'
require_relative 'lib/integer'

def ss_divisible?(digits)
  @@ss_primes ||= CachedPrime.each(17).to_a
  digits[1..-1].each_cons(3).with_index.all? { |cons, i|
    (cons.to_i % @@ss_primes[i]) == 0
  }
end

p 1406357289.zero_pandigital?
p 1406357288.zero_pandigital?

p ss_divisible?(1406357289.digits)
p ss_divisible?(1406357298.digits)

=begin
def sub_pandigital(size, digits, original_size = size, &b)
  if size == 1
    #p "at 1, digits:#{digits}"
    last_d = ((0..original_size).to_a-digits).first
    b.yield (digits+[last_d]).to_i # .tap{|i|p i}
  else
    (original_size).downto(0) do |d|
      #p "at lvl #{size}, with digit #{d}, digits:#{digits}"
      next if digits.include?(d)
      sub_pandigital(size-1, digits+[d], original_size, &b)
    end
  end
end

def pandigitals(size, &b)
  return enum_for(__method__, size) unless block_given?
  (size-1).downto(1).map { |d1|
    sub_pandigital(size-1, [d1], &b)
  }.reduce(:+)
end

puts
p (101..300).select { |i| i.zero_pandigital? }.reverse == pandigitals(3).to_a
p 3.times.to_a.permutation(3).to_a.reject { |p| p[0] == 0 }.map(&:to_i).reverse == pandigitals(3).to_a
p (1023..4000).select { |i| i.zero_pandigital? }.reverse == pandigitals(4).to_a
=end

puts
pd_ss_d = 10.times.to_a.permutation(10).each_with_object([]) { |pandigital, pd_ss_d|
  next if pandigital[3].odd?
  if ss_divisible?(pandigital)
    p pandigital.to_i
    pd_ss_d << pandigital.to_i
  end
}
puts
p pd_ss_d.reduce(:+)
# 28s

__END__
1406357289
1430952867
1460357289
4106357289
4130952867
4160357289
[1406357289, 1430952867, 1460357289, 4106357289, 4130952867, 4160357289]
16695334890






