require 'test_helper'

class CriptoAlgorithmsTest < ActionDispatch::IntegrationTest

  def setup
    @tests = [
      %w[ magic 6d61676963 ],
      %w[ 012342345145248677 303132333432333435313435323438363737 ],
      %w[ asdfbmxcASDLFKJWIOQEJGZVMZ 61736466626d78634153444c464b4a57494f51454a475a564d5a ],
      %w[ /%[]();!!{}+=*- 2f255b5d28293b21217b7d2b3d2a2d ] ]
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
end

