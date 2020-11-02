module Services::BaseImgs
  class Index < ActiveInteraction::Base
    def execute
      BaseImg.all.select([:id, :name, :created_at, :updated_at])
    end
  end
end