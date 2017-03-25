json.extract! eligibility, :id, :schedule_id, :branch, :cgpa_min, :cgpa_max, :package_min, :package_max, :comments, :skills, :created_at, :updated_at
json.url eligibility_url(eligibility, format: :json)
