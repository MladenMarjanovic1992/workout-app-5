class User < ApplicationRecord
  has_many :exercises
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  
  self.per_page = 10
         
  def full_name
    "#{first_name} #{last_name}"
  end
end
