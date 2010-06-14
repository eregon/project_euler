=begin
Peter has nine four-sided (pyramidal) dice, each with faces numbered 1, 2, 3, 4.
Colin has six six-sided (cubic) dice, each with faces numbered 1, 2, 3, 4, 5, 6.

Peter and Colin roll their dice and compare totals: the highest total wins. The result is a draw if the totals are equal.

What is the probability that Pyramidal Pete beats Cubic Colin? Give your answer rounded to seven decimal places in the form 0.abcdefg
=end

class Dice
  attr_reader :sides
  def initialize(sides)
    @sides = sides
  end

  def possible_values
    (1..@sides)
  end
end

def calc_possibles(values, i, sum = 0, results = Hash.new(0))
  values.each { |value|
    if i == 1
      results[sum+value] += 1
    else
      calc_possibles(values, i-1, sum+value, results)
    end
  }
  results
end

Peter = Array.new(9, Dice.new(4))
Colin = Array.new(6, Dice.new(6))

peter = calc_possibles(Peter.first.possible_values, Peter.size)
colin = calc_possibles(Colin.first.possible_values, Colin.size)
possibles = peter.values.reduce(:+) * colin.values.reduce(:+)

pwins = peter.each_pair.inject(0) { |pwins, (pvalue, ptimes)|
  pwins + colin.each_pair.select { |cvalue, ctimes|
    pvalue > cvalue
  }.map { |cvalue, ctimes|
    ptimes*ctimes
  }.reduce(:+)
}

puts "%.7f" % Rational(pwins,possibles) # => 0.5731441
