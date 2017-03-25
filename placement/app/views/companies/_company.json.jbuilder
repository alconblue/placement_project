json.extract! company, :id, :name, :email, :user_id, :description, :poc_name, :poc_email, :poc_phone, :created_at, :updated_at
json.url company_url(company, format: :json)
