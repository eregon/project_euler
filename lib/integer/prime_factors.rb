require "prime"
class Integer
  def prime_factors
    Prime.prime_division(self)
  end
end
