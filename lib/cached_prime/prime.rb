require_relative '../array/binary_search'
require "prime"

unless @integer_prime == :stdlib
  class Integer
    remove_method :prime?
    def prime?
      CachedPrime.cache(self).binary_search_iterative(self)
    end
  end
end

if __FILE__ == $0
  require_relative '../cached_prime'
  p 3.prime?
  p 4.prime?
end


