class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :wikis
  has_many :collaborators
  has_many :collaborator_wikis, through: :collaborators, source: :wiki

  after_initialize :set_default_role

  def set_default_role
    self.role ||= :standard
  end

  enum role: [:standard, :premium, :admin]

end
