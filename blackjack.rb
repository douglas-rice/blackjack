# Interactive command line blackjack game

def calculate_total(cards)
  # create array with just card values
  arr = cards.map {|e| e[0]}
  total = 0
  arr.each do |value|
    if value == 'J' || value == 'Q' || value == 'K'
      total = total + 10
    # Correct for Aces
    elsif value == 'A'
      if (total + 11) > 21
        total = total + 1
      else
        total = total + 11
      end
    else
      total = total + value.to_i
    end
  end
  return total
end

def display_cards(cards, total)
  cards.each do |e|
    puts "==> #{e}"
  end
  puts "Total: #{total}"
end

# Start game
system 'clear'
puts "Welcome to Blackjack! Enter your name:"
player = gets.chomp
system 'clear'
# Create and shuffle deck
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
suits = ['H', 'D', 'S', 'C']
deck = cards.product(suits)
deck.shuffle!

# Initialize hands for player and dealer
player_cards = []
dealer_cards = []

# Deal 2 cards and show to each player
player_cards << deck.pop
dealer_cards << deck.pop
player_cards << deck.pop
dealer_cards << deck.pop

player_total = calculate_total(player_cards)
dealer_total = calculate_total(dealer_cards)

puts "#{player}'s hand:"
display_cards(player_cards, player_total)

puts ""

puts "Dealer's hand:"
display_cards(dealer_cards, dealer_total)

puts ""

if player_total == 21
  puts "Congratulations, you have blackjack! You win!"
  exit
elsif dealer_total == 21
  puts "Dealer has blackjack! Sorry, you lose."
end

# player hit
while player_total < 21
  puts "Press (1) if you'd like to 'hit', or (2) if you want to 'stay':"
  hit_or_stay = gets.chomp
  if hit_or_stay == '2'
    puts "You chose to stay."
    break
  else
    new_card = deck.pop
    player_cards << new_card
    player_total = calculate_total(player_cards)
    puts "#{player} is dealt a #{new_card}."
    puts "#{player}'s total: #{player_total}"
    puts ""
    puts "Dealer's total: #{dealer_total}"
    if player_total == 21
      puts "Congratulations, you have blackjack! You win!"
      exit
    elsif player_total > 21
      puts "Sorry #{player}, you busted!"
      exit
    else
      puts "#{player}'s hand: #{player_cards}"
      puts ""
    end
  end
end

# Dealer turn

while dealer_total < 17
  new_card = deck.pop
  dealer_cards << new_card
  dealer_total = calculate_total(dealer_cards)
  puts "Dealer is dealt a #{new_card}"
  puts "Dealer's total: #{dealer_total}"
  if dealer_total == 21
    puts "Dealer got blackjack. You lose, #{player}."
    exit
  elsif dealer_total > 21
    puts "Dealer busted! You win, #{player}!"
    exit
  else
    next
  end
end

# Compare player's hand to dealer's hand and determine winner

player_total = calculate_total(player_cards)
dealer_total = calculate_total(dealer_cards)
puts "#{player}'s hand: #{player_cards}"
puts "#{player}'s total: #{player_total}"
puts "Dealer's hand: #{dealer_cards}"
puts "Dealer's total: #{dealer_total}"

if player_total > dealer_total
  puts "Congratulations, you win!"
elsif dealer_total > player_total
  puts "You lose, #{player}!"
else
  puts "Ugh, it's a tie!"
end




