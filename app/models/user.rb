class User < ApplicationRecord
  has_many :exercises
  has_many :friendships
  has_many :friends, through: :friendships, class_name: "User"
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
  
  def self.search_by_name(name)
    name_array = name.split(" ")
    
    if name_array.size == 1
      where("first_name LIKE ? or last_name LIKE ?", "%#{name_array[0]}%", "%#{name_array[0]}%").order(:first_name)
    else
      where("first_name LIKE ? or first_name LIKE ? or last_name LIKE ? or last_name LIKE ?", "%#{name_array[0]}%", "%#{name_array[1]}%", "%#{name_array[0]}%", "%#{name_array[1]}%").order(:first_name)
    end
  end
  
  def follows_or_same?(new_friend)
    friendships.map(&:friend).include?(new_friend) || self == new_friend
  end
  
  def current_friendships(friend)
    friendships.where(friend: friend)[0]
  end
  
end
