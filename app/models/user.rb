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
  attr_accessible :email, :name, :password, :password_confirmation, :image, :remote_image_url, :summary, :username, :invitation_token, :terms, :invitation_limit, :background_image, :soundcloud_link, :facebook_link, :twitter_link
  has_secure_password
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :authentications
  acts_as_voter

  # for private messages
  has_private_messages :class_name => 'PrivateMessage'
  
  #for retweets
  has_many :retweetings, foreign_key: "retweeter_id"
  has_many :retweets, through: :retweetings, :class_name => 'Micropost'

  has_many :favorites
  has_many :microposts, through: :favorites
  
  #for beta invites
  # has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
  # belongs_to :invitation

  # before_create :set_invitation_limit


  mount_uploader :image, ImageUploader
  mount_uploader :background_image, BackgroundUploader
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
  						uniqueness: { case_sensitvie: false }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates_uniqueness_of :username
  validates_acceptance_of :terms
  
  # For beta invitations
  # validates_presence_of :invitation_id, :message => "is required", on: :create
  # validates_uniqueness_of :invitation_id, on: :create

  extend FriendlyId
  friendly_id :username, use: :slugged
  
  def feed
  	Micropost.from_users_followed_by(self)
  end

  def show_user_microposts
    Micropost.show_user_posts(self)
  end

  def all_favorites
    Micropost.user_favorites(self)
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

  def untweet!(other_post)
    retweetings.find_by_retweet_id(other_post.id).destroy     
  end 

  def favorite!(other_post)
    favorites.create!(micropost_id: other_post.id)
  end

  def unfavorite!(other_post)
    favorites.find_by_id(other_post.id).destroy
  end

  def favoriting?(other_post)
    favorites.exists?(user_id: self.id, micropost_id: other_post.id)
  end
  
  def self.search(search)
  	if search
  		# For SQLite
      # find(:all, :conditions => ['name LIKE ? OR summary LIKE ? OR username LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
      # For Heroku POSTGRESQL
      find(:all, :conditions => ['name ILIKE ? OR summary ILIKE ? OR username ILIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
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

  def invitation_token
    invitation.token if invitation
  end

  def invitation_token=(token)
    self.invitation = Invitation.find_by_token(token)
  end

  # def send_contact_us(message)
  #     @message = message
  #     UserMailer.contact_us(@message, self).deliver
  #     redirect_to root_url, notice: "Message sent! Thanks for your feedback!"
  # end

  # Below are functions from Railscast 359 for storing user data for Twitter auth

  # def self.from_omniauth(auth)
  #   user = where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  #   user.oauth_token = auth["credentials"]["token"]
  #   user.oauth_secret = auth["credentials"]["secret"]
  #   user.save!
  #   user
  # end

  # def self.create_from_omniauth(auth)
  #   create! do |user|
  #     user.provider = auth["provider"]
  #     user.uid = auth["uid"]
  #     user.name = auth["info"]["nickname"]
  #   end
  # end

  # def twitter
  #   if provider == "twitter"
  #     @twitter ||= Twitter::Client.new(oauth_token: oauth_token, oauth_token_secret: oauth_secret)
  #   end
  # end
  
  private
  
  	def create_remember_token
  		self.remember_token = SecureRandom.urlsafe_base64
  	end

    def set_invitation_limit
      self.invitation_limit = 5
    end
end
