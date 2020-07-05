class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost

  has_many :notices, dependent: :destroy

  validates :text, presence: true, length: { maximum: 140 }
  validates :micropost_id, presence: true

end
