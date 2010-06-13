require_relative 'digits'

class Integer
  def pandigital? # one-to-n(digits) pandigital
    digits = digits()
    digits.uniq == digits && digits.sort == (1..digits.size).to_a
  end

  def zero_pandigital? # zero-to-n(digits-1) pandigital
    digits = digits()
    digits.uniq == digits && digits.sort == (0...digits.size).to_a
  end
end
