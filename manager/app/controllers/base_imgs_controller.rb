class BaseImgsController < ApplicationController
  before_action :current_user

  def index
    outcome = Services::BaseImgs::Index.run(params)
    render_outcome(outcome)
  end
end