=begin
It is possible to write five as a sum in exactly six different ways:

4 + 1
3 + 2
3 + 1 + 1
2 + 2 + 1
2 + 1 + 1 + 1
1 + 1 + 1 + 1 + 1

How many different ways can one hundred be written as a sum of at least two positive integers?
=end

# From http://d.hatena.ne.jp/htz/20090304/1236177176
def solv(coins, pence)
  @solv_cache ||= {}
  return 1 if coins.size == 1
  @solv_cache[[coins.size, pence]] ||= begin
    coins = coins.dup
    first_coin = coins.shift
    (0..pence/first_coin).inject(0) { |count, i|
      count + solv(coins, pence - i*first_coin)
    }
  end
end
p solv((1..99).to_a, 100) # => WRONG: 1642992565
