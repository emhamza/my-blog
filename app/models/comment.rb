class Comment < ApplicationRecord
  belongs_to :auhtor, class_name "User"
  belongs_to :post
end
