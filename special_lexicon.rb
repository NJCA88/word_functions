require './lexicon'
require 'set'

class SpecialLexicon < Lexicon

  # Generates an array of all the anagrams of the given word
  def get_anagrams(word)
    # FILL ME IN
    word = word.downcase
    sorted_word = word.chars.sort.join
    # return @sorted_hash[sorted_word].uniq
    if @sorted_hash[sorted_word]
      return @sorted_hash[sorted_word].uniq
    else
      return ["Sorry, we couldn't find any anagrams of " + word]
    end
  end


  # Generates an array of all the words that have the given word as a prefix
  def get_prefixed_words(prefix)
    prefix = prefix.downcase
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
    # BFS from the starting word with a queue or [current_word, path]
      return ["Sorry, " + end_word + " isn't in our dictionary!"]  if !@hash[end_word]
      return ["Sorry, " + start_word + " isn't in our dictionary!"] if !@hash[start_word] 
      return ["Sorry, we need both words to be the same length"] if start_word.length != end_word.length
      
      start_word = start_word.downcase
      end_word = end_word.downcase
    queue = [[start_word, [start_word]]]
    while (queue.length > 0)
      current_data = queue.shift
      cur_word = current_data[0]
      cur_path = current_data[1]


      @edges_hash[cur_word].each do |neighbor|
        return ( cur_path.dup.push(neighbor) ) if neighbor == end_word
        new_entry = [ neighbor, cur_path.dup.push(neighbor)]
        queue.push(new_entry)
      end
    end


    
    return ["Sorry, we couldn't find any path!  We need to learn more words... :-("]
  end

end
