# frozen_string_literal: true

require_relative '../app'

set :environment, ENV['RACK_ENV']
set :output, 'logs/cron.log'

every :day, at: '09:00AM' do
  runner 'Feedback.generate_xml_report'
end
