module Enumerable
  def sum
    reduce(:+)
  end

  def product
    reduce(:*)
  end

  [:combination, :permutation].each { |meth|
    define_method(meth) { |*a, &b|
      to_a.send(meth, *a, &b)
    }
  }
end
