require 'test_helper'

class CriptoAlgorithmsTest < ActionDispatch::IntegrationTest

  def setup
    @tests = [
      %w[ magic 6d61676963 ],
      %w[ 012342345145248677 303132333432333435313435323438363737 ],
      %w[ asdfbmxcASDLFKJWIOQEJGZVMZ 61736466626d78634153444c464b4a57494f51454a475a564d5a ],
      %w[ \\/%[]();!!{}+=*- 5c2f255b5d28293b21217b7d2b3d2a2d ] ] 
  end

  test "to_hex should work" do
    for test in @tests do
      assert_equal(test[1],CriptoAlgorithms.to_hex(test[0]))
    end
  end
  
  test "to_ascii should work" do
    for test in @tests do
      assert_equal(test[0],CriptoAlgorithms.to_ascii(test[1]))
    end
  end

  test "decipher and cipher work" do
    algos = [0]
    secrets = [ [ "The quick brown fox jumps over the lazy dog", "This is a key" ] ]

    allASCII = ""
    for i in 1..127 do allASCII += i.chr end
    secrets.append ( [ allASCII, "abcasdfeiasdfjg03241923adfg1293058" ] )

    for algo in algos do
      for secret in secrets do
        m = secret[0]
        k = secret[1]
        c = CriptoAlgorithms.encrypt(algo,m,k)
        m1 = CriptoAlgorithms.decrypt(algo,c,k)
        assert_equal(m, m1, "Algorithm #{CriptoAlgorithms.names[algo]} failed")
      end
    end
  end
end

