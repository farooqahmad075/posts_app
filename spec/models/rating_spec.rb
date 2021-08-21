# frozen_string_literal: true

require 'spec_helper'

RSpec.describe(Rating, type: :model) do
  describe 'validations' do
    let(:rating) { FactoryBot.create(:rating) }

    it 'should ensure that rating is valid' do
      expect(rating.valid?).to be_truthy
    end

    it 'should ensure that rating is invalid' do
      rating.value = 0
      expect(rating.valid?).not_to be_truthy
      expect(rating.errors[:value]).to(include('is not in range or set: [1, 2, 3, 4, 5]'))
      rating.value = 6
      expect(rating.valid?).not_to be_truthy
      expect(rating.errors[:value]).to(include('is not in range or set: [1, 2, 3, 4, 5]'))
    end
  end
end
