class Instance < ApplicationRecord
  belongs_to :base_img
  belongs_to :server
  belongs_to :user
  has_one :ssh_key, dependent: :destroy

  enum status: {
    starting: 'starting',
    initializing: 'initializing',
    running: 'running',
    halting: 'halting',
    halted: 'halted',
    terminating: 'terminating',
    terminated: 'terminated'
  }
end
