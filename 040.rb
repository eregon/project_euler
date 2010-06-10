# encoding: utf-8

=begin
An irrational decimal fraction is created by concatenating the positive integers:

0.123456789101112131415161718192021...

It can be seen that the 12^(th) digit of the fractional part is 1.

If d_(n) represents the n^(th) digit of the fractional part, find the value of the following expression.

d_(1) × d_(10) × d_(100) × d_(1 000) × d_(10 000) × d_(100 000) × d_(1 000 000)
=end

N = 1_000_000

@my_number = ""

i = -1
until @my_number.size > N
  @my_number << (i += 1).to_s
end

[Fixnum,Bignum].each { |cla|
  cla.class_eval { alias :× :* }
}

def d_(i)
  Integer(@my_number[i])
end

# DSL example !!!
p d_(1).× d_(10).× d_(100).× d_(1_000).× d_(10_000).× d_(100_000).× d_(1_000_000) # => 210






