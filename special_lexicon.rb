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
    prefix_copy = prefix[0...-1]
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
    #we now have the final letter of the prefix as the current node.
    print "keys are: ", current_node.keys

    # dfs current_node.keys, calling it on current_node without the final letter of the prefix
    answer = dfs(current_node, prefix_copy)
    return answer.flatten
  end

  def dfs(node, prefix)
    prefix = prefix + node.val
    if node.keys.length == 0
      return [prefix]
    end

    return node.keys.map {|key, value|
    dfs(node.keys[key], prefix)
   }

  end


  # Generates the shortest possible word ladder connecting the two words
  def get_word_ladder(start_word, end_word)
    # FILL ME IN
    return ['dog', 'cat']
  end
end
