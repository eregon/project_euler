=begin
The cube, 41063625 (345^(3)), can be permuted to produce two other cubes: 56623104 (384^(3)) and 66430125 (405^(3)). In fact, 41063625 is the smallest cube which has exactly three permutations of its digits which are also cube.

Find the smallest cube for which exactly five permutations of its digits are cube.
=end

require_relative 'lib'

p (10**8..5*10**8).find { |n|
  p n if n%10_000 == 0
  cubes = []
  n.digits.permutation(n.ndigits).count { |digits|
    if cube = digits.to_i and !cubes.include?(cube) and Math.cbrt(cube).integer?
      cubes << cube
    end
  } == 5
}
