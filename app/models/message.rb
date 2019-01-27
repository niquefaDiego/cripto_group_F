include MathUtils

class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user
  validates_presence_of :body, :conversation_id, :user_id

  def message_time
    created_at.strftime("%m/%d/%y a las %l:%M %p")
  end

  def signature
    md5 = Digest::MD5.new
    md5 << body 
    s = md5.hexdigest
    s = power_mod(s.to_i(16), $rsa_keys.public_key[0], $rsa_keys.public_key[1])

    
  end

 end
 