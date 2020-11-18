require 'active_record'
require 'ipaddr'

class BaseImg < ActiveRecord::Base
  has_many :instances, dependent: :nullify

  validates :name, uniqueness: true, presence: true
  validates :ip_address, presence: true
  validates :path, presence: true

  validate :valid_ip?

  private

  def valid_ip?
    !!IPAddr.new(ip_address) rescue errors.add(:ip_address, "invalid value of ip address")
  end
end
