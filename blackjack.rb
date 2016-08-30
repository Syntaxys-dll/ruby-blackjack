require 'rspec'
require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'dealer'

# Game class
class Game
  attr_reader :player, :dealer, :winner

  def initialize
    puts "\n\nNew game started! [̲̅$̲̅(̲̅ ͡° ͜ʖ ͡°̲̅)̲̅$̲̅]\n\n"
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new

    2.times { @player.hit(@deck) }
    2.times { @dealer.hit(@deck) }

    round
  end

  def inspect
    puts '---'
    puts "Player cards #{@player.cards.map(&:to_s)} total: #{@player.cards_value.to_s}"
    puts "Dealer cards #{@dealer.cards.map(&:to_s)} total: #{@dealer.cards_value.to_s}"
    puts '---'
  end

  def round
    answer = ''
    until answer == 'S' || @player.cards_value > 21
      puts inspect
      puts 'Would you like to hit or stand?(H/S):'
      answer = gets.chomp.upcase
      @player.hit(@deck) if answer == 'H'
    end

    until verify_game_end || @dealer.cards_value > 17
      puts 'Dealer gets a card.'
      @dealer.hit(@deck)
    end

    puts 'New game maybe? (Y/N)'
    answer = ''
    until answer == 'Y' || answer == 'N'
      answer = gets.chomp.upcase
      Game.new if answer == 'Y'
      exit if answer == 'N'
    end
  end

  def verify_game_end
    @winner = verify_winner(@player.cards_value, @dealer.cards_value)
    unless @winner.nil?
      puts inspect
      puts "#{@winner} is winner on this time."
      return true
    end
    false
  end

  def verify_winner(player_value, dealer_value)
    return 'No one' if dealer_value == 21 && player_value == 21
    return 'Player' if player_value == 21 || dealer_value > 21
    return 'Dealer' if player_value > 21
    return 'Player' if player_value > dealer_value && dealer_value > 16
    return 'Dealer' if player_value < dealer_value
    nil
  end
end

if ARGV.first == '-start'
  ARGV.clear
  Game.new
end
