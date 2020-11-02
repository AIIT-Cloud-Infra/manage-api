module Services::Users
  class Signup < ActiveInteraction::Base
    string :email
    string :password
    string :password_confirmation

    validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    validates :password, presence: true

    def execute
      User.create!(
        email: email,
        password: password,
        password_confirmation: password_confirmation
      )
    end
  end
end