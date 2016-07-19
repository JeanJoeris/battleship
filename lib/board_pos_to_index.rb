class HumanNotationToIndex

  def convert(input)
    letter = input.chars.first.downcase
    number = input.chars[1..-1].join
    letter_index = find_letter_index(letter)
    number_index = number.to_i - 1
    [letter_index, number_index]
  end

  def find_letter_index(letter)
    alphabet = ("a".."z").to_a
    alphabet.find_index do |alpha|
      letter == alpha
    end
  end

end
