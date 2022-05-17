class ContactSerializer
  include JSONAPI::Serializer

  attributes  :id,
              :first_name, 
              :last_name,
              :contact_type,
              :email,
              :social_url,
              :phone,
              :notes

  attribute :updated_at do |obj|
    {date: obj.updated_at.strftime("%F"),
      time: obj.updated_at.strftime("%l:%M %p")}
  end

  has_many :jobs
  belongs_to :user

end
