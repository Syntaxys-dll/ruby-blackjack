# Player class
class Player
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def hit(deck)
    @cards << deck.cards.shift
    choose_ace_value(@cards.last) if @cards.last.value == 11
  end

  def cards_value
    @cards.reduce(0) { |a, e| a + e.value }
  end

  def choose_ace_value(card)
    puts 'You took an Ace. Count card as 1 or 11? (1/11)'
    card.value = nil
    card.value = gets.to_i until card.value == 1 || card.value == 11
    puts "Card value set to #{card.value}"
  end
end
