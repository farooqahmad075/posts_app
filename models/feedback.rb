# frozen_string_literal: true

class Feedback < Sequel::Model
  plugin :validation_helpers
  plugin :polymorphic

  many_to_one :owner, key: :owner_id, class: 'Feedback'
  many_to_one :feedbackable, polymorphic: true

  def validate
    super
    errors.add(:owner_id, 'Self Feedback not allowed') if self_feedback_error
    validates_presence %i[feedbackable_id feedbackable_type comment owner_id]
    validates_unique %i[feedbackable_id feedbackable_type owner_id], message: 'Duplicate feedback from same owner'
    validates_includes %w[User Post], :feedbackable_type
    validates_min_length 1, :comment
  end

  def self_feedback_error
    feedbackable_id == owner_id && feedbackable_type == owner.class.to_s
  end
end
