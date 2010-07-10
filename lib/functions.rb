# encoding: utf-8

# Euler's totient function
def φ(n)
  n.prime_factors.inject(n) { |product, (factor, pow)| product * (factor-1) / factor }.to_i
end

def rad(n)
  return 1 if n == 1
  n.prime_factors.map(&:first).reduce(:*)
end
