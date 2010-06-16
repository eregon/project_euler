=begin
In the card game poker, a hand consists of five cards and are ranked, from lowest to highest, in the following way:

    * High Card: Highest value card.
    * One Pair: Two cards of the same value.
    * Two Pairs: Two different pairs.
    * Three of a Kind: Three cards of the same value.
    * Straight: All cards are consecutive values.
    * Flush: All cards of the same suit.
    * Full House: Three of a kind and a pair.
    * Four of a Kind: Four cards of the same value.
    * Straight Flush: All cards are consecutive values of same suit.
    * Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.

The cards are valued in the order:
2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.

If two players have the same ranked hands then the rank made up of the highest value wins; for example, a pair of eights beats a pair of fives (see example 1 below). But if two ranks tie, for example, both players have a pair of queens, then highest cards in each hand are compared (see example 4 below); if the highest cards tie then the next highest cards are compared, and so on.

[The examples are in the tests below]

The file, poker.txt, contains one-thousand random hands dealt to two players. Each line of the file contains ten cards (separated by a single space): the first five are Player 1's cards and the last five are Player 2's cards. You can assume that all hands are valid (no invalid characters or repeated cards), each player's hand is in no specific order, and in each hand there is a clear winner.

How many hands does Player 1 win?
=end

class Card
  NAMES = (('2'..'9').to_a + %w[T J Q K A]).each_with_index.with_object({}) { |(name, i), names| names[name] = i+2 }
  COLORS = %w[spade heart diamond club].each_with_object({}) { |name, colors| colors[name[0].upcase] = name.to_sym }
  attr_reader :value, :color
  def initialize(value, color)
    @value = Integer === value ? value : NAMES[value]
    @color = Symbol === color ? color : COLORS[color]
  end

  include Comparable
  def <=> other
    @value <=> other.value
  end

  def == other
    case other
    when Integer
      @value == other
    when Card
      @value == other.value
    end
  end

  def succ
    Card.new(@value+1, @color)
  end
  def + n
    Card.new(@value+n, @color)
  end
end

class Array
  include Comparable
  def <=> other
    each_index { |i|
      if self[i] != other[i]
        return self[i] > other[i] ? +1 : -1
      end
    }
    0
  end

  def return
    self if all?
  end
end

class Proc
  def [](obj)
    obj.instance_exec(&self)
  end
end

class Hand < Array
  def initialize(cards)
    super(cards)
  end

  def values
    map(&:value)
  end

  def uvalues
    values.uniq
  end

  def nvalues
    uvalues.size
  end
end

class Game
  HANDS = {
    royal_flush: -> {
      HANDS[:straight][self] == 14 and HANDS[:flush][self]
    },
    straight_flush: -> {
      HANDS[:flush][self] and HANDS[:straight][self]
    },
    four_of_a_kind: -> {
      find { |v| count(v) == 4 }
    },
    full_house: ->  {
      [find { |v| count(v) == 3 }, find { |v| count(v) == 2 }].return
    },
    flush: -> {
      all? { |card| card.color == first.color } and sample.color
    },
    straight: -> {
      sort == (min...min+5).to_a and max
    },
    three_of_a_kind: -> {
      find { |v| count(v) == 3 }
    },
    two_pairs: -> {
      [high = sort.reverse.find { |v| count(v) == 2 },
        find { |v| v != high and count(v) == 2 }].return
    },
    one_pair: -> {
      find { |v| count(v) == 2 }
    },
    high_card: -> {
      max
    }
  }

  attr_reader :cards
  def initialize(player1cards, player2cards)
    @cards = {p1: Hand.new(player1cards), p2: Hand.new(player2cards)}
  end

  def result(player)
    HANDS.each_pair { |key, hand|
      value = hand[@cards[player]]
      break [key, value] if value
    }
  end

  def winner
    hands = @cards.each_key.map { |player| result(player) }.map { |hand, value| [-HANDS.keys.index(hand), value] }
    if hands.reduce(:!=)
      hands.first > hands.last ? :player1 : :player2
    else
      pcards = @cards.each_key.map { |key| @cards[key].sort.reverse }
      pcards.first == pcards.max ? :player1 : :player2
    end
  end
