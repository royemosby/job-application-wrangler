class UserSerializer
  include JSONAPI::Serializer

  attributes :username, :email

  attribute :created_at do |obj|
    obj.created_at.strftime("%F")
  end

  has_many :jobs
  has_many :contacts

end
