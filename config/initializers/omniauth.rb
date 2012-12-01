Rails.application.config.middleware.use OmniAuth::Builder do
	provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']
    provider "soundcloud", ENV['SOUNDCLOUD_CLIENT_ID'], ENV['SOUNDCLOUD_CLIENT_SECRET']
end