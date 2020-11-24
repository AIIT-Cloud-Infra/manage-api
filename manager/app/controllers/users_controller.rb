class UsersController < ApplicationController
  def signup
    logger.debug("users:signup started")
    outcome = Services::Users::Signup.run(
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password] # 意図的に確認なし
    )
    render_result(outcome)
    logger.debug("users:signup ended")
  end

  def signin
    logger.debug("users:signin started")
    outcome = Services::Users::Signin.run(params)
    render_outcome(outcome)
    logger.debug("users:signin ended")
  end
end