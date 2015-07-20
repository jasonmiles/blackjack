number_cards = ["Two","Three","Four","Five","Six","Seven","Eight","Nine"]
face_cards = ["Ten","Jack","Queen","King","Ace"]
suits = ["spades", "hearts", "clubs", "diamonds"]
deck = []
player_hand = []
dealer_hand = []
active_player = "player"
answer = ""
both_stay = false
player_name = ""

def populate_deck(deck, number_cards, face_cards, suits)
  4.times do |i|
    8.times do |x|
      hash = {:name => number_cards[x], :value => x + 1, :suit => suits[i]}
      deck.push(hash)
    end
    5.times do |x|
      hash = {:name => face_cards[x], :value => 10, :suit => suits[i]}
      deck.push(hash)
   end
  end
end

def deal(deck, hand)
  current_card = deck.sample 
  hand.push(current_card)
  deck.delete(current_card)
end

def hand_value(hand)
  total_value = 0
  hand.each do |i|
    total_value += i[:value]
  end
  total_value
end

def game_end(player_hand, dealer_hand, both_stay, player_name)
  if hand_value(player_hand) == 21 && player_hand.count == 2 
    puts "Blackjack! #{player_name} wins!"
  elsif hand_value(dealer_hand) == 21 && dealer_hand.count == 2
    puts "Blackjack! Dealer wins!"
  elsif hand_value(player_hand) > 21
    puts "#{player_name} is bust. Dealer wins."
  elsif hand_value(dealer_hand) > 21
    puts "Dealer is bust. #{player_name} wins!"
  elsif both_stay  
    if hand_value(dealer_hand) > hand_value(player_hand)
      puts "Dealer has #{hand_value(dealer_hand)} and #{player_name} has #{hand_value(player_hand)}. Dealer wins!"
    elsif hand_value(dealer_hand) < hand_value(player_hand)
      puts "#{player_name} has #{hand_value(player_hand)} and #{player_name} has #{hand_value(dealer_hand)}. #{player_name} wins!"
    elsif hand_value(dealer_hand) == hand_value(player_hand)  
      puts "Dealer and #{player_name} both have #{hand_value(player_hand)}. It's a tie!"
    end
  else
    false
  end
end

def print_hands(dealer_hand, player_hand, player_name)
  puts "----------BlackJack--------------"
  puts "<===Dealer's Hand:===>"
  dealer_hand.each do |card|
    puts "#{card[:name]} of #{card[:suit].capitalize}"
  end
  puts "======================="
  puts "Total value: #{hand_value(dealer_hand)}"
  puts "======================="
  puts "<===#{player_name}'s Hand:===>"
  player_hand.each do |card|
    puts "#{card[:name]} of #{card[:suit].capitalize}"
  end
  puts "======================="
  puts "Total value: #{hand_value(player_hand)}"
  puts "======================="
end

populate_deck(deck, number_cards, face_cards, suits)
deal(deck, dealer_hand)
2.times do 
  deal(deck, player_hand)
end

puts "Please enter your name:"
player_name = gets.chomp!.capitalize

while true
  if game_end(player_hand, dealer_hand, both_stay, player_name) == false 
    system ("clear")
    print_hands(dealer_hand, player_hand, player_name)
    if active_player == "player"     
      while hand_value(player_hand) < 21
        puts "Hit or stay?"
        answer = gets.chomp!
        if answer == "hit"
          deal(deck, player_hand)
          system ("clear")
          print_hands(dealer_hand, player_hand, player_name)
        elsif answer == "stay"
          active_player = "dealer"
          break
        end
      end
    elsif active_player == "dealer"
      while true
        if hand_value(dealer_hand) < 17
          deal(deck, dealer_hand)
        else
          both_stay = true
          break
        end
      end
    end
  else
    system ("clear")
    print_hands(dealer_hand, player_hand, player_name)
    puts game_end(player_hand, dealer_hand, both_stay, player_name)
    puts "Would you like to play again? y/n"
    answer = gets.chomp!
    if answer == "y"
      dealer_hand = []
      player_hand = []
      deck = []
      both_stay = false
      populate_deck(deck, number_cards, face_cards, suits)
      deal(deck, dealer_hand)
      2.times do 
        deal(deck, player_hand)
      end
      active_player = "player"
    elsif answer == 'n'
      exit
    end
  end
end

