class BaseImgsController < ApplicationController
  before_action :current_user

  def index
    logger.debug("base_imgs:index started")
    outcome = Services::BaseImgs::Index.run(params)
    render_outcome(outcome)
    logger.debug("base_imgs:index ended")
  end
end