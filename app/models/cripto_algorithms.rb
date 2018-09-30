
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

  def self.encrypt(algorithm, key, plaintext)
    key = to_hex(key)
    plaintext = to_hex(plaintext)
    ciphertext = plaintext.reverse #TODO
    ciphertext
  end

  def self.decrypt(algorithm, key, ciphertext)
    key = to_hex(key)
    plaintext = ciphertext.reverse #TODO
    to_ascii(plaintext)
  end

end

