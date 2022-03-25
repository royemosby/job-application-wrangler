require 'rails_helper'

RSpec.describe "jobs/show", type: :view do
  before(:each) do
    @job = assign(:job, Job.create!(
      title: "Title",
      job_type: "Job Type",
      company: "Company",
      location: "Location",
      is_remote: "Is Remote",
      status: "Status",
      posting_url: "Posting Url",
      logo_url: "Logo Url",
      description: "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Job Type/)
    expect(rendered).to match(/Company/)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/Is Remote/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/Posting Url/)
    expect(rendered).to match(/Logo Url/)
    expect(rendered).to match(/Description/)
  end
end
