require './lexicon'
require 'byebug'

class SpecialLexicon < Lexicon

  # Generates an array of all the anagrams of the given word
  def get_anagrams(word)
    # FILL ME IN
    sorted_word = word.chars.sort.join
    return @sorted_hash[sorted_word].uniq
  end


  # Generates an array of all the words that have the given word as a prefix
  def get_prefixed_words(prefix)

    prefix_copy = prefix[0...-1]
    answer = []
    current_node = @trie.root

    while prefix.length > 0
      node = current_node.keys[prefix[0]]
      prefix = prefix[1..-1]
      if node
        current_node = node
      else
        return ["Sorry, we can't find any words with that prefix"]
      end
    end
    #we now have the final letter of the prefix as the current node.
    # print "keys are: ", current_node.keys

    answer = dfs(current_node, prefix_copy)
    if @trie.is_word(prefix_copy + current_node.val)
      answer.push(prefix_copy + current_node.val)
    else
      p prefix_copy + current_node.val
    end
    return answer.flatten
  end

  def dfs(node, prefix)
    prefix = prefix + node.val
    if node.keys.length == 0
      return [prefix]
    end

    return node.keys.map do  |key, value|
      if (node.keys[key].end && node.keys[key].keys.length > 0)
        #  if we are currently looking at a word that also has children
        #   add the current word we're looking at as well as the DFS
          dfs(node.keys[key], prefix).push(prefix + node.keys[key].val)
      else 
        dfs(node.keys[key], prefix)
      end
    end

  end


  # Generates the shortest possible word ladder connecting the two words
  def get_word_ladder(start_word, end_word)
    # FILL ME IN
    return ['dog', 'cat']
  end
end
