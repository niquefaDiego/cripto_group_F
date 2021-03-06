class User < ApplicationRecord

  attr_accessor :remember_token

  before_save   :downcase_email

  validates :name,
    presence: true,
    length: {maximum: 100}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,
    presence: true,
    length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password,
    presence: true,
    length: {minimum: 6},
    allow_nil: true

  # Puts a the user in a presistent session.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(self.remember_token))
  end

  # Removes a user from their persistent session.
  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def feed
    #Message.where("user_id= ? ",id) TODO
  end

  class << self

    # Return the hash digest of the given string.
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token, used to remember login with cookies.
    def new_token
      SecureRandom.urlsafe_base64
    end

  end

  private
    def downcase_email
      self.email.downcase!
    end

end
