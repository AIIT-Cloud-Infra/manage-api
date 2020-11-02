class User < ApplicationRecord
  has_secure_password

  has_many :instances, dependent: :nullify

  before_save :downcase_email

  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
  validates :password, presence: true

  class << self
    def digest(string)
      BCrypt::Password.create(string, cost: BCrypt::Engine::MIN_COST)
    end
    
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    token = User.new_token
    update_attribute(:remember_digest, User.digest(token))
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
