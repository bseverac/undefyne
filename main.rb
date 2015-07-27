require "./lib/config.rb"
require "engine.rb"
require "states/test.rb"

Engine.instance.init
Engine.instance.switch_state(States::Test.new)
Engine.instance.start
