json.extract! lesson, :id, :title, :date, :visible, :notes, :homework, :slides, :created_at, :updated_at
json.url lesson_url(lesson, format: :json)
