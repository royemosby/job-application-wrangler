require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    Contact.destroy_all
    Job.destroy_all
    User.destroy_all
  end
  context "existing user" do
    before do
      @user = User.create!(email: "user@usertest.com", username: "usertest", password: "test", gh_uid: "123")
    end
  
    it "gets saved values (except pw hash)" do
      expect(@user.email).to eq("user@usertest.com")
      expect(@user.username).to eq("usertest")
      expect(@user.gh_uid).to eq("123")
    end
    it "authenticates user with password" do
      expect(!!@user.authenticate("test")).to eq(true)
    end
    it "fails to authenticate user with incorrect password" do
      expect(!@user.authenticate("incorrect")).to eq(true)
    end
  end

  context "new user" do
    before do
      @user = User.create()
      @user2 = User.create(username: "user2", email: "user@user.com", password: "test", gh_uid: "123")
    end
    it "rejects without email" do
      expect(@user.errors[:email].include?("can't be blank")).to eq(true)
    end
    it "rejects invalid email" do
      @user.email = "nope"
      expect(@user.errors[:email].include?("is invalid")).to eq(true)
    end
    it "rejects without username" do
      expect(@user.errors[:username].empty?).to eq(false)
    end
    it "rejected without password" do
      expect(@user.errors[:password].empty?).to eq(false)
    end
    it "rejects using existing username" do
      @user.username = "user2"
      @user.save
      expect(@user.errors[:username].empty?).to eq(false)
    end
    it "rejects using existing gh_uid" do
      @user.gh_uid = "123"
      @user.save
      expect(@user.errors[:gh_uid].empty?).to eq(false)
    end
  end
end
