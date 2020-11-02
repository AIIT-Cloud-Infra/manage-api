class InstancesController < ApplicationController
  def index
    outcome = Services::Instances::Index.run(params)
    render_outcome(outcome)
  end

  def show
    outcome = Services::Instances::Show.run(params)
    render_outcome(outcome)
  end

  def create
    outcome = Services::Instances::Create.run(params)
    render_outcome(outcome)
  end

  def destroy
    outcome = Services::Instances::Destroy.run(params)
    render_outcome(outcome)
  end
  
  def start
    outcome = Services::Instances::Start.run(params)
    render_result(outcome)
  end

  def stop
    outcome = Services::Instances::Stop.run(params)
    render_result(outcome)
  end

  def ssh_key
    outcome = Services::Instances::SshKey.run(params)
    render_outcome(outcome)
  end
end