require 'rails_helper'
require 'validate_url'

RSpec.describe Contact, type: :model do
  before do
    Contact.destroy_all
    Job.destroy_all
    User.destroy_all
    @user = User.create!(username: "a", password: "a", email: "a@a.a")
  end
  context "existing contact" do
    before do
      @contact = Contact.create!(user: @user,
                              first_name: "fred",
                              last_name: "smith",
                              contact_type: "recruiter",
                              email: "email@email.com",
                              url: "https://li.com/fsmith",
                              phone: "234-345-3435")
    end
    it "gets user" do
      expect(@contact.user).to eq(@user)
    end
    it "gets contact first_name" do
      expect(@contact.first_name).to eq("fred")
    end
    it "gets contact last_name" do
      expect(@contact.last_name).to eq("smith")
    end
    it "gets contact contact_type" do
      expect(@contact.contact_type).to eq("recruiter")
    end
    it "gets contact email" do
      expect(@contact.email).to eq("email@email.com")
    end
    it "gets contact phone" do
      expect(@contact.phone).to eq("234-345-3435")
    end
  end
  context "new contact" do
    before do
      Contact.destroy_all
      @contact = Contact.create
    end
    it "requires first_name" do
      expect(@contact.errors[:first_name].empty?).to eq(false)
    end
    it "requires last_name" do
      expect(@contact.errors[:last_name].empty?).to eq(false)
    end
    it "requires contact_type" do
      expect(@contact.errors[:contact_type].empty?).to eq(false)
    end
    it "accepts valid contact_type" do
      @contact.contact_type = "recruiter"
      @contact.save
      expect(@contact.errors[:contact_type].empty?).to eq(true)
    end
    it "rejects invalid contact_type" do
      @contact.contact_type = "invalid"
      @contact.save
      expect(@contact.errors[:contact_type].empty?).to eq(false)
    end
    it "accepts valid phone format XXX-XXX-XXXX" do
      @contact.phone = "333-333-3333"
      @contact.save
      expect(@contact.errors[:phone].empty?).to eq(true)
    end
    it "accepts valid phone format (XXX)XXX-XXXX" do
      @contact.phone = "(333)333-3333"
      @contact.save
      expect(@contact.errors[:phone].empty?).to eq(true)
    end
    it "rejects invalid phone" do
      @contact.phone = "(333)-333-3333"
      @contact.save
      expect(@contact.errors[:phone].empty?).to eq(false)
    end
  end
end
