class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators

  default_scope { order('created_at DESC') }

  def collaborator_for(user)
    collaborators.where(user: user).first
  end
end

# wiki.users.include?(user)
