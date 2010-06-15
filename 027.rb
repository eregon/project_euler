=begin
Euler published the remarkable quadratic formula:

n² + n + 41

It turns out that the formula will produce 40 primes for the consecutive values n = 0 to 39. However, when n = 40, 40^(2) + 40 + 41 = 40(40 + 1) + 41 is divisible by 41, and certainly when n = 41, 41² + 41 + 41 is clearly divisible by 41.

Using computers, the incredible formula  n² − 79n + 1601 was discovered, which produces 80 primes for the consecutive values n = 0 to 79. The product of the coefficients, −79 and 1601, is −126479.

Considering quadratics of the form:

    n² + an + b, where |a| < 1000 and |b| < 1000

    where |n| is the modulus/absolute value of n
    e.g. |11| = 11 and |−4| = 4

Find the product of the coefficients, a and b, for the quadratic expression that produces the maximum number of primes for consecutive values of n, starting with n = 0.
=end

require_relative 'lib/cached_prime'

def number_of_primes(a, b)
  #equation = -> a, b, n { n**2 + a*n + b }
  n = 0
  #while equation[a,b,n].prime?
  while (n**2 + a*n + b).prime?
    n += 1
  end
  n-1
end

p number_of_primes(1, 41) == 39
p number_of_primes(-79, 1601) == 79

a, b, primes = (-999..999).map { |a|
  p a if a%100 == 0
  best_b = (-999..999).max_by { |b|
    number_of_primes(a, b)
  }
  [a, best_b, number_of_primes(a, best_b)]
}.max_by(&:last)
p [a, b, primes]
p a*b
__END__
[-61, 971, 70]
-59231

40s => 28s

