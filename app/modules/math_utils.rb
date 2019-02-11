module MathUtils

  # Extended euclidean algorithm, returns [d, x, y]
  # d: Greated common divisor of a and b
  # x, y: ax + by = d
  def extended_gcd(a,b)
    return [1, 0, a] if b == 0
    y, x, d = extended_gcd(b,a%b)
    [x, y-x*(a/b), d]
  end

  # Returns x in [0,m) equivalent to a mod m
  def eqclass(a,m)
    ((a%m)+m)%m
  end

  # Returns multiplicative inverse of a modulo m.
  def inv(a,m)
    x, y, d = extended_gcd(m,a)
    eqclass(y,m)
  end

  # Returns b to the e-th power modulo m.
  def power_mod(b, e, m)
    r = 1
    while e > 0 do
      r = (r*b)%m if (e&1) > 0
      b = (b*b)%m
      e >>= 1
    end
    r
  end

  # Transforms n into a b-based integer, and returns the digits
  # in an array of integers. The array will have t elements,
  # so it may be truncated or it may have leading zeroes.
  def split_with_base(n,b,t)
    r = []
    t.times do
      r <<= n%b
      n /= b
    end
    r
  end

  # Given the digits of a number in base b in the array n.
  # Returns the number.
  def join_with_base(n,b)
    r = 0
    n.reverse.each { |d| r = r*b + d }
    return r
  end

  # true iff n is prime.
  # O(sqrt(n))
  def is_prime(n)
    return false if n < 2
    return true if n < 4
    return false if n%2 == 0 or n%3 == 0
    d = 5
    while d*d <= n do
      return false if n%d == 0
      d += 2
      break if d*d > n
      return false if n%d == 0
      d += 4
    end
    return true
  end

  # Returns a random primes with an amount of digits
  # within the ranged given.
  def random_prime(min_digits, max_digits)
    min_val=10**(min_digits-1)
    max_val=10**max_digits-1
    n = Random.rand(min_val..max_val)
    while not is_prime(n) do
      n += 1
    end
    n
  end

end