class Integer
  def palindrome?(base = 10)
    s = to_s(base) and s == s.reverse
  end
end
