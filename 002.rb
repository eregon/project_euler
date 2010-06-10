# Each new term in the Fibonacci sequence is generated by adding the previous two terms.
# By starting with 1 and 2, the first 10 terms will be:
# 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
# 
# Find the sum of all the even-valued terms in the sequence which do not exceed four million.
# => 4 613 732

MAX = 4_000_000

fib_enumerator = Enumerator.new { |y|
  a = b = 1
  loop {
    y << a
    a, b = b, a + b
  }
}

# sum = 0
# loop {
#   n = fib_enumerator.next
#   break if n >= MAX
#   sum += n if n.even?
# }
# p sum

p fib_enumerator.inject(0) { |sum, n|
  break(sum) if n >= MAX
  n.even? ? sum + n : sum
}

