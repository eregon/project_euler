=begin
In England the currency is made up of pound, £, and pence, p, and there are eight coins in general circulation:

    1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).

It is possible to make £2 in the following way:

    1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p

How many different ways can £2 be made using any number of coins?
=end

coins = [1, 2, 5, 10, 20, 50, 100, 200]

# 200 is made wih 1*200
# 100 is 100 or 50+2*20+10
# 50  is 50  or 20*2+10

1.upto(100) { |n|
  p coins.repeated_combination(n).to_a
}
