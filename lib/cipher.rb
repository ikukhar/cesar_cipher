require 'whatlanguage'

def encrypt(string, offset)
  alphabet = ('a'..'z').to_a.concat(('A'..'Z').to_a)
  alphabet_size = alphabet.size
  new_string = ""

  string.each_char do |ch|
    if !alphabet.include?(ch)
      new_string += ch
    else
      offset_index = (alphabet.index(ch) + offset) % alphabet_size
      new_string += alphabet[offset_index]
    end
  end

  new_string
end

def decrypt(string, key)
  encrypt(string, -key)
end

def frequency(string)
  freq = Hash.new(0)

  string.each_char do |ch|
    freq[ch.to_sym] += 1
  end

  freq
end

def try_auto_decrypt(string)
  result = nil
  1.upto 26 do |i|
    decrypt_str = decrypt(string, i)
    if decrypt_str.language == :english
      puts "#{decrypt_str} : #{i}"
      result = i
      break
    end
  end
  result
end

if ARGV.empty?
  ARGV << 'Currying allows us to call a function with only part of its arguments and it will return another function that requires the remainder'
  ARGV << 5
end

string = ARGV[0]
offset = ARGV[1].to_i

encrypt_str = encrypt(string, offset)
decrypt_str = decrypt(encrypt_str, offset)
try_auto_decrypt(encrypt_str)

puts frequency(string)
