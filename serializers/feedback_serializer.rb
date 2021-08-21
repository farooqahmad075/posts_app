# frozen_string_literal: true

class FeedbackSerializer
  def initialize(feedback)
    @feedback = feedback
  end

  def to_json(*)
    {
      resource_id: @feedback.feedbackable_id,
      resource_type: @feedback.feedbackable_type,
      comment: @feedback.comment
    }
  end
end
