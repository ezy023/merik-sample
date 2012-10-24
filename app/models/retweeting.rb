class Retweeting < ActiveRecord::Base
  attr_accessible :retweet_id, :retweeter_id

  belongs_to :retweeter, :class_name => 'User'
  belongs_to :retweet, :class_name => 'Micropost'

# DOUBLE CHECK, BUT CAN PROBABLY BE DELETED
 #  default_scope order: 'retweetings.updated_at DESC'
 

 #  def self.from_users_followed_by(user)
 #  	followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
 #  	retweet_post_ids = "SELECT retweet_id FROM retweetings WHERE retweeter_id IN (#{followed_user_ids})"
	# # retweeter_post_ids = "SELECT retweet_id FROM retweetings WHERE retweeter_id = :user_id"
	# Micropost.where("id IN (#{retweet_post_ids})", user_id: user)
 #  end

 #  def self.from_users_retweets(user)
 #  	retweeter_post_ids = "SELECT retweet_id FROM retweetings WHERE retweeter_id = :user_id"
	# Micropost.where("id IN (#{retweeter_post_ids})", user_id: user)
 #  end

end
