# frozen_string_literal: true

require 'nokogiri'

class Feedback < Sequel::Model
  plugin :validation_helpers
  plugin :polymorphic

  many_to_one :owner, key: :owner_id, class: 'User'
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

  def self.generate_xml_report
    content = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
      xml.root do
        xml.feedbacks do
          Feedback.eager(:owner).each do |feedback|
            xml.feedback do
              xml.owner feedback.owner.username
              xml.comment_ feedback.comment
              xml.feedback_type feedback.feedbackable_type
              xml.average_rating feedback.feedbackable_type == 'User' ? [] : feedback.feedbackable.average_rating
            end
          end
        end
      end
    end
    File.write("xml_reports/#{Time.now.strftime('%Y%m%d%H%M%S')}_feedback_report.xml", content.to_xml)
  end
end
