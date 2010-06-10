=begin
The n^(th) term of the sequence of triangle numbers is given by, t_(n) = ½n(n+1); so the first ten triangle numbers are:

1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

By converting each letter in a word to a number corresponding to its alphabetical position and adding these values we form a word value. For example, the word value for SKY is 19 + 11 + 25 = 55 = t_(10). If the word value is a triangle number then we shall call the word a triangle word.

Using words.txt (right click and 'Save Link/Target As...'), a 16K text file containing nearly two-thousand common English words, how many are triangle words?
=end

#t_n = -> n { n*(n+1)/2 }
#(1..10).each { |i| p t_n[i] }

class Integer
  @@triangle_numbers = [1]
  
  def expand_triangles_numbers
    n = @@triangle_numbers.size
    @@triangle_numbers << (n*(n+1)>>1)
    # We have to move the 1/2 at the end if we want to avoid integer division.
    # odd*even is always even, so dividing by 2 after is safe
  end
  
  def triangle_number?
    expand_triangles_numbers until @@triangle_numbers[-1] >= self
    @@triangle_numbers.include?(self)
  end
end

class String
  def value
    chars.inject(0) { |value, char| value + (char.ord - 'A'.ord + 1) }
  end
end

p IO.read('data/words.txt').split(/"|","/).tap(&:shift).count { |word|
  word.value.triangle_number?
} # => 162

