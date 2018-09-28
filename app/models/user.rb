class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :goods, dependent: :destroy
  has_many :opinions
  has_many :opinion_additions, through: :opinions, source :good

  def subscribed?
    stripe_subscription_id?
  end

end
