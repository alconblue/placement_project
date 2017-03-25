json.extract! student, :id, :name, :email, :cgpa, :branch, :roll_number, :mobile_number, :user_id, :gender, :created_at, :updated_at
json.url student_url(student, format: :json)
