
class WordCounter
  def initialize(file)
    @file = File.open(file, "r")
    @contents = @file.read.gsub!(/\W|\d/, " ").downcase

  end

  def word_array
    @contents.split(" ")
  end

  def text_length
    word_array.length
  end

  def word_hash
    @word_hash = {}
    word_array.each do |word|
      if @word_hash[word]
        @word_hash[word] += 1
      else
        @word_hash[word] = 1
      end
    end
    @word_hash
  end

  def top_ten_words
    @top_ten_words = word_hash.sort_by { |word, count| count}.reverse[0..9]
    @top_ten_words.each do |word_and_count|
      puts "#{word_and_count[0]} ----> #{word_and_count[1]}"
    end
  end

  def longest_words
    sorted_by_length_array = word_array.sort_by {|word| word.length}.reverse
    longest_length = sorted_by_length_array.first.length
    longest_word_array = sorted_by_length_array.select {|word| word if word.length == longest_length}.uniq
  end

  def words_with_most_consonants
    longest_words_sans_cons = {}
    longest_length = 0
    word_array.each do |word|
      word_sans_cons = word.gsub(/a|e|i|o|u|/, "")
      if word_sans_cons.length >= longest_length
        longest_length = word_sans_cons.length 
        longest_words_sans_cons[word] = word_sans_cons.length
      end
    end
    longest_words_sans_cons.select {|word,length_sans_cons| word if length_sans_cons == longest_length}.keys
  end
end


kant = WordCounter.new("kant.txt")
puts kant.longest_words