require 'rails_helper'

RSpec.describe "contacts/index", type: :view do
  before(:each) do
    assign(:contacts, [
      Contact.create!(
        first_name: "First Name",
        last_name: "Last Name",
        contact_type: "Contact Type",
        email: "Email",
        url: "Url",
        phone: "Phone",
        notes: "MyText"
      ),
      Contact.create!(
        first_name: "First Name",
        last_name: "Last Name",
        contact_type: "Contact Type",
        email: "Email",
        url: "Url",
        phone: "Phone",
        notes: "MyText"
      )
    ])
  end

  it "renders a list of contacts" do
    render
    assert_select "tr>td", text: "First Name".to_s, count: 2
    assert_select "tr>td", text: "Last Name".to_s, count: 2
    assert_select "tr>td", text: "Contact Type".to_s, count: 2
    assert_select "tr>td", text: "Email".to_s, count: 2
    assert_select "tr>td", text: "Url".to_s, count: 2
    assert_select "tr>td", text: "Phone".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
  end
end
