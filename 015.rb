# Starting in the top left corner of a 2×2 grid,
#  there are 6 routes (without backtracking) to the bottom right corner.
# How many routes are there through a 20×20 grid?
SIZE = 2#0
routes_length = SIZE*2

require_relative '../_class/math/point'

start = Point.new(0,0)


