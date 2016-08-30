# Card class
class Card
  attr_reader :suit
  attr_accessor :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def value
    return 10 if %w(K Q J).include? @value
    return 11 if @value == 'A'
    @value
  end

  def to_s
    "#{@value}-#{suit}"
  end
end
