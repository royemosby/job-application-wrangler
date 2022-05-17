def f_first_name
  Faker::Name::first_name
end

def f_last_name
  Faker::Name::last_name
end

def f_gh_uid
  Faker::Internet.uuid
end

def f_username(first, last)
  first + "-" + last
end

def f_email(first, last)
  Faker::Internet.safe_email(name: "#{first.chars.first}.#{last}")
end

@job_types = %w(front-end back-end full-stack other)
@is_remote = ["remote", "in-person", "hybrid"]
@contact_type = ["recruiter", "personal", "peer", "manager", "employee", "flatiron alumni", "other"]

def create_job(user)
  Job.create!(
    user: user,
    title: Faker::Job.title,
    location: "#{Faker::Address.city}, #{Faker::Address.state_abbr}",
    job_type: @job_types[rand(4)],
    company: Faker::Company.name,
    is_remote: @is_remote[rand(3)],
    posting_url: Faker::Internet.url,
    status: "new",
    date_posted: Faker::Date.between(from: '2022-01-01', to: '2022-03-25'),
    description: Faker::TvShows::DrWho.quote,
    date_applied: nil
  )
end

def create_contact(user, job = nil)
  first = f_first_name
  last = f_last_name
  contact = Contact.create!(
    user: user,
    first_name: first,
    last_name: last,
    contact_type: @contact_type[rand(7)],
    email: f_email(first, last),
    url: Faker::Internet.url,
    phone: "345-345-2345",
    notes: Faker::TvShows::DrWho.quote
  )
  if job
    contact.jobs << job
  end
end


def create_user
  first = f_first_name
  last = f_last_name
  username = f_username(first, last)
  gh_uid = f_gh_uid
  email = f_email(first, last)
  User.create!(
    username: username,
    password: "password",
    gh_uid: gh_uid,
    email: email
  )
end

def create_test_user
  username = "test"
  email = "roy.e.mosby@gmail.com"
  User.create!(
    username: username,
    password: "test",
    email: email
  )
end

fend_test_user = create_test_user

## increments job index so job and contact indicies dont equal same in relations
create_job(fend_test_user)

5.times do
  user = create_user
  3.times do
    create_job(user)
    create_contact(user)
    create_job(fend_test_user)
    create_contact(fend_test_user)
  end
  2.times do
    job = create_job(user)
    test_job = create_job(fend_test_user)
    create_contact(user, job)
    create_contact(fend_test_user, test_job)
  end
end
