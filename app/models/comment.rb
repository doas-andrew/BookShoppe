class Comment < ApplicationRecord
  belongs_to :trade
  belongs_to :user
end
