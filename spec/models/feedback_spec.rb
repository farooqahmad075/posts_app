# frozen_string_literal: true

require 'spec_helper'

RSpec.describe(Feedback, type: :model) do
  describe 'validations' do
    let(:user_feedback) { FactoryBot.create(:feedback, :user_feedback) }
    let(:post_feedback) { FactoryBot.create(:feedback, :post_feedback) }

    it 'should ensure that post is valid' do
      expect(user_feedback.valid?).to be_truthy
      expect(post_feedback.valid?).to be_truthy
    end

    it 'should ensure that user_feedback is invalid' do
      user_feedback.comment = nil
      expect(user_feedback.valid?).not_to be_truthy
      expect(user_feedback.errors[:comment]).to(include('is not present'))
      expect(user_feedback.errors[:comment]).to(include('is shorter than 1 characters'))
    end

    it 'should ensure that post_feedback is invalid' do
      post_feedback.comment = nil
      expect(post_feedback.valid?).not_to be_truthy
      expect(post_feedback.errors[:comment]).to(include('is not present'))
      expect(post_feedback.errors[:comment]).to(include('is shorter than 1 characters'))
    end
  end
end
