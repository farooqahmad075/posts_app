# frozen_string_literal: true

class IpAddress < Sequel::Model
  plugin :validation_helpers

  many_to_one :post

  def validate
    super
    validates_presence %i[ip post_id]
    validates_format(/\b(?:\d{1,3}\.){3}\d{1,3}\b/, :ip)
    validates_min_length 7, :ip
    validates_max_length 15, :ip
  end
end
