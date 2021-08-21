# frozen_string_literal: true

namespace '/api/v1' do
  before do
    content_type 'application/json'
  end

  post '/ratings' do
    request_params = json_params.slice('post_id', 'value')
    rating = Rating.new(request_params)
    begin
      rating.save
      rating_creation_response(rating)
    rescue Sequel::ValidationFailed
      build_ue_response(rating.errors)
    rescue Sequel::ForeignKeyConstraintViolation => e
      build_ue_response(e.message)
    end
  end

  def json_params
    JSON.parse(request.body.read)
  rescue JSON::ParserError => e
    build_ue_response(e.message)
  end
end

def rating_creation_response(rating)
  data = {
    post: {
      average_rating: rating.post.average_rating
    }
  }

  build_ok_response(data)
end
