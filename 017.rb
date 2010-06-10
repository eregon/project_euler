=begin
If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?

NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.
=end

class Array
  def sum
    reduce(:+)
  end
end

numbers = %w[
  zero
  one
  two
  three
  four
  five
  six
  seven
  eight
  nine
  ten
  eleven
  twelve
  thirteen
  fourteen
  fifteen
  sixteen
  seventeen
  eighteen
  nineteen
  twenty
].map { |word| word.length }

tens = %w[
  zero
  ten
  twenty
  thirty
  forty
  fifty
  sixty
  seventy
  eighty
  ninety
].map { |word| word.length }

# 1..20
one_to_99 = numbers[1..19].sum +
# 20-99
# (21..99).map { |i| tens[i/10]+numbers[i%10] }.sum
(2..9).map { |i| tens[i] + 9*tens[i] + numbers[1..9].sum }.sum

# 100 - 999
to_999 = one_to_99 + (1..9).map { |i|
  numbers[i] + "hundred".size + 99*(numbers[i] + "hundred".size + "and".size) + one_to_99
}.sum

p to_999 + numbers[1] + "thousand".size #=> 21124

# 1) 21541
# 2) 21424
# 3) 21414
# 4) 21124





