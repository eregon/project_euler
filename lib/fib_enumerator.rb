FibEnumerator = Enumerator.new { |y|
  a = b = 1
  loop {
    y << a
    a, b = b, a + b
  }
}
