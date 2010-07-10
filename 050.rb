# encoding: utf-8
=begin
The prime 41, can be written as the sum of six consecutive primes:
41 = 2 + 3 + 5 + 7 + 11 + 13

This is the longest sum of consecutive primes that adds to a prime below one-hundred.

The longest sum of consecutive primes below one-thousand that adds to a prime, contains 21 terms, and is equal to 953.

Which prime, below one-million, can be written as the sum of the most consecutive primes?
=end

require_relative 'lib'

limit = 1_000_000
primes = CachedPrime.each(limit).to_a

# From http://pamgau.net/item/720

s, record = 0, 0 # s:部分和, record:部分和の要素数
# record の初期値決定
while s < limit
  s += primes[record]
  record += 1
end
record += 1 if record.even? # 奇数にしておく

# 真の record を探索
loop do
  s, i = 0, 0 # s:部分和, i:部分和の初項インデックス
  while (s = primes[i...(i+record)].reduce(:+)) < limit
    if primes.include? s # 部分和:sが素数であるか
      puts s # => 997651 # 探索完了
      exit
    end
    i += 1
  end
  record -= 2 # record を減算してリトライ
end

