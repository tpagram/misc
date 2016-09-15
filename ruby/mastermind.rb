class Mastermind
	def initialize(colours, turns, code_length)
		#Generate secret code
		@code = Array.new(4).map{rand(1..colours)}
		@code_length = code_length
		@turns = turns
	end

	#Start game
	def start
		#puts "Debug! code is: #{@code}"
		@turns.times do |turn|
			print "Guess #{turn+1}: "
			guess = gets.chomp.split("").map{|a| a.to_i}
			if guess.length != @code_length || guess.any? {|x| x > 6 || x < 0}
				puts "Invalid input, try again:"
				redo
			elsif guess == @code
				puts "Correct! Good job."
				break
			else
				in_place = 0
				out_of_place = 0
				guess_matches = Array.new(@code_length,false)
				code_matches = Array.new(@code_length,false)
				@code_length.times do |i|
					if guess[i] == @code[i]
						in_place += 1
						guess_matches[i], code_matches[i] = true, true
					end
				end
				@code_length.times do |i|
					@code_length.times do |j|
						if !guess_matches[i] && !code_matches[j] && (guess[i] == @code[j])
							out_of_place += 1
							guess_matches[i], code_matches[j] = true, true
						end
					end
				end
				print "Go fish!" if in_place == 0 && out_of_place == 0
				in_place.times {print "O"}
				out_of_place.times {print "X"}
				print "\n"
				puts "Sorry, no more guesses. The answer was #{@code}" if turn + 1 == @turns 
			end
		end
	end

end

puts "Welcome to Mastermind!

I am going to generate a secret code: four numbers between 1 and 6 in a specific order.
Type a guess in the format 'xxxx', where x is a number between 1 and 6.

I will respond to your guess: O means a correct number in the correct position and X 
means a correct number in the wrong position.

You have 12 turns to guess. Good luck!\n\n"
game_instance = Mastermind.new(6,12,4)
game_instance.start()

	 