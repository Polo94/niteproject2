class Opinion < ApplicationRecord
  belongs_to :good
  belongs_to :user
end
