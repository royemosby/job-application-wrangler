require 'rails_helper'

RSpec.describe Job, type: :model do
  before do
    Contact.destroy_all
    Job.destroy_all
    User.destroy_all
    @user = User.create!(username: "a", password: "a", email: "a@a.a")
  end
  context "existing job" do
    before do
      @job = Job.create!(
        user: @user,
        company: "ReSPECt",
        is_remote: "yes",
        posting_url: "https://www/respect.com/jobs",
        status: "applied",
        title: "front end engineer",
        job_type: "front-end",
        description: "job description here",
        date_posted: Date.parse("2022-03-25"),
        date_applied: Date.parse("2022-03-25")
      )
    end
    it "gets user" do
      expect(@job.user).to eq(@user)
    end
    it "gets all saved values" do
      expect(@job.company).to eq("ReSPECt")
      expect(@job.is_remote).to eq("yes")
      expect(@job.posting_url).to eq("https://www/respect.com/jobs")
      expect(@job.status).to eq("applied")
      expect(@job.title).to eq("front end engineer")
      expect(@job.job_type).to eq("front-end")
      expect(@job.description).to eq("job description here")
      expect(@job.date_posted).to eq(Date.parse("2022-03-25"))
      expect(@job.date_applied).to eq(Date.parse("2022-03-25"))
    end
  end
  context "posting_url or description present" do
    before :each do
      
      @job = Job.create(
        user: @user,
        company: "ReSPECt",
        is_remote: "yes",
        status: "applied",
        title: "front end engineer",
        job_type: "front-end",
        date_posted: Date.parse("2022-03-25")
      )
    end
    it "rejects when posting_url AND description are empty" do
      expect(@job.errors[:description].empty?).to eq(false)
      expect(@job.errors[:posting_url].empty?).to eq(false)
    end
    it "accepts when only posting_url provided" do
      @job.posting_url =  "https://somejob.com"
      expect(@job.save).to eq(true)
    end
    it "accepts when only description provided" do
      @job.description = "nominal description"
      expect(@job.save).to eq(true)
    end
    it "accepts when posting_url AND description provided" do
      @job.posting_url =  "https://somejob.com"
      @job.description = "nominal description"
      expect(@job.save).to eq(true)
    end
  end
  context "when date_applied is used" do
    before :each do
      @job = Job.create(
        user: @user,
        company: "ReSPECt",
        is_remote: "yes",
        status: "applied",
        title: "front end engineer",
        job_type: "front-end",
        description: "description",
        date_posted: Date.parse("2022-03-25")
      )
    end
    it "accepts date_applied equal to date_posted" do
      @job.date_applied = Date.parse("2022-03-25")
      expect(@job.save).to eq(true)
    end
    it "accepts date_applied greater than date_posted" do
      @job.date_applied = Date.parse("2022-03-26")
      expect(@job.save).to eq(true)
    end
    it "rejects date_applied earlier than date_posted" do
      @job.date_applied = Date.parse("2000-01-01")
      @job.save
      expect(@job.save).to eq(false)
    end
    it "rejects status of 'new' when date_applied is used" do
      @job.date_applied = Date.parse("2022-03-26")
      @job.status = "new"
      @job.save
      expect(@job.errors[:status].include?("status cannot be 'new' when date_applied is provided")).to eq(true)
    end
  end
end
  