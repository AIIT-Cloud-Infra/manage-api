class InstancesController < ApplicationController
  before_action :current_user

  def index
    outcome = Services::Instances::Index.run(params.merge(user_id: @current_user.id))
    render_outcome(outcome)
  end

  def show
    outcome = Services::Instances::Show.run(params.merge(user_id: @current_user.id))
    render_outcome(outcome)
  end

  def create
    outcome = Services::Instances::Create.run(params.merge(user_id: @current_user.id))
    render_outcome(outcome)
  end

  def destroy
    outcome = Services::Instances::Destroy.run(params.merge(user_id: @current_user.id))
    render_outcome(outcome)
  end
  
  def start
    outcome = Services::Instances::Start.run(params.merge(user_id: @current_user.id))
    render_result(outcome)
  end

  def stop
    outcome = Services::Instances::Stop.run(params.merge(user_id: @current_user.id))
    render_result(outcome)
  end

  def ssh_key
    outcome = Services::Instances::SshKey.run(params.merge(user_id: @current_user.id))
    render_outcome(outcome)
  end
end