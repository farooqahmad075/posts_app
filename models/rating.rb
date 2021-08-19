# frozen_string_literal: true

class Rating < Sequel::Model
  plugin :validation_helpers

  many_to_one :post

  def validate
    super
    validates_presence %i[value post_id]
    validates_integer :value
    validates_includes [1, 2, 3, 4, 5], :value
  end

  def after_create
    super
    ratings = post.average_rating * post.total_ratings
    new_average_rating = (ratings + value) / post.total_ratings.next
    post.update(total_ratings: post.total_ratings.next, average_rating: new_average_rating)
  end
end
