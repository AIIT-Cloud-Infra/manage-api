require 'active_record'
require 'ipaddress'

class BaseImg < ActiveRecord::Base
  has_many :instances, dependent: :nullify

  validates :name, uniqueness: true, presence: true
  validates :ip_address, presence: true
  validates :path, presence: true

  validate :valid_ip?

  private

  def valid_ip?
    errors.add(:ip_address, "invalid value of ip address") unless IPAddress.valid? self.ip_address
  end
end
