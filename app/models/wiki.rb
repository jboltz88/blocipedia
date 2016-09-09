class Wiki < ActiveRecord::Base
  belongs_to :user
end

# wiki.users.include?(user)
