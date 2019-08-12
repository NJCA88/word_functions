require './lexicon'

class SpecialLexicon < Lexicon

  # Generates an array of all the anagrams of the given word
  def get_anagrams(word)
    # FILL ME IN
    sorted_word = word.chars.sort.join
    return @sorted_hash[sorted_word].uniq
  end


  # Generates an array of all the words that have the given word as a prefix
  def get_prefixed_words(prefix)
    # FILL ME IN
    # return [@trie.is_word(prefix)]
    answer = []
    current_node = @trie.root
    # return ['alphabet']

    while prefix.length > 0
      node = current_node.keys[prefix[0]]
      prefix = prefix[1..-1]
      if node
        current_node = node
      else
        return "Sorry, we can't find any words with that prefix"
      end
    end
    #we now have the final letter of the prefix as the current node, I hope.
    print "keys are: ", current_node.keys
    return [current_node.val]


    
  end


  # Generates the shortest possible word ladder connecting the two words
  def get_word_ladder(start_word, end_word)
    # FILL ME IN
    return ['dog', 'cat']
  end
end
