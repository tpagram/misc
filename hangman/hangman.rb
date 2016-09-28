class Hangman

	def initialize(num_guesses)
		@num_guesses = num_guesses
		@word = select_word(5,12)
		@previous_guesses = []
		@incorrect_guesses = 0
		@unveiled_word = Array.new(@word.length,"_")
	end

	#Main menu
	def self.handle
		puts "Welcome to Hangman!\n\n"\
		"I'm going to think of a secret word, and I want you to guess it a letter at\n"\
		"a time. Careful though, you only have 10 guesses.\n\n"\
		"Type 'start' to begin, or 'load' to load a saved game. 'quit' quits at any\n"\
		"time. Type 'save' during a game to save.\n\n"\

		while (true)
			print ">"
			input = gets.chomp
			if input == "start" then puts; Hangman.new(10).start
			elsif input == "load" then load_game
			elsif input == "quit" then exit
			else
				puts "Invalid option. Type 'start' to start a game, 'load' to load a game or 'quit' to quit.n"
				next
			end
			puts "\nType 'start' to start a game, 'load' to load a game or 'quit' to quit."
		end 
	end

	def start
		while @incorrect_guesses != @num_guesses
			puts "\n" + @unveiled_word.join(" ") + "    " + @previous_guesses.join(" ") + \
					"    " + "#{@num_guesses - @incorrect_guesses} guesses remaining"
			print ">"
			letter = gets.chomp.downcase
			if letter == "save" then save_game; redo
			elsif letter == "quit" then exit
			elsif letter.length != 1 || !(letter =~ /[a-z]/)
				puts "Invalid guess. Try again."
				redo
			elsif @previous_guesses.include?(letter) 
				puts "You've guessed that letter already. Have another shot :)"
				redo
			end
			@previous_guesses << letter
			if !@word.include?(letter) 
				@incorrect_guesses += 1
				next
			end
			@word.length.times {|i| @unveiled_word[i] = letter if @word[i] == letter}
			if !@unveiled_word.include?('_')
				puts "Correct! The word was: " + @word
				break
			end
		end
		puts "Sorry, your guesses are up. The word was: " + @word if @unveiled_word.include?('_')
	end

	def self.load_game
		saves = Dir.entries('saves').select {|f| !File.directory? f}
		if saves.empty? then 
			puts "No saves found."
			return
		end
		puts "Which save? You have: #{saves.join(", ")}"
		print ">"
		file = gets.chomp
		if !saves.include? file 
			puts "No such file."
			return
		end 
		begin 
			Marshal.load(File.read('saves/' + file)).start
		rescue
			puts "That's not a valid save file."
			return
		end
	end

	def save_game
		saves = Dir.entries('saves').select {|f| !File.directory? f}
		puts "What would you like to call your save?"
		print ">"
		while (saves.include? file = gets.chomp)
			puts "Sorry, that name is taken."
			print ">"
		end
		begin 
			File.write('saves/' + file, Marshal.dump(self))
		rescue
			puts "Error saving your game. Sorry :("
			return
		end
	end

	def select_word(min_length, max_length)
		words = File.readlines("dictionary5.txt")
		word = ""
		while word.length > max_length || word.length < min_length
			word = words.sample.strip.downcase
		end
		return word
	end
end

Hangman.handle()
