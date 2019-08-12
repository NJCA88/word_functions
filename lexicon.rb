class Lexicon

  def initialize
    # The full array of all words
    @array = []
    # A hash containing all the words as keys
    @hash = {}
    @sorted_hash={}

    file = File.new('words.txt', 'r')
    while (line = file.gets)
      line.strip!.downcase!
      @array.push line
      @hash[line] = true
      sorted_string = line.chars.sort.join
      if @sorted_hash[sorted_string]
        @sorted_hash[sorted_string].push(line)
      else
        @sorted_hash[sorted_string] = [sorted_string]
      end

         
    end
    file.close
  end


  # Returns true if the given word is in the lexicon
  def is_word?(word)
    return @hash.has_key?(word.downcase)
  end
end
