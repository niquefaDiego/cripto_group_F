module RSA

include MathUtils

  
  class RSAKeys

    def public_key
      [@e,@n]
    end

    def private_key
      [@d,@n]
    end

    def initialize(min_digits)
      p = random_prime(min_digits,min_digits+1)
      q = random_prime(min_digits,min_digits+1)
      while p == q do q = random_prime(min_digits,min_digits+1) end
      @n = p*q
      phi = (p-1)*(q-1)
      
      @e = 0
      while @e.gcd(phi) != 1 do @e = Random.rand(2..phi-1) end

      @d = inv(@e,phi)
    end

    private
      attr_accessor :e
      attr_accessor :n
      attr_accessor :d
  end
  
  def rsa(m, key)
    e = key[0]
    n = key[1]
    c = []
    m.each { |mi| c <<= power_mod(mi,e,n) } 
    c
  end


end
