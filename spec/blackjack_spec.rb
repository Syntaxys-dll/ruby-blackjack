require './blackjack.rb'

describe Card do
  it 'Should accept suit and value when building.' do
    card = Card.new(:clubs, 10)
    expect(card.suit).to eq(:clubs)
    expect(card.value).to eq(10)
  end

  it 'Should count face cards (kings, queens, and jacks) as ten points.' do
    %w(K Q J).each do |face|
      card = Card.new(:clubs, face)
      expect(card.value).to eq(10)
    end
  end

  it 'Should return 11 value for ace.' do
    card = Card.new(:clubs, 'A')
    expect(card.value).to eq(11)
  end

  it 'Should count not face cards as the numeric value shown on the card.' do
    card = Card.new(:clubs, 4)
    expect(card.value).to eq(4)
    card = Card.new(:clubs, 9)
    expect(card.value).to eq(9)
  end

  it 'have nice view if need' do
    card = Card.new(:clubs, 4)
    expect(card.to_s).to eq('4-clubs')
  end
end

describe Deck do
  it 'New deck should has 52 cards' do
    expect(Deck.new.cards.length).to eq(52)
  end
end

describe Player do
  it 'Should take card from deck.' do
    deck = Deck.new
    player = Player.new
    player.hit(deck)
    expect(player.cards.length).to eq(1)
    player.hit(deck)
    expect(player.cards.length).to eq(2)
  end

  it 'Should count value of cards in hand correctly' do
    deck = double(Deck, cards: [Card.new(:clubs, 10), Card.new(:hearts, 8)])
    player = Player.new
    2.times { player.hit(deck) }
    expect(player.cards_value).to eq(18)
  end
end

describe Dealer do
  it 'Should take card from deck.' do
    deck = Deck.new
    dealer = Dealer.new
    dealer.hit(deck)
    expect(dealer.cards.length).to eq(1)
    dealer.hit(deck)
    expect(dealer.cards.length).to eq(2)
  end

  it 'Should count value of cards in hand correctly' do
    deck = double(Deck, cards: [Card.new(:clubs, 10), Card.new(:hearts, 8)])
    dealer = Dealer.new
    2.times { dealer.hit(deck) }
    expect(dealer.cards_value).to eq(18)
  end
end
