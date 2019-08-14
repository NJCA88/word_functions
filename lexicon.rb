class Lexicon

  def initialize
    # This method handles all of the time consuming logic of the app.  Upon loading, it does 4 tasks.
    # First, it reads all words into a hash, to be able to check for 'wordiness' later on.
    # Second, it sorts each word alphabetically, then adds it to a hash "sorted_hash" where the keys are the sorted
    #  string, and the values are an array of all words that contain those characters, this is used for anagrams.
    # Thirdly, it adds each word into a Trie, that will be used for getting words by prefixes.
    # Finally, after doing that, it creates an adjacency list "edges_hash" where the key is a word, and the value is 
    # an array containing all neighbor words (words with only 1 character being different), this will be used for 
    # quick lookup time for word ladders

    # Start up time on my machine averaged around 120 seconds.  While this is slower than I'd like, the very fast
    # web request time made the slow start up acceptable in my opinion, though I am open to discussing other tradeoffs.


    @hash = {}
    @sorted_hash={}
    @edges_hash = {}
    @trie = Trie.new
    
    file = File.new('words.txt', 'r')
    while (line = file.gets)
      line.strip!.downcase!
      @hash[line] = true
      sorted_string = line.chars.sort.join
      if @sorted_hash[sorted_string]
        @sorted_hash[sorted_string].push(line)
      else
        @sorted_hash[sorted_string] = [line]
      end
      @trie.add(line)  
         
    end
    file.close

    # the counter is solely to give the viewer an idea how much longer longer loading the app will take.
    # It prints to the console incrementally as we progress through the ingestion logic, but it could be 
    # removed to marginally improve loading time.

    counter = 0
    percent_done = 10
    p percent_done.to_s + " percent done"
    @hash.keys.each do |word|
      counter +=1
      get_edges(word)
      if counter % 25000 == 0
        percent_done += 10
        p percent_done.to_s + " percent done"
      end
    end

  end
  def get_edges(word)
    @edges_hash[word] = []
    (0...word.length).each do |idx|
      ("a".."z").each do |char|
        temp = word[0...idx] + char + word[idx+1..-1]
        if is_word?(temp) && temp != word
            @edges_hash[word].push(temp)
        end
      end
    end
  end

  def is_word?(word)
    return @hash.has_key?(word.downcase)
  end
end

  class Node
    attr_accessor :keys, :val,  :end
    def initialize(val = nil)
      self.keys = {}
      self.end = false
      self.val = val
    end
    def set_end
      self.end = true
    end
    def is_end?
      self.end
    end
  end

  class Trie
    attr_accessor :root

    def initialize
      self.root = Node.new
    end
    
    def add(input, node = self.root)
      if input.length == 0
        node.set_end
        return
      elsif !node.keys[input[0]]
        node.keys[input[0]] = Node.new(input[0])
        return self.add(input[1..-1], node.keys[input[0]])
      else
        return self.add(input[1..-1], node.keys[input[0]])
      end
    end
  
    def is_word(word)
      node = root
      while word.length > 1
        if (!node.keys[word[0]])
          return false
        else
          node = node.keys[word[0]]
          word = word[1..-1]
        end
      end
      return node.keys[word] && node.keys[word].is_end? ? true : false
    end
  end