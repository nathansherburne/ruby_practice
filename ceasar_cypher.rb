def alpha?(s)
    s.match(/^[[:alpha:]]$/)
end

def ascii_to_alpha_index(c)
    c.upcase.ord - 'A'.ord
end

def alpha_index_to_ascii(i, upcase)
    if upcase then i + 'A'.ord else i + 'a'.ord end
end

def alpha_shift(c, n)
    alpha_index_to_ascii((ascii_to_alpha_index(c) + n) % 26, c.upcase == c).chr
end

def encrypt_caesar_cypher(message, shift_factor)
    digest = ""
    message.split("").each { |c| digest += 
        alpha?(c) ? alpha_shift(c, shift_factor) 
                     : c }
    return digest
end

def decrypt_caesar_cypher(digest, shift_factor)
    message = ""
    digest.split("").each { |c| message +=
        alpha?(c) ? alpha_shift(c, -shift_factor)
                     : c } 
    return message
end

puts "Please enter the message that you would like to encrypt with a Caesar Cypher:"
print '> '
message = gets.chomp
puts "Please enter the Caesar Cypher shift factor:"
print '> '
shift_factor = gets.chomp.to_i

digest = encrypt_caesar_cypher(message, shift_factor)
orig_message = decrypt_caesar_cypher(digest, shift_factor)

puts "Original Message: #{message}"
puts "Digest: #{digest}"
puts "Decrypted: #{orig_message}"

