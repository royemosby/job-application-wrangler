require 'rails_helper'

RSpec.describe "jobs/new", type: :view do
  before(:each) do
    assign(:job, Job.new(
      title: "MyString",
      job_type: "",
      company: "MyString",
      location: "MyString",
      is_remote: "MyString",
      status: "MyString",
      posting_url: "MyString",
      logo_url: "MyString",
      description: "MyString"
    ))
  end

  it "renders new job form" do
    render

    assert_select "form[action=?][method=?]", jobs_path, "post" do

      assert_select "input[name=?]", "job[title]"

      assert_select "input[name=?]", "job[job_type]"

      assert_select "input[name=?]", "job[company]"

      assert_select "input[name=?]", "job[location]"

      assert_select "input[name=?]", "job[is_remote]"

      assert_select "input[name=?]", "job[status]"

      assert_select "input[name=?]", "job[posting_url]"

      assert_select "input[name=?]", "job[logo_url]"

      assert_select "input[name=?]", "job[description]"
    end
  end
end
