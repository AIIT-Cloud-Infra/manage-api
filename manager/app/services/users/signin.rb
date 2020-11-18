module Services::Users
  class Signin < ActiveInteraction::Base
    string :email
    string :password

    validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    validates :password, presence: true

    def execute
      user = User.find_by!(email: email.downcase)
      if user && user.authenticate(password)
        user.remember
      else
        raise ActiveRecord::RecordNotFound
      end
      p user
      { token: user.remember_digest }
    end
  end
end