class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order( created_at: :desc ) }
  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size

  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user

  has_many :comments, dependent: :destroy
  has_many :notices, dependent: :destroy

  def liked?(user)
    likes.where(user_id: user.id).exists?
  end

  def create_notice_like(current_user)
    temp = Notice.where(["visitor_id = ? and visited_id = ? and micropost_id = ? and action = ?", current_user.id, user_id, id, 'like'])
    if temp.blank?
      notice = current_user.active_notices.new(micropost_id: id, visited_id: user_id, action: 'like')
      if notice.visitor_id == notice.visited_id
        notice.checked = true
      end
      notice.save if notice.valid?
    end
  end

  def create_notice_comment(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(micropost_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notice_comment(current_user, comment_id, temp_id['user_id'])
    end
    save_notice_comment(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notice_comment(current_user, comment_id,visited_id)
    notice = current_user.active_notices.new(micropost_id: id, comment_id: comment_id, visited_id: visited_id, action: 'comment')
    if notice.visitor_id == notice.visited_id
      notice.checked = true
    end
    notice.save if notice.valid?
  end

  def self.search(search)
    Micropost.where(['content LIKE ?', "%#{search}%"])
  end

    private

    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "上限は5MBまでです!ぴえん")
      end
    end
end
