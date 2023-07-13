class Like < ApplicationRecord
  belongs_to :auhtor, class_name 'User'
  belongs_to :post
end
