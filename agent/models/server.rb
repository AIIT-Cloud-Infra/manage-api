require 'ipaddress'
require './models/application_record.rb'

class Server < ApplicationRecord
  has_many :instances, dependent: :nullify

  validates :ip_address, presence: true
  validates :memory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :cpu, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :storage, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :valid_ip?

  private

  def valid_ip?
    errors.add(:ip_address, "invalid value of ip address") unless IPAddress.valid? self.ip_address
  end
end
