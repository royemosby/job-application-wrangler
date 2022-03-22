require 'rails_helper'

RSpec.describe "jobs/index", type: :view do
  before(:each) do
    assign(:jobs, [
      Job.create!(
        title: "Title",
        type: "Type",
        company: "Company",
        location: "Location",
        is_remote: "Is Remote",
        status: "Status",
        posting_url: "Posting Url",
        logo_url: "Logo Url",
        description: "Description"
      ),
      Job.create!(
        title: "Title",
        type: "Type",
        company: "Company",
        location: "Location",
        is_remote: "Is Remote",
        status: "Status",
        posting_url: "Posting Url",
        logo_url: "Logo Url",
        description: "Description"
      )
    ])
  end

  it "renders a list of jobs" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "Type".to_s, count: 2
    assert_select "tr>td", text: "Company".to_s, count: 2
    assert_select "tr>td", text: "Location".to_s, count: 2
    assert_select "tr>td", text: "Is Remote".to_s, count: 2
    assert_select "tr>td", text: "Status".to_s, count: 2
    assert_select "tr>td", text: "Posting Url".to_s, count: 2
    assert_select "tr>td", text: "Logo Url".to_s, count: 2
    assert_select "tr>td", text: "Description".to_s, count: 2
  end
end
