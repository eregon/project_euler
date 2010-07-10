module Math
  # numbers = [2,3,4]
  # 2 + 1/( 3+1/( 4 ) )
  # 2 + Rational(1,3 + Rational(1,4) )
  def continued_fraction(numbers)
    numbers.reverse_each.inject(numbers.pop) { |r, n|
      n + Rational(1, r)
    }
  end
  module_function :continued_fraction
end
