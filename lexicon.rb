class Lexicon

  def initialize
    # The full array of all words
    @array = []
    # A hash containing all the words as keys
    @hash = {}
    @sorted_hash={}
    @sizes_hash = {}
    @edges_hash = {}
    @trie = Trie.new
    @sizes_graphs = {}
    

    file = File.new('words.txt', 'r')
    while (line = file.gets)
      line.strip!.downcase!
      # @array.push line
      @hash[line] = true
      sorted_string = line.chars.sort.join
      if @sorted_hash[sorted_string]
        @sorted_hash[sorted_string].push(line)
      else
        @sorted_hash[sorted_string] = [line]
      end
      if @sizes_hash[line.length]
        @sizes_hash[line.length].push(line)
      else
        @sizes_hash[line.length] = [line]
      end

      @trie.add(line)  
         
    end
    file.close


    @hash.keys.each do |word|
      get_edges(word)

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

  # Returns true if the given word is in the lexicon
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