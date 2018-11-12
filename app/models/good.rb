class Good < ApplicationRecord
has_one_attached :thumbnail
has_one :seller, class_name: 'Review', foreign_key: 'seller_id'
has_one :buyer, class_name: 'Review', foreign_key: 'buyer_id'


belongs_to :user
has_many :opinions
has_many :added_goods, through: :opinions, source: :user
end
