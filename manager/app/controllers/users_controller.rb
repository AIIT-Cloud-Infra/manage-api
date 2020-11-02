class UsersController < ApplicationController
  def signup
    outcome = Services::Users::Signup.run(
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password] # 意図的に確認なし
    )
    render_result(outcome)
  end

  def signin
    outcome = Services::Users::Signin.run(params)
    render_outcome(outcome)
  end
end