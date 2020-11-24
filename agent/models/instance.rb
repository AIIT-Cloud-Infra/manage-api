require './models/application_record.rb'

class Instance < ApplicationRecord
  belongs_to :base_img
  belongs_to :server
  belongs_to :user
  has_one :ssh_key, dependent: :destroy

  validates :memory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :cpu, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :storage, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

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
