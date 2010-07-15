module Enumerable
  def sum
    reduce(:+)
  end

  def product
    reduce(:*)
  end
end
