module MathUtils
  def extended_gcd(a,b)
    return [1, 0, a] if b == 0
    y, x, d = extended_gcd(b,a%b)
    [x, y-x*(a/b), d]
  end

  def eqclass(a,m)
    ((a%m)+m)%m
  end

  def inv(a,m)
    x, y, d = extended_gcd(m,a)
    eqclass(y,m)
  end

  def power_mod(b, e, m)
    r = 1
    while e > 0 do
      r = (r*b)%m if (e&1) > 0
      b = (b*b)%m
      e >>= 1
    end
    r
  end

  def split_with_base(n,b,t)
    r = []
    t.times do
      r <<= n%b
      n /= b
    end
    r
  end

  def join_with_base(n,b)
    r = 0
    n.reverse.each { |d| r = r*b + d }
    return r
  end

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