# frozen_string_literal: true

require 'spec_helper'

RSpec.describe(Post, type: :model) do
  describe 'validations' do
    let(:post) { FactoryBot.create(:post) }

    it 'should ensure that post is valid' do
      expect(post.valid?).to be_truthy
    end

    it 'should ensure that post is invalid' do
      post.title = nil
      post.content = ''
      expect(post.valid?).not_to be_truthy
      expect(post.errors[:title]).to(include('is not present'))
      expect(post.errors[:title]).to(include('is shorter than 1 characters'))
      expect(post.errors[:content]).to(include('is not present'))
      expect(post.errors[:content]).to(include('is shorter than 1 characters'))
    end

    it 'should ensure average rating remains between 1 to 5' do
      post.average_rating = 5.1
      expect(post.valid?).not_to be_truthy
      expect(post.errors[:average_rating]).to(include('is not <= 5.0'))
      post.average_rating = -0.1
      expect(post.valid?).not_to be_truthy
      expect(post.errors[:average_rating]).to(include('is not >= 0.0'))
    end
  end
end
