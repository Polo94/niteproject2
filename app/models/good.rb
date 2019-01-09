class Good < ApplicationRecord
has_one_attached :thumbnail
has_one :seller, class_name: 'Review', foreign_key: 'id'
has_one :buyer, class_name: 'Review', foreign_key: 'id'


belongs_to :user
has_many :opinions
has_many :added_goods, through: :opinions, source: :user

enum property_type: [0, 1, 2, 3, 4]
end
