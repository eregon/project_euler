# What is the first term in the Fibonacci sequence to contain 1000 digits?

require_relative 'lib/fib_enumerator'

p FibEnumerator.each_with_index { |fib, i|
  break(i+1) if fib.to_s.size >= 1000
} # => 4782

