class Post < ApplicationRecord

  scope :post_list, -> { all.order('created_at DESC') }

  belongs_to :member

end
