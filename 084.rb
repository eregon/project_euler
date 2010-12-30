=begin
In the game, Monopoly, the standard board is set up in the following way:
GO   A1   CC1   A2   T1   R1   B1   CH1   B2   B3   JAIL
H2                                                  C1
T2                                                  U1
H1                                                  C2
CH3                                                 C3
R4                                                  R2
G3                                                  D1
CC3                                                 CC2
G2                                                  D2
G1                                                  D3
G2J   F3   U2   F2   F1   R3   E3   E2   CH2   E1   FP

A player starts on the GO square and adds the scores on two 6-sided dice to determine the number of squares they advance in a clockwise direction. Without any further rules we would expect to visit each square with equal probability: 2.5%. However, landing on G2J (Go To Jail), CC (community chest), and CH (chance) changes this distribution.

In addition to G2J, and one card from each of CC and CH, that orders the player to go directly to jail, if a player rolls three consecutive doubles, they do not advance the result of their 3rd roll. Instead they proceed directly to jail.

At the beginning of the game, the CC and CH cards are shuffled. When a player lands on CC or CH they take a card from the top of the respective pile and, after following the instructions, it is returned to the bottom of the pile. There are sixteen cards in each pile, but for the purpose of this problem we are only concerned with cards that order a movement; any instruction not concerned with movement will be ignored and the player will remain on the CC/CH square.

    Community Chest (2/16 cards):
        Advance to GO
        Go to JAIL
    Chance (10/16 cards):
        Advance to GO
        Go to JAIL
        Go to C1
        Go to E3
        Go to H2
        Go to R1
        Go to next R (railway company)
        Go to next R
        Go to next U (utility company)
        Go back 3 squares.

The heart of this problem concerns the likelihood of visiting a particular square. That is, the probability of finishing at that square after a roll. For this reason it should be clear that, with the exception of G2J for which the probability of finishing on it is zero, the CH squares will have the lowest probabilities, as 5/8 request a movement to another square, and it is the final square that the player finishes at on each roll that we are interested in. We shall make no distinction between "Just Visiting" and being sent to JAIL, and we shall also ignore the rule about requiring a double to "get out of jail", assuming that they pay to get out on their next turn.

By starting at GO and numbering the squares sequentially from 00 to 39 we can concatenate these two-digit numbers to produce strings that correspond with sets of squares.

Statistically it can be shown that the three most popular squares, in order, are JAIL (6.24%) = Square 10, E3 (3.18%) = Square 24, and GO (3.09%) = Square 00. So these three most popular squares can be listed with the six-digit modal string: 102400.

If, instead of using two 6-sided dice, two 4-sided dice are used, find the six-digit modal string.
=end

BOARD = <<BOARD.lines.map(&:split)
GO  A1  CC1  A2  T1  R1  B1  CH1  B2  B3  JAIL
H2                                        C1
T2                                        U1
H1                                        C2
CH3                                       C3
R4                                        R2
G3                                        D1
CC3                                       CC2
G2                                        D2
G1                                        D3
G2J  F3  U2  F2  F1  R3  E3  E2  CH2  E1  FP
BOARD

class Array
  def with_index(&block)
    i = -1; map { |e| i+=1; yield(e,i) }
  end unless method_defined? :with_index
end

module Monopoly
  PROPERTIES = BOARD[0] + BOARD[1...-1].map(&:last) + BOARD[-1].reverse + BOARD[1...-1].map(&:first).reverse
  RAILWAY_COMPANIES = PROPERTIES.grep(/^R/).map { |r| PROPERTIES.index(r) }
  UTILITY_COMPANIES = PROPERTIES.grep(/^U/).map { |r| PROPERTIES.index(r) }
  BOARD_SIZE = PROPERTIES.size
  PROPERTIES_NAME2POS = Hash[PROPERTIES.map.with_index { |p,i| [p.to_sym,i] }]

  def const_missing(name)
    PROPERTIES_NAME2POS[name] or super
  end

  class Property
    extend Monopoly
    attr_reader :name, :position, :count
    def initialize(name, position)
      @name, @position = name, position
      @count = 0
      @send_to = case name
      when /^CC/ then lambda { |pos| [GO, JAIL][rand 16] }
      when /^CH/ then
        lambda do |pos|
          next_railway_company = RAILWAY_COMPANIES.find(lambda { RAILWAY_COMPANIES.first }) { |r| r > pos }
          next_utility_company = UTILITY_COMPANIES.find(lambda { UTILITY_COMPANIES.first }) { |u| u > pos }
          [GO, JAIL, C1, E3, H2, R1, next_railway_company, next_railway_company,
            next_utility_company, (pos-3)%BOARD_SIZE][rand 16]
        end
      when 'G2J' then lambda { |_| JAIL }
      end
    end

    def land
      next_pos = @send_to && @send_to.call(@position)
      @count += 1 unless next_pos
      next_pos
    end
  end

  class Board
    extend Monopoly
    def initialize
      @properties = PROPERTIES.map.with_index { |name, pos|
        Property.new(name, pos)
      }
      @doubles = 0
    end

    def roll
      dice1, dice2 = rand(4) + 1, rand(4) + 1
      if dice1 == dice2
        @doubles += 1
      else
        @doubles = 0
      end
      dice1 + dice2
    end

    def simulate(moves)
      position = GO
      moves.times do
        position += roll
        position %= BOARD_SIZE
        if @doubles == 3
          @doubles = 0
          @properties[position = JAIL].land
        else
          while new_position = @properties[position].land
            position = new_position
          end
        end
      end
    end

    def results
      results = @properties.sort_by(&:count).reverse
      all = @properties.map(&:count).reduce(:+)
      #puts results.map { |property|
      #  "#{property.count} #{property.name}"
      #}.join(', ')

      puts results.map { |property|
        "#{"%.2f" % (property.count*100.0/all)}% #{property.name}"
      }
      results
    end
  end
end

game = Monopoly::Board.new
profiling = $".find { |f| File.basename(f) == 'profile.rb' }
game.simulate(profiling ? 2_000 : 1_000_000)

results = game.results
puts "modal string:"
puts results[0...3].map { |p| "%.2d" % p.position }.join
# => 200_000 with 2d6: 102400, 0.33 (org: 1.13)
# => 600_000 with 2d6: 102400, 0.91

# => 600_000 with 2d4: 101524, 0.89
# => 1_000_000 with 2d4: 101524, 1.48 (1.8.7: 5.3)
