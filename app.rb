# frozen_string_literal: true

# Initializing the app configurations
%w[config models serializers controllers].each do |dir|
  $LOAD_PATH << File.expand_path('.', File.join(File.dirname(__FILE__), dir))
  require File.join(File.dirname(__FILE__), dir, 'manifest')
end
