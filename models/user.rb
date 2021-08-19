# frozen_string_literal: true

class User < Sequel::Model
  plugin :validation_helpers
  plugin :association_dependencies
  plugin :polymorphic

  one_to_many :posts
  one_to_many :given_feedbacks, key: :owner_id, class: 'Feedback'
  one_to_many :feedbacks, as: :feedbackable

  add_association_dependencies posts: :destroy, given_feedbacks: :destroy, feedbacks: :destroy

  def validate
    super
    validates_presence :username
    validates_unique :username
    validates_min_length 3, :username
    validates_max_length 25, :username
  end
end
