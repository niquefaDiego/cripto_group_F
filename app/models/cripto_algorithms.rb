
class CriptoAlgorithms

  def self.names() [ "DES", "Lazy AES" ] end

  def self.count() self.names.count end

  def self.encrypt(algorithm, key, plaintext)
    #TODO
    plaintext.reverse
  end

  def self.decrypt(algorithm, key, ciphertext)
    #TODO
    ciphertext.reverse
  end

end

