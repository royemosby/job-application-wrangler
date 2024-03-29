require 'rails_helper'

RSpec.describe "contacts/edit", type: :view do
  before(:each) do
    @contact = assign(:contact, Contact.create!(
      first_name: "MyString",
      last_name: "MyString",
      type: "",
      email: "MyString",
      url: "MyString",
      phone: "MyString",
      notes: "MyText"
    ))
  end

  it "renders the edit contact form" do
    render

    assert_select "form[action=?][method=?]", contact_path(@contact), "post" do

      assert_select "input[name=?]", "contact[first_name]"

      assert_select "input[name=?]", "contact[last_name]"

      assert_select "input[name=?]", "contact[type]"

      assert_select "input[name=?]", "contact[email]"

      assert_select "input[name=?]", "contact[url]"

      assert_select "input[name=?]", "contact[phone]"

      assert_select "textarea[name=?]", "contact[notes]"
    end
  end
end
