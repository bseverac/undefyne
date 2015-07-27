#!/usr/bin/env ruby

require_relative "../views/notices.rb"
require_relative "../views/window.rb"
require_relative "../controllers/command.rb"
require_relative "../models/input.rb"

module States
  class Test
    def initialize
      @notices = Views::Notices.new
      @command_input = Models::Input.new
      @command_controller = Controllers::Command.new @command_input
      @command_view = Views::Window.new(position: :bottom, border: true, width: :max)
    end

    def draw
      @notices.draw
      @command_view.draw
    end
    
    def handle_controller
      @command_controller.handle_controller
      set_values
    end

    def set_values
      @command_view.set_lines ["> #{@command_input.string}"]
    end
  end
end