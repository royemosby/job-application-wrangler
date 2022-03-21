require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        username: "Username",
        email: "Email",
        password: "",
        gh_name: "Gh Name",
        gh_email: "Gh Email"
      ),
      User.create!(
        username: "Username",
        email: "Email",
        password: "",
        gh_name: "Gh Name",
        gh_email: "Gh Email"
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", text: "Username".to_s, count: 2
    assert_select "tr>td", text: "Email".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: "Gh Name".to_s, count: 2
    assert_select "tr>td", text: "Gh Email".to_s, count: 2
  end
end
