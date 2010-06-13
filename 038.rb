=begin
Take the number 192 and multiply it by each of 1, 2, and 3:

    192 × 1 = 192
    192 × 2 = 384
    192 × 3 = 576

By concatenating each product we get the 1 to 9 pandigital, 192384576. We will call 192384576 the concatenated product of 192 and (1,2,3)

The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and 5, giving the pandigital, 918273645, which is the concatenated product of 9 and (1,2,3,4,5).

What is the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated product of an integer with (1,2, ... , n) where n > 1?
=end

require_relative 'lib/array/to_i'
require_relative 'lib/integer/pandigital'

# So, what is the maximum candidate number that could make a 1to9 pandigital ?
# we need at least digits(n*1) digits(n*2)
# => maximum 4 digits

p 192384576.pandigital?

p (1..9999).each_with_object([]) { |n, good|
  digits = n.digits
  i = 2
  until digits.size >= 9
    # c_digits = (n*i).digits
    # break unless (digits & c_digits).empty?
    digits += (n*i).digits # c_digits
    i += 1
  end
  good << [digits.to_i, n] if digits.size == 9 and digits.to_i.pandigital?
}.max_by { |pandigital, n| pandigital }
# => [932718654, 9327], 0.28s => 0.19s

