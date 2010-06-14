=begin
A common security method used for online banking is to ask the user for three random characters from a passcode.
For example, if the passcode was 531278, they may ask for the 2nd, 3rd, and 5th characters; the expected reply would be: 317.

The text file, keylog.txt, contains fifty successful login attempts.

Given that the three characters are always asked for in order, analyse the file so as to determine the shortest possible secret passcode of unknown length.
=end

require_relative 'lib'

# Using a strategy to find the digit which is always the last

tries = File.read('data/keylog.txt').lines.map { |line| line.to_i.digits }
digits = tries.reduce(:|).sort

puts digits.size.times.with_object([]) { |_,key|
  last_digit = digits.find { |digit|
    tries.all? { |try|
      i = try.rindex(digit)
      i.nil? or i == try.size-1
    }
  }
  break if last_digit.nil?
  key.unshift(last_digit)
  digits >> last_digit
  tries.each { |try| try >> last_digit }
}.join


##### The same, but with the first

tries = File.read('data/keylog.txt').lines.map { |line| line.to_i.digits }
digits = tries.reduce(:|).sort

puts digits.size.times.with_object([]) { |_,key|
  last_digit = digits.find { |digit|
    tries.all? { |try|
      i = try.index(digit)
      i.nil? or i == 0
    }
  }
  break if last_digit.nil?
  key << last_digit
  digits >> last_digit
  tries.each { |try| try >> last_digit }
}.join

