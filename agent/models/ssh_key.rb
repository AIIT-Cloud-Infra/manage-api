require './models/application_record.rb'

class SshKey < ApplicationRecord
  belongs_to :instance
  validates :value, presence: true
end
