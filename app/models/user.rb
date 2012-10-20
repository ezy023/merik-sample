# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :image, :remote_image_url, :summary
  has_secure_password
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  # has_many :retweet, :class_name => "micropost"
  # has_many :reposts
  # has_many :microposts, :through => :reposts
  #for retweets
  has_many :retweetings, foreign_key: "retweeter_id"
  has_many :retweets, through: :retweetings, :class_name => 'Micropost'


  mount_uploader :image, ImageUploader
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
  						uniqueness: { case_sensitvie: false }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, on: :create
  
  def feed
  	Micropost.from_users_followed_by(self) + Retweeting.from_users_followed_by(self) + Retweeting.from_users_retweets(self)
  end
  
  def following?(other_user)
  	self.relationships.find_by_followed_id(other_user.id)
  end
  
  def follow!(other_user)
  	self.relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
  	self.relationships.find_by_followed_id(other_user.id).destroy
  end

  def retweeting?(other_post)
    retweetings.find_by_retweet_id(other_post.id)
  end
  
  def retweet!(other_post)
    retweetings.create!(retweet_id: other_post.id)
  end  
  
  def self.search(search)
  	if search
  		# For SQLite
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
      # For Heroku POSTGRESQL
      # find(:all, :conditions => ['name ILIKE ?', "%#{search}%"])
  	else
  		find(:all)
  	end
  end
  
  def generate_token(column)
  	begin
  		self[column] = SecureRandom.urlsafe_base64
  	end while User.exists?(column => self[column])
  end
  
  def send_password_reset
  	generate_token(:password_reset_token)
  	self.password_reset_sent_at = Time.zone.now
  	save!
  	UserMailer.password_reset(self).deliver
  end
  
  private
  
  	def create_remember_token
  		self.remember_token = SecureRandom.urlsafe_base64
  	end
end
