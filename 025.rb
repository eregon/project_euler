# What is the first term in the Fibonacci sequence to contain 1000 digits?

fib_enumerator = Enumerator.new { |y|
  a = b = 1
  loop {
    y << a
    a, b = b, a + b
  }
}

p fib_enumerator.each_with_index { |fib, i|
  break(i+1) if fib.to_s.size >= 1000
}

