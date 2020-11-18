require 'active_record'

class SshKey < ActiveRecord::Base
  belongs_to :instance
  validates :value, presence: true
end
