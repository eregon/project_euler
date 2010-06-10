# The sum of the squares of the first ten natural numbers is,
# 1^(2) + 2^(2) + ... + 10^(2) = 385
# 
# The square of the sum of the first ten natural numbers is,
# (1 + 2 + ... + 10)^(2) = 55^(2) = 3025
# 
# Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640.
# 
# Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.

sum_of_the_square = -> n {
  1.upto(n).inject(0) { |sum, i| sum + i**2 }
}

square_of_the_sum = -> n {
  1.upto(n).reduce(:+)**2
}

p sum_of_the_square[10] == 385
p square_of_the_sum[10] == 3025

N = 100
p square_of_the_sum[N] - sum_of_the_square[N]
