# frozen_string_literal: true

class Post < Sequel::Model
  plugin :validation_helpers
  plugin :association_dependencies
  plugin :polymorphic
  plugin :nested_attributes

  one_to_one :ip_address
  one_to_many :ratings
  one_to_many :feedbacks, as: :feedbackable

  many_to_one :user

  add_association_dependencies ip_address: :destroy, ratings: :destroy, feedbacks: :destroy
  nested_attributes :ip_address

  def validate
    super
    validates_presence %i[title content average_rating total_ratings user_id]
    validates_min_length 1, :title
    validates_min_length 1, :content
    validates_max_length 100, :title
    validates_numeric :average_rating # Float validation
    validates_integer :total_ratings # Integer validation
    validates_operator(:>=, 0.0, :average_rating)
    validates_operator(:<=, 5.0, :average_rating)
    validates_operator(:>=, 0, :total_ratings)
  end

  def before_validation
    self.average_rating ||= 0.0
    self.total_ratings ||= 0
    super
  end
end
