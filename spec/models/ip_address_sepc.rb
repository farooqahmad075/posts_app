# frozen_string_literal: true

require 'spec_helper'

RSpec.describe(IpAddress, type: :model) do
  describe 'validations' do
    let(:ip_address) { FactoryBot.create(:ip_address) }

    it 'should ensure that ip_address is valid' do
      expect(ip_address.valid?).to be_truthy
      expect(ip_address.post_id).to be_present
    end

    it 'should ensure that ip_address is invalid' do
      ip_address.ip = nil
      expect(ip_address.valid?).not_to be_truthy
      expect(ip_address.errors[:ip]).to(include('is not present'))
      ip_address.ip = '1.1.1.x'
      expect(ip_address.valid?).not_to be_truthy
      expect(ip_address.errors[:ip]).to(include('is invalid'))
      ip_address.ip = '.1.1'
      expect(ip_address.valid?).not_to be_truthy
      expect(ip_address.errors[:ip]).to(include('is shorter than 7 characters'))
      ip_address.ip = '255.255.255.1255'
      expect(ip_address.valid?).not_to be_truthy
      expect(ip_address.errors[:ip]).to(include('is longer than 15 characters'))
    end
  end
end
