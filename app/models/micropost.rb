class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order( created_at: :desc ) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size

  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user

  def liked?(user)
    likes.where(user_id: user.id).exists?
  end


  private


    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "上限は5MBまでです!ぴえん")
      end
    end
end
