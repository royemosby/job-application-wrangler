class ContactSerializer
  include JSONAPI::Serializer

  attributes :first_name, 
              :last_name,
              :contact_type,
              :email,
              :url,
              :phone,
              :notes,
              :updated_at

  has_many :jobs
  belongs_to :user

end
