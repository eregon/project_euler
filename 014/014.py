max_i = max_n = 0
for n in xrange(1, 1000000):
  i = 1
  n_copy = n
  while n != 1:
    if n%2==0:
      n = n/2
    else:
      n = 3*n + 1
    i += 1
  if i > max_i:
    max_i = i
    max_n = n_copy

print max_n # => 837799, 90s!!!
