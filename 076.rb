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

# P(n) partition function
# Euler's recurrence equation (http://mathworld.wolfram.com/PartitionFunctionP.html)

P = Hash.new { |h,n| # Easiest cache ever !
  h[n] = if n < 0
    0
  elsif n == 0
    1
  else
    (1..n).inject(0) { |sum, k|
      sum + (-1)**(k+1) * (P[n - k*(3*k-1)/2] + P[n - k*(3*k+1)/2])
    }
  end
}

def ways_for(n)
  P[n] - 1 # remove [n]
end

# 1: 1 => 0
# 2: 1+1 => 1
# 3: 1+1+1, 2+1 => 2
# 4: 1+1+1+1, 2+1+1, 2+2, 3+1 => 4
# 5 => 6

p ways_for(100) # 0.03s
