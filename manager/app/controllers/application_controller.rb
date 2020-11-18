class ApplicationController < ActionController::API
  before_action :snakeize_params

  protected

  def snakeize_params
    params.deep_snakeize!
  end

  def current_user
    token = request.headers["X-AUTH-TOKEN"]
    return render_unauthorized_result() if token.blank?

    p token
    user = User.find_by(remember_digest: token)
    if user
      @current_user = user
    else
      render_unauthorized_result()
    end
  end

  def render_outcome(outcome)
    if outcome.valid?
      render json: outcome.result
    else
      render_bad_result(outcome.errors.full_messages)
    end
  end

  def render_result(outcome)
    if outcome.valid?
      head :ok
    else
      render_bad_result(outcome.errors.full_messages)
    end
  end

  def render_bad_result(messages)
    render json: messages, status: 400
  end

  def render_unauthorized_result
    render text: "unauthorized\n", status: 401
  end
end
