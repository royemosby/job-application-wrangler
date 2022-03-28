class Contact < ApplicationRecord

  has_many :jobs
  belongs_to :user

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :contact_type, presence: true
  validates :contact_type, inclusion: {in: ["recruiter", "personal", "peer", "manager", "employee", "flatiron alumni", "other"]}
  validates :url, url: {allow_blank: true}

  validate :validate_optional_email,
    :validate_optional_phone

  def validate_optional_email
    if email.present?
      unless !!email.match(URI::MailTo::EMAIL_REGEXP)
        errors.add :email, 'email must either be empty or in valid format'
      end
    end
  end

  def validate_optional_phone
    if phone.present?
      # this isn't following NANP but good enough
      # TODO: handle extensions w/format "x123.."
      unless !!phone.match(/\A(\d{3}-|\(\d{3}\))\d{3}-\d{4}\z/)
        errors.add :phone, 'phone must be empty or in the following formats: nnn-nnn-nnnn or (nnn)nnn-nnnn. Place international numbers in notes.'
      end
    end
  end

end
