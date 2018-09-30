require 'DES'

class CriptoAlgorithms

  def self.names() [ "DES", "Lazy AES" ] end

  def self.count() self.names.count end

  # Converts an ASCII string to a string of the hexadecimal ASCII codes.
  def self.to_hex(s)
    len = s.length
    ret = Array.new(2*len, '')
    for i in (0..len-1) do
      hi = s[i].ord.to_s(16)
      ret[2*i] = hi.length == 1 ? '0' : ''
      ret[2*i+1] = hi
    end
    ret.join
  end

  # Converts a hexadecimal string of ASCII codes to string.
  def self.to_ascii(h)
    ret = Array.new(h.length/2,'')
    for i in (0..ret.length-1) do
      ret[i] = h[2*i..2*i+1].to_i(16).chr
    end
    ret.join
  end

  def self.encrypt(algorithm, plaintext, key)
    key = to_hex(key)
    plaintext = remove_trailing_zeroes(plaintext)
    plaintext = to_hex(plaintext)
    case algorithm
    when 0 
      key = force_length(key,16)
      ciphertext = DES.encrypt(plaintext,key)
    when 1
      ciphertext = plaintext.reverse #TODO
    end
    ciphertext
  end

  def self.decrypt(algorithm, ciphertext, key)
    key = to_hex(key)
    case algorithm
    when 0 
      key = force_length(key,16)
      plaintext = DES.decrypt(ciphertext,key)
    when 1
      plaintext = chiphertext.reverse #TODO
    end
    plaintext = to_ascii(plaintext)
    plaintext = remove_trailing_zeroes(plaintext)

    plaintext
  end

  private
    # Takes a hex string key and returns a new
    # hex string of length len, generated  with key
    def self.force_length(key, len)
      if key.length < len
        key += "0"*(len-key.length)
      elsif key.length > len
        newKey = Array.new(len,0)
        for i in (0..key.length-1) do
          newKey[i%len] += key[i].to_i(16)
        end
        for i in (0..len-1) do
          newKey[i] = (newKey[i]%16).to_s(16)
        end
        key = newKey.join
      end
      key
    end

    # Returns the string without all the 0's (ASCII value 0)
    # at the end
    def self.remove_trailing_zeroes(s)
      cnt = 0
      while cnt < s.length && s[-cnt-1].ord == 0 do
        cnt += 1
      end
      s[0..-cnt-1]
    end
end

