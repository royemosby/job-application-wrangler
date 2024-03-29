require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      username: "Username",
      email: "Email",
      password: "",
      gh_name: "Gh Name",
      gh_email: "Gh Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Username/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Gh Name/)
    expect(rendered).to match(/Gh Email/)
  end
end
