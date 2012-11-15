class Micropost < ActiveRecord::Base
  attr_accessible :content, :song, :title, :available, :genre, :artist, :user_id, :hashtag
  belongs_to :user
  # for retweets
  has_many :retweetings, foreign_key: "retweet_id"
  has_many :retweeters, through: :retweetings, :class_name => 'User'
  mount_uploader :song, MusicUploader

  before_save :remove_hash
  
 # validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  validates :song, presence: true
  validates :title, presence: true
  validates :artist, presence: true
  validates :genre, presence: true
  
  default_scope order: 'microposts.updated_at DESC'
  
  def self.from_users_followed_by(user)
    followed = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    retweeters = "SELECT retweet_id FROM retweetings WHERE retweeter_id IN (#{followed})"
    retweets = "SELECT retweet_id FROM retweetings WHERE retweeter_id = :user_id"
    followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id
                          UNION ALL
                         SELECT retweet_id FROM retweetings WHERE retweeter_id IN (#{followed})
                          UNION ALL
                         SELECT retweet_id FROM retweetings WHERE retweeter_id = :user_id"
  where("user_id IN (#{followed}) OR user_id = :user_id OR id IN (#{retweeters}) OR id IN (#{retweets})", user_id: user)
  end

  def self.show_user_posts(user)
    followed = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    retweets = "SELECT retweet_id FROM retweetings WHERE retweeter_id = :user_id"
    followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id
                          UNION ALL
                         SELECT retweet_id FROM retweetings WHERE retweeter_id = :user_id"
  where("user_id = :user_id OR id IN (#{retweets})", user_id: user)
  end

  def self.search(search)
    if search
     # For use with SQLite on local
      # find(:all, :conditions => ['title LIKE ? OR artist LIKE ? OR genre LIKE ? OR hashtag LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
    # For use with Heroku POSTGRESQL
      find(:all, :conditions => ['title ILIKE ? OR artist ILIKE ? OR genre ILIKE ? OR hashtag ILIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      find(:all)
    end
  end

  def remove_hash
    if self.hashtag[0] == '#'
      self.hashtag.slice!(0)
    end
  end

end
