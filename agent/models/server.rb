require 'ipaddr'
require 'active_record'

class Server < ActiveRecord::Base
  has_many :instances, dependent: :nullify

  validates :ip_address, presence: true
  validates :memory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :cpu, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :storage, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :valid_ip?

  private

  def valid_ip?
    !!IPAddr.new(ip_address) rescue errors.add(:ip_address, "invalid value of ip address")
  end
end
