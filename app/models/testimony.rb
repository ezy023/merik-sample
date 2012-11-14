class Testimony < ActiveRecord::Base
  attr_accessible :content, :screen_name, :tweet_id, :post_id

  def self.pull_tweets(micropost)
  	Twitter.search("##{micropost.hashtag} -rt", :count => 5, :result_type => "recent").results.each do |tweet|
  		unless exists?(tweet_id: tweet.id)
  			create!(
  				tweet_id: tweet.id,
  				content: tweet.text,
  				screen_name: tweet.user.screen_name,
  				post_id: micropost.id,
  				)
  			end
  		end
  	end
end
