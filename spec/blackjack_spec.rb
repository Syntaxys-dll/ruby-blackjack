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

describe Game do
  it 'Should be 2 cards at palyer and 2 cards at dealer' do
    expect(Game.new.player.cards.length).to eq(2)
    expect(Game.new.dealer.cards.length).to eq(2)
  end

  describe 'verify_winner function check when' do
    it 'get 21 points on the players first two cards, without a dealer blackjack.' do
      expect(Game.new.verify_winner(21, 17)).to eq('Player')
    end

    it 'player reach a final score higher than the dealer without exceeding 21' do
      expect(Game.new.verify_winner(21, 17)).to eq('Player')
    end

    it 'player scoring higher than 21' do
      expect(Game.new.verify_winner(23, 12)).to eq('Dealer')
    end

    it 'dealer scoring higher than 21' do
      expect(Game.new.verify_winner(13, 22)).to eq('Player')
    end

    it 'players win by not busting and having a total higher than the dealers.' do
      expect(Game.new.verify_winner(19, 18)).to eq('Player')
    end

    it 'player and dealer have the same total, this is called a "push", no winner' do
      expect(Game.new.verify_winner(21, 21)).to eq('No one')
    end

  end
end
