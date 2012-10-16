class Repost < ActiveRecord::Base
  # belongs_to :user, :class_name => 'user', :foreign_key => "user_id"
  # belongs_to :micropost, :class_name => "micropost", :foreign_key => "id"
  belongs_to :retweeter, :class_name => "user"
  belongs_to :retweet, :class_name => "micropost"
end
