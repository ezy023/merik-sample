class Micropost < ActiveRecord::Base
  attr_accessible :content, :song, :title, :available, :genre, :artist, :user_id
  belongs_to :user
  has_many :retweeter, :class_name => 'user'
  # has_many :reposts
  # has_many :users, :through => :reposts
  mount_uploader :song, MusicUploader

  # before_save { |post| post.genre = genre.downcase }
  
 # validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  validates :song, presence: true
  validates :title, presence: true
  # validates :artist, presence: true
  # validates :genre, presence: true
  
  default_scope order: 'microposts.created_at DESC'
  
  def self.from_users_followed_by(user)
  	followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
	where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user)
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['title LIKE ? OR artist LIKE ? OR genre LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      find(:all)
    end
  end

end