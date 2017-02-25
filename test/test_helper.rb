# file: test/test_helper.rb
require 'minitest/autorun'
require 'minitest/reporters' # requires the gem

Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new
