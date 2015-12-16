require 'whatlanguage'

class Cipher
  def self.encrypt(string, offset)
    result = ""
    alphabet = ('a'..'z').to_a.concat(('A'..'Z').to_a)
    alphabet_size = alphabet.size

    string.each_char do |ch|
      if !alphabet.include?(ch)
        result += ch
      else
        offset_index = (alphabet.index(ch) + offset) % alphabet_size
        result += alphabet[offset_index]
      end
    end

    result
  end

  def self.decrypt(string, key)
    encrypt(string, -key)
  end

  def self.frequency(string)
    result = Hash.new(0)
    string.delete(' ').each_char do |ch|
      result[ch.to_sym] += 1
    end
    result.sort_by { |k,v| k.to_s }.to_h
  end

  def self.guess_offsets(string)
    result = []
    1.upto 100 do |i|
      result << i if decrypt(string, i).language == :english
    end
    result
  end
end
