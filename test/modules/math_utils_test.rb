require 'test_helper'

class RsaTest < ActiveSupport::TestCase

  include MathUtils

  def setup
  end


  test "test extended_gcd" do
    cases = [ [12, 20], [0, 12], [3, 2], [60, 90] ]
    for a, b in cases do
      x, y, d = extended_gcd(a,b)
      #puts "#{x}*#{a} + #{y}*#{b} = #{d}"
      assert( d == a.gcd(b), "GCD is wrong" )
      assert( x*a + y*b == d, "(x,y) is wrong" )
    end
    puts "extended_gcd works"
  end
  
  test "test inv" do
    cases = [ [2, 7], [ 9, 10 ], [ 100, 10**9+21 ] ]
    for x, m in cases do
      y = inv(x,m)
      assert( (x*y)%m == 1, "inv of #{x} mod #{m} is not #{y}" )
    end
    puts "inv works"
  end
  
  test "test power mod" do
    cases = [ [ 2, 9, 1000, 512 ], [ 10, 1000, 203, 123 ] ]
    for b, e, m, r in cases do
      r1 = power_mod(b,e,m)
      assert( r == r1, "power_mod(#{b},#{e},#{r}) = #{r1}, expected #{r}" )
    end
    puts "power_mod works"
  end
  
  test "test split and join" do
    cases = [ [ 1000002032341234, 14 ], [ 12341234, 15] ]
    for n, b in cases do
      splitted = split_with_base(n,b,100)
      joined = join_with_base(splitted,b)
      assert_equal n, joined
    end
    puts "split and join works"
  end

  test "test is_prime" do
    primes = [ 2, 3, 5, 7, 11, 13, 17, 19, 23, 10**9+7, 10**9+9, 10**9+21 ]
    not_primes = [ 1, 0, -1, -2, 10, 10**9+11, 3**10, 4**4, 5**5, 7**4 ]
    for p in primes do 
      assert is_prime(p)
    end
    for np in not_primes do
      assert_not is_prime(np)
    end
  end

  test "gen prime" do 
    10.times do
      p = random_prime(4, 5)
      assert is_prime(p)
      assert( 1000 <= p && p <= 100003 )
    end
  end
end
