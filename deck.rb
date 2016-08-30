# Deck class
class Deck
  attr_reader :cards

  def initialize
    @cards = Deck.build_cards
  end

  def self.build_cards
    cards = []
    [:clubs, :spades, :hearts, :diamonds].each do |suit|
      (2..10).each do |number|
        cards << Card.new(suit, number)
      end

      %w(K Q J A).each do |facecard|
        cards << Card.new(suit, facecard)
      end
    end

    cards.shuffle
  end
end
