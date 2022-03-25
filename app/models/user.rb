class User < ApplicationRecord
  has_secure_password

  has_many :contacts
  has_many :jobs

  validates :email, presence: true
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :gh_uid, uniqueness: true
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, format: {with: /\A([a-zA-Z]|\d|_|-)*\z/, message: "only letters, numbers, dash or underscores allowed in usernames"}

end
