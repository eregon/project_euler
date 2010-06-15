# What is the first term in the Fibonacci sequence to contain 1000 digits?

require_relative 'lib'

p FibEnumerator.each_with_index { |fib, i|
  break(i+1) if fib.ndigits >= 1000
} # => 4782

