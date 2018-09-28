json.extract! secret, :id, :ciphertext, :algorithm, :created_at, :updated_at
json.url secret_url(secret, format: :json)
