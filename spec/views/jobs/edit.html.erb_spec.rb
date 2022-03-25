require 'rails_helper'

RSpec.describe "jobs/edit", type: :view do
  before(:each) do
    @job = assign(:job, Job.create!(
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

  it "renders the edit job form" do
    render

    assert_select "form[action=?][method=?]", job_path(@job), "post" do

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
