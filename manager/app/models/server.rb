class Server < ApplicationRecord
  has_many :instances, dependent: :nullify

  validates :ip_address, presence: true
  validates :memory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :cpu, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :storage, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :availables, -> (memory, cpu, storage) do
    joins(%{
      LEFT JOIN instances
      ON servers.id = instances.server_id AND instances.status != 'terminated'
    }) \
    .group(Server.arel_table[:id]) \
    .select(
      'servers.*,
      (servers.memory - IFNULL(sum(instances.memory), 0)) as rest_memory,
      (servers.cpu - IFNULL(sum(instances.cpu), 0)) as rest_cpu,
      (servers.storage - IFNULL(sum(instances.storage), 0)) as rest_storage'
    ) \
    .having('rest_memory >= ?', memory) \
    .having('rest_cpu >= ?', cpu) \
    .having('rest_storage >= ?', storage)
  end
end
