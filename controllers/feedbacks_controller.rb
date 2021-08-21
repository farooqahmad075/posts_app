# frozen_string_literal: true

namespace '/api/v1' do
  before do
    content_type 'application/json'
  end

  post '/feedbacks' do
    params = prepare_feedback_params

    check_resource_presense(params[:feedbackable_id], params[:feedbackable_type])

    feedback = Feedback.new(params)

    begin
      feedback.save
      feedback_creation_response(feedback)
    rescue Sequel::ValidationFailed
      build_ue_response(feedback.errors)
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

def prepare_feedback_params
  params = json_params.slice('post_id', 'user_id', 'comment', 'owner_id')
  only_one_resource_allowed(params)

  resource_id = 'post_id' if params.key?('post_id')
  resource_id = 'user_id' if params.key?('user_id')

  build_ue_response('Invalid resource id') unless resource_id

  resource_type = resource_id.capitalize[0..-4]

  params.merge!({
                  feedbackable_id: params.delete(resource_id),
                  feedbackable_type: resource_type
                })
end

def only_one_resource_allowed(params)
  build_ue_response('Either user_id or post_id allowed') if params.key?('user_id') && params.key?('post_id')
end

def check_resource_presense(id, type)
  build_ue_response("#{type} doesn't exists for id: #{id}") unless Module.const_get(type).find(id: id)
end

def feedback_creation_response(feedback)
  json_array = feedback.owner.given_feedbacks.map { |fdbk| FeedbackSerializer.new(fdbk).to_json }
  data = {
    owner: UserSerializer.new(feedback.owner).to_json,
    feedbacks: json_array
  }

  build_ok_response(data)
end
