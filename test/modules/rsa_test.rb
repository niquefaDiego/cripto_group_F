require 'test_helper'

class RsaTest < ActiveSupport::TestCase

  include RSA

  def setup
  end

  test "test key generation" do
    cases = [ 10, 20, 40, 99, 42, 341, 231, 345, 99 ]
    keys = RSAKeys.new(4)
    for m in cases do
      m = [m]
      m1 = rsa(m,keys.public_key)
      m2 = rsa(m1,keys.private_key)
      m3 = rsa(m2,keys.public_key)
      assert_equal(m,m2)
      assert_equal(m1,m3)
    end

  end

  test "test rsa" do

    p = 47
    q = 71
    e = 79
    m = 6882326879666683
    t = 6

    n = p*q
    phi = (p-1)*(q-1)
    
    e = 0
    while e.gcd(phi) != 1 do
      e = Random.rand(2..phi-1) 
    end

    d = inv(e,phi)

    arr_m = split_with_base(m,n,t)
    arr_c = rsa(arr_m,[e,n])

    arr_m1 = rsa(arr_c,[d,n])

    m1 = join_with_base(arr_m1,n)

    assert_equal m, m1

  end

end


