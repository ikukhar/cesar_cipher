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
    1.upto 26 do |i|
      result << i if decrypt(string, i).language == :english
    end
    result
  end
end

# if ARGV.empty?
#   ARGV << 'Currying allows us to call a function with only part of its arguments and it will return another function that requires the remainder'
#   ARGV << 5
# end
#
# string = ARGV[0]
# offset = ARGV[1].to_i
#
# encrypt_str = encrypt(string, offset)
# decrypt_str = decrypt(encrypt_str, offset)
# try_auto_decrypt(encrypt_str)
#
# puts frequency(string)
