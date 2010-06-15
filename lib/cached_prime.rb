require "prime"

class CachedPrime
  CACHE_FILE = File.expand_path("../cached_prime/data.primes.marshal", __FILE__)
  STEP = 1_000_000
  @@cache = nil
  class << self
    include Enumerable

    def each(*args)
      return to_enum(__method__, *args) unless block_given?
      max = args.size == 1 ? args.first.to_i : Float::INFINITY
      primes = cache
      prime = 0
      primes.each { |pr|
        prime = pr
        break if prime > max
        yield(prime)
      }
      if max > prime
        prime_generator = Prime.each
        until prime == prime_generator.next
        end

        loop {
          primes << prime = prime_generator.next
          break if prime > max
          yield(prime)
        }

        save_cache(primes)
        @@cache = nil
      end
      primes[0...primes.index(prime)]
    end

    def save_cache(primes)
      File.open(CACHE_FILE, "w+") { |fh|
        fh.write(Marshal.dump(primes))
      }
    end

    def cache(max = nil)
      @@cache ||= begin
        Marshal.load(File.read(CACHE_FILE))
      rescue
        save_cache([Prime.first])
        retry
      end
      if !max.nil? and @@cache.last < max
        to = (max/STEP+1).to_i*STEP
        puts "Generating primes up to #{to}"
        @@cache = each(to).to_a
      end
      @@cache
    end
  end
end

Dir[File.join(File.dirname(__FILE__), File.basename(__FILE__, '.rb'), '*.rb')].each { |f| require f }

if __FILE__ == $0
  require "benchmark"

  #p Benchmark.realtime { CachedPrime.each(1_000_000) {} } # To generate
  #exit

  N = 1_000_000
  Benchmark.bm(15) do |results|
    results.report('cached') {
      pp = CachedPrime.each(N).to_a
      p "#{pp.first}, #{pp.last}, #{pp.size}"
    }
    results.report('normal') {
      pp = Prime.each(N).to_a
      p "#{pp.first}, #{pp.last}, #{pp.size}"
    }
  end
end
