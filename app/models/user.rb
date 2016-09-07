class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :wikis
  after_initialize :init

  def init
    self.role ||= :standard
  end

  enum role: [:standard, :premium, :admin]

end
