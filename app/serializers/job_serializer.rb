class JobSerializer
  include JSONAPI::Serializer

  attributes  :id,
              :title,
              :job_type,
              :company,
              :location,
              :is_remote,
              :status,
              :posting_url,
              :logo_url,
              :date_posted,
              :description,
              :notes,
              :date_applied,
              :contact_id

  attribute :updated_at do |obj|
    {date: obj.updated_at.strftime("%F"),
      time: obj.updated_at.strftime("%l:%M %p")}
  end

  belongs_to :user
  belongs_to :contact

end
