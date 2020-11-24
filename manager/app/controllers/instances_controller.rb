class InstancesController < ApplicationController
  before_action :current_user

  def index
    logger.debug("instances:index started")
    outcome = Services::Instances::Index.run(params.merge(user_id: @current_user.id))
    render_outcome(outcome)
    logger.debug("instances:index ended")
  end

  def show
    logger.debug("instances:show started")
    outcome = Services::Instances::Show.run(params.merge(user_id: @current_user.id))
    render_outcome(outcome)
    logger.debug("instances:show ended")
  end

  def create
    logger.debug("instances:create started")
    outcome = Services::Instances::Create.run(params.merge(user_id: @current_user.id))
    render_outcome(outcome)
    logger.debug("instances:create ended")
  end

  def destroy
    logger.debug("instances:destroy started")
    outcome = Services::Instances::Destroy.run(params.merge(user_id: @current_user.id))
    render_outcome(outcome)
    logger.debug("instances:destroy ended")
  end
  
  def start
    logger.debug("instances:start started")
    outcome = Services::Instances::Start.run(params.merge(user_id: @current_user.id))
    render_result(outcome)
    logger.debug("instances:start ended")
  end

  def stop
    logger.debug("instances:stop started")
    outcome = Services::Instances::Stop.run(params.merge(user_id: @current_user.id))
    render_result(outcome)
    logger.debug("instances:stop ended")
  end

  def ssh_key
    logger.debug("instances:ssh_key started")
    outcome = Services::Instances::SshKey.run(params.merge(user_id: @current_user.id))
    render_outcome(outcome)
    logger.debug("instances:ssh_key ended")
  end
end