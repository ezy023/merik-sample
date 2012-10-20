class Micropost < ActiveRecord::Base
  attr_accessible :content, :song, :title, :available, :genre, :artist, :user_id
  belongs_to :user
  # has_many :retweeter, :class_name => 'user'
  # has_many :reposts
  # has_many :users, :through => :reposts
  # for retweets
  has_many :retweetings, foreign_key: "retweet_id"
  has_many :retweeters, through: :retweetings, :class_name => 'User'
  mount_uploader :song, MusicUploader

  # before_save { |post| post.genre = genre.downcase }
  
 # validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  validates :song, presence: true
  validates :title, presence: true
  validates :artist, presence: true
  validates :genre, presence: true
  
  default_scope order: 'microposts.created_at DESC'
  
  def self.from_users_followed_by(user)
  	followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
	where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user)
  end

  def self.search(search)
    if search
     # For use with SQLite on local
      find(:all, :conditions => ['title LIKE ? OR artist LIKE ? OR genre LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
    # For use with Heroku POSTGRESQL
      # find(:all, :conditions => ['title ILIKE ? OR artist ILIKE ? OR genre ILIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      find(:all)
    end
  end

end