end

p IO.read('data/poker.txt').lines.map { |line|
  Game.new(*line.split.each_slice(5).map { |pairs|
    pairs.map { |pair| Card.new(*pair.chars) }
  })
}.count { |game| game.winner == :player1 } # => 376

require "test/unit"

class TestPoker < Test::Unit::TestCase
  def game(line)
    @game = Game.new(*line.split.each_slice(5).map { |pairs|
      pairs.map { |pair| Card.new(*pair.chars) }
    })
  end

  def test_basic
    game "TH JC QS KS AD 2C 3S 7S 7D TD"
    assert_equal [:straight, 14], @game.result(:p1)
    assert_equal [:one_pair, 7], @game.result(:p2)
    assert_equal :player1, @game.winner

    game "TH JH QH KH AH 2S 3S 4S 6S 5S"
    assert_equal [:royal_flush, :heart], @game.result(:p1)
    assert_equal [:straight_flush, 6], @game.result(:p2)
    assert_equal :player1, @game.winner

    game "QH QS QC QD AH 2S 2H 4S 4D 5S"
    assert_equal [:four_of_a_kind, 12], @game.result(:p1)
    assert_equal [:two_pairs, [4,2]], @game.result(:p2)
    assert_equal :player1, @game.winner
  end

  def test_pairs
    game "4H 4S 2C 3D AH 2S 2H 4S 4D 5S"
    assert_equal [:one_pair, 4], @game.result(:p1)
    assert_equal [:two_pairs, [4,2]], @game.result(:p2)
    assert_equal :player2, @game.winner

    game "4H 4S 3C 3D AH 2S 2H 4S 4D 5S"
    assert_equal [:two_pairs, [4,3]], @game.result(:p1)
    assert_equal [:two_pairs, [4,2]], @game.result(:p2)
    assert_equal :player1, @game.winner
  end

  def test_basic_1
    game "5H 5C 6S 7S KD 2C 3S 8S 8D TD"
    assert_equal [:one_pair, 5], @game.result(:p1)
    assert_equal [:one_pair, 8], @game.result(:p2)
    assert_equal :player2, @game.winner
  end

  def test_basic_2
    game "5D 8C 9S JS AC 2C 5C 7D 8S QH"
    assert_equal [:high_card, 14], @game.result(:p1)
    assert_equal [:high_card, 12], @game.result(:p2)
    assert_equal :player1, @game.winner
  end

  def test_basic_3
    game "2D 9C AS AH AC 3D 6D 7D TD QD"
    assert_equal [:three_of_a_kind, 14], @game.result(:p1)
    assert_equal [:flush, :diamond], @game.result(:p2)
    assert_equal :player2, @game.winner
  end

  def test_basic_4
    game "4D 6S 9H QH QC 3D 6D 7H QD QS"
    assert_equal [:one_pair, 12], @game.result(:p1)
    assert_equal [:one_pair, 12], @game.result(:p2)
    assert_equal :player1, @game.winner
  end

  def test_basic_5
    game "2H 2D 4C 4D 4S 3C 3D 3S 9S 9D"
    assert_equal [:full_house, [4, 2]], @game.result(:p1)
    assert_equal [:full_house, [3, 9]], @game.result(:p2)
    assert_equal :player1, @game.winner
  end

  def test_basic_full_house
    game "2H 2D 4C 4D 4S 4C 4D 4S 9S 9D"
    assert_equal [:full_house, [4, 2]], @game.result(:p1)
    assert_equal [:full_house, [4, 9]], @game.result(:p2)
    assert_equal :player2, @game.winner
  end

  def test_25
    game "6D 7C 5D 5H 3S 5C JC 2H 5S 3D"
    assert_equal [:one_pair, 5], @game.result(:p1)
    assert_equal [:one_pair, 5], @game.result(:p2)
    assert_equal :player2, @game.winner
  end
end


