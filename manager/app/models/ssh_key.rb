class SshKey < ApplicationRecord
  belongs_to :instance
  validates :value, presence: true
end
