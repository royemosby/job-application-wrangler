require 'rails_helper'

RSpec.describe "contacts/new", type: :view do
  before(:each) do
    assign(:contact, Contact.new(
      first_name: "MyString",
      last_name: "MyString",
      contact_type: "",
      email: "MyString",
      url: "MyString",
      phone: "MyString",
      notes: "MyText"
    ))
  end

  it "renders new contact form" do
    render

    assert_select "form[action=?][method=?]", contacts_path, "post" do

      assert_select "input[name=?]", "contact[first_name]"

      assert_select "input[name=?]", "contact[last_name]"

      assert_select "input[name=?]", "contact[contact_type]"

      assert_select "input[name=?]", "contact[email]"

      assert_select "input[name=?]", "contact[url]"

      assert_select "input[name=?]", "contact[phone]"

      assert_select "textarea[name=?]", "contact[notes]"
    end
  end
end
