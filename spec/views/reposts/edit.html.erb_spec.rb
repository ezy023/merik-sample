require 'spec_helper'

describe "reposts/edit" do
  before(:each) do
    @repost = assign(:repost, stub_model(Repost,
      :content => "MyString",
      :user_id => 1,
      :micropost_id => 1,
      :micropost_id => "MyString",
      :created_at => "MyString"
    ))
  end

  it "renders the edit repost form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reposts_path(@repost), :method => "post" do
      assert_select "input#repost_content", :name => "repost[content]"
      assert_select "input#repost_user_id", :name => "repost[user_id]"
      assert_select "input#repost_micropost_id", :name => "repost[micropost_id]"
      assert_select "input#repost_micropost_id", :name => "repost[micropost_id]"
      assert_select "input#repost_created_at", :name => "repost[created_at]"
    end
  end
end
