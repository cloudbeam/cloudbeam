json.extract! document, :id, :name, :uploaded_at, :expired_at, :url, :user_id, :created_at, :updated_at
json.url document_url(document, format: :json)
