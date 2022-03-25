json.extract! job, :id, :title, :job_type, :company, :location, :is_remote, :status, :posting_url, :logo_url, :date_posted, :description, :created_at, :updated_at
json.url job_url(job, format: :json)
