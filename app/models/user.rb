class User < ApplicationRecord
  attr_accessor :remember_token

  has_many :microposts, dependent: :destroy
  has_many :meetings, dependent: :destroy

  has_many :active_notices, class_name: "Notice", foreign_key: "visitor_id", dependent: :destroy
  has_many :passive_notices, class_name: "Notice", foreign_key: "visited_id", dependent: :destroy

  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :likes, dependent: :destroy
  has_many :like_microposts, through: :likes, source: :micropost

  has_many :comments, dependent: :destroy
  has_many :comment_microposts, through: :comments, source: :micropost

  has_many :events, dependent: :destroy

  has_many :conditions, dependent: :destroy
  
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   true, length: { maximum: 255 },
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def User.digest(string)
  cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
  BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def feed
    Micropost.where("user_id IN (?) OR user_id = ?",following_ids, id)
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def create_notice_follow(current_user)
    temp = Notice.where(["visitor_id = ? and visited_id = ? and action = ?", current_user.id, id, 'follow'])
    if temp.blank?
      notice = current_user.active_notices.new(visited_id: id, action: 'follow')
      notice.save if notice.valid?
    end
  end
end
