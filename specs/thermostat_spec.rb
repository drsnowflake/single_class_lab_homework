require('minitest/autorun')
require('minitest/reporters')

require_relative('../thermostat.rb')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class Thermostat < MiniTest::Test
