=begin
Find the unique positive integer whose square has the form 1_2_3_4_5_6_7_8_9_0,
where each “_” is a single digit.
=end

# 1_2_3_4_5_6_7_8_9_0 has 21 digits, its square root has then 10 digits

require_relative 'lib'

#n = "1_2_3_4_5_6_7_8_9_0"

spaces = "1_2_3_4_5_6_7_8_9_0".count("_")

p r = (0..9).to_a.repeated_combination(spaces).each { |comb|
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
