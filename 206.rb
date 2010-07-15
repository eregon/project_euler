=begin
Find the unique positive integer whose square has the form 1_2_3_4_5_6_7_8_9_0,
where each “_” is a single digit.
=end

# 1_2_3_4_5_6_7_8_9_0 has 21 digits, its square root has then 10 digits
# As last digit is 0, last digit of sqrt must be zero and so the one before the last of n too

require_relative 'lib'

n = "1_2_3_4_5_6_7_8_900"
n_digits = n.tr('_0','').to_i.digits

spaces = n.count("_")

=begin
p r = (0..9).to_a.repeated_permutation(spaces).each { |comb|
  square = ((1..9).each_with_object([]) { |digit, digits|
    digits << digit << comb.shift
  } << 0).to_i
  sqrt = Math.sqrt(square)
  if (sqrt - sqrt.to_i).abs < 1e-3
    break(sqrt)
  end
}

p r.to_i**2
p r**2
=end

min = Math.sqrt(n.tr('_','0').to_i).to_i
max = Math.sqrt(n.tr('_','9').to_i).to_i

end_width = (0..9).map { |d_1| [d_1, 0].to_i }.select { |i| (i*i) % 1000 == 900 }

min += 1 until end_width.any? { |e| min % 100 == e }
max -= 1 until end_width.any? { |e| max % 100 == e }

p min, max

# digits = n.tr('_','0').to_i.digits
# p n_digits.each_with_index.all? { |d,i| digits[i*2] == d }
# => p n_digits.all? { |d| digits[d*2-2] == d }

sqrt = (min...max).step(20).find { |sqrt|
  next unless mod = sqrt % 100 and (mod == 30 or mod == 70)
  n = sqrt*sqrt
  digits = n.digits
  n_digits.all? { |d| digits[d*2-2] == d }
}
p sqrt
