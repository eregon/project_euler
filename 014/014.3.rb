$calc = {}

def f(n, i = 1, original = n)
  if n == 1
    $calc[original] = i
    return i
  elsif $calc.key? n
    i += $calc[n]-1
    $calc[original] = i
    return i
  elsif n.even?
    n /= 2
  else
    n = 3*n+1
  end
  f(n, i + 1, original)
end

p (2..1000000).max_by { |i| f(i) }

# p f(1)
# p f(40)
# p f(13)
# p f(40)
