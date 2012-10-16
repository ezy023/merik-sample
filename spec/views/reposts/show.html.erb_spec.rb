require 'spec_helper'

describe "reposts/show" do
  before(:each) do
    @repost = assign(:repost, stub_model(Repost,
      :content => "Content",
      :user_id => 1,
      :micropost_id => 2,
      :micropost_id => "Micropost",
      :created_at => "Created At"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Content/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Micropost/)
    rendered.should match(/Created At/)
  end
end
