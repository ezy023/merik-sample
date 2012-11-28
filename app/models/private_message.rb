class PrivateMessage < ActiveRecord::Base
  attr_accessible :to, :subject, :body

  is_private_message
  
  # The :to accessor is used by the scaffolding,
  # uncomment it if using it or you can remove it if not
  attr_accessor :to
  
  validates_presence_of :to, :message => "is required", on: :create
  validates_presence_of :subject, :message => "is required", on: :create

end