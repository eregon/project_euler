max_i = max_n = 0
for n in (1..1000000)
  i = 1
  n_copy = n
  until n == 1
    n = n.even? ? n/2 : 3*n + 1 # With n%2==0: 21.6s,with (n%2).zero?: 24.6s
    i += 1
    if i > max_i
      max_i = i
      max_n = n_copy
    end
  end
end

print(max_n) # => 837799, 21.1s
