# Dealer class
class Dealer
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
    puts 'Dealer took an Ace.'
    card.value = 11 if self.cards_value > 11
    card.value = 1 if self.cards_value < 11
    puts "Card value set to #{card.value}"
  end
end
