require_relative '../cached_prime'
require_relative '../array/binary_search'

class Integer
  remove_method :prime?
  def prime?
    CachedPrime.cache.binary_search(self)
  end
end

if __FILE__ == $0
  p 3.prime?
  p 4.prime?
end


