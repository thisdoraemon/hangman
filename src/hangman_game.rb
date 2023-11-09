class HangmanGame
  def initialize
    @game_word = random_word
    @game_letters = @game_word.chars
    @guessed_letters = []
    @word_list = ["serendipity", "ephemeral", "kaleidoscope", "nostalgia", "euphony", "serene", "elegy", "whimsical", "labyrinth", "royality"]
    @turns = 7
  end

  def play
    puts "Welcome to Hangman, where I, the computer, am the champion of words"
    puts "Guess a letter, if you dare"

    loop do
      render

      guess = gets.chomp.downcase
      handle_guess(guess)

      if won?
        reveal_word
        congratulations
        puts ""
        break
      elsif lost?
        puts ""
        lost
        break
      end
    end
  end

  def handle_guess(guess)
    if guessed_letters.include?(guess)
      puts "You have already guessed the letter #{guess} silly mortal"
    else
      guessed_letters << guess

      if game_letters.include?(guess)
        puts "Yes, this word does not include #{guess}, but you shall not defeat me"
      else
        @turns -= 1
        puts "Fool, this word does not contain your worthless letter #{guess}. You have #{@turns} guesses left"
      end
    end
  end

  def render
    puts <<~EOF
    _____
    |    #{@turns < 7 ? '|' : ' '}
    |    #{@turns < 6 ? 'O' : ' '}
    |   #{!won? && (@turns < 2 || !have_lives?) ? '/' : ' '}#{@turns < 5 ? '|' : ' '}#{!won? && @turns == 1 ? '\\' : ' '}
    |   #{!won? && @turns < 4 ? '/' : ' '}#{!won? && @turns < 3 ? '\\' : ' '}
    |
    ===
    EOF

    game_letters.each do |letter|
      puts "#{guessed_letters.include?(letter) ? letter : '__'} "
    end
  end

  def won?
    @game_letters - @guessed_letters == []
  end

  def lost?
    @turns < 1
  end

  def have_lives?
    @turns > 1
  end

  def reveal_word
    puts @game_word
  end

  def congratulations
    puts "You are victorious human For now..."
    puts "The word was in fact #{@game_word}"
  end

  def random_word
    if @word_list.nil?
      puts "Error! No words to play"
      exit!
    end
    @game_word = @word_list.sample
  end
end