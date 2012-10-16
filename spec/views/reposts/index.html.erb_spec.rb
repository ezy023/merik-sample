require 'spec_helper'

describe "reposts/index" do
  before(:each) do
    assign(:reposts, [
      stub_model(Repost,
        :content => "Content",
        :user_id => 1,
        :micropost_id => 2,
        :micropost_id => "Micropost",
        :created_at => "Created At"
      ),
      stub_model(Repost,
        :content => "Content",
        :user_id => 1,
        :micropost_id => 2,
        :micropost_id => "Micropost",
        :created_at => "Created At"
      )
    ])
  end

  it "renders a list of reposts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Content".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Micropost".to_s, :count => 2
    assert_select "tr>td", :text => "Created At".to_s, :count => 2
  end
end
