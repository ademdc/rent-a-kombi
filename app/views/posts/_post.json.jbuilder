json.extract! post, :id, :title, :category, :images, :description, :contact, :created_at, :updated_at
json.url post_url(post, format: :json)
