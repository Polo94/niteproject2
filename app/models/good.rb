class Good < ApplicationRecord
has_one_attached :thumbnail
belongs_to :user
has_many :opinions
has_many :added_goods, through: :opinions, source: :user
end
