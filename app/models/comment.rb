class Comment < ApplicationRecord
  belongs_to :trade
  belongs_to :sender, class_name: "User"
  belongs_to :recipient,  class_name: "User"
  
end
