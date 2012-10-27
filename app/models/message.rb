class Message
  include ActiveAttr::Model
  
  attribute :name
  attribute :email
  attribute :subject
  attribute :content
  attribute :priority
  
  attr_accessible :name, :email, :content, :subject

  validates_presence_of :name, :subject
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_length_of :content, :maximum => 500
end