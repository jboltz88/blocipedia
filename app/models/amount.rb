class Amount < ActiveRecord::Base
  after_initialize :default

  def self.default
    15_00
  end
end
