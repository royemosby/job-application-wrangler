class Job < ApplicationRecord

  belongs_to :contact, optional: true
  belongs_to :user

  before_validation :set_date_posted_if_empty

  validates :company, presence: true
  validates :date_posted, presence: true
  validates :is_remote, presence: true
  validates :is_remote, inclusion: {in: ["remote", "in-person", "hybrid"]}
  validates :logo_url, url: {allow_blank: true}
  validates :posting_url, url: {allow_blank: true}
  validates :status, presence: true
  validates :status, inclusion: {in: ["new", "applied", "interviewing", "offer", "accepted", "rejected", "declined", "closed"]}
  validates :title, presence: true
  validates :job_type, presence: true
  validates :job_type, inclusion: {in: ["front-end", "back-end", "full-stack", "other"]}

  validate :adequate_info, :validate_date_applied, :validate_appropriate_status_when_date_applied_used

  private
  
    def adequate_info
      message = 'a posting_url or description must be provided'
      unless description || posting_url
        errors.add :description, message
        errors.add :posting_url, message
      end
    end

    def validate_date_applied
      if date_applied
        unless date_applied >= date_posted
          errors.add :date_applied, "date_applied must be same or greater than date_posted"
        end
      end
    end

    def validate_appropriate_status_when_date_applied_used
      if date_applied
        if status === "new"
          errors.add :status, "status cannot be 'new' when date_applied is provided"
        end
      end
    end

    def set_date_posted_if_empty
      unless(date_posted)
        self.date_posted = Date.today
      end
    end

end
