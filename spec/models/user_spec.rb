# frozen_string_literal: true

require 'spec_helper'

RSpec.describe(User, type: :model) do
  describe 'validations' do
    let(:user) { FactoryBot.create(:user) }

    it 'should ensure that user is valid' do
      expect(user.valid?).to be_truthy
    end

    it 'should ensure that user is invalid' do
      user.username = nil
      expect(user.valid?).not_to be_truthy
      expect(user.errors[:username]).to(include('is not present'))
      expect(user.errors[:username]).to(include('is shorter than 3 characters'))
    end
  end
end
