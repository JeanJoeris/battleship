class BoardPosToIndex

  def initialize
    @letter_hash = letter_hash
  end

  def convert(input)
    letter = input.chars.first.downcase
    number = input.chars[1..-1].join
    letter_index = @letter_hash[letter]
    number_index = number.to_i - 1
    [letter_index, number_index]
  end

  def letter_hash
    hash = {}
    ("a".."z").to_a.each_with_index do |letter, index|
      hash[letter] = index
    end
    hash
  end


  def convert_back(input)
    letter = @letter_hash.key(input.first)
    number = input.last + 1
    letter + number.to_s
  end

end
