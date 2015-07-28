require 'views/window.rb'
require 'models/input.rb'
require 'models/line.rb'
require 'controllers/command.rb'

module Widgets
  class Command
    def initialize
      @model_input   = Models::Input.new
      @controller    = Controllers::Command.new @model_input
      @view          = Views::Window.new(position: :bottom, border: true, width: :max, color: :red)
    end

    def draw
      @view.draw
    end
    
    def handle
      @controller.handle
      set_values
    end
    
    private

    def set_values
      @view.set_lines [Models::Line.new('> ',:red).add("#{@model_input.string}", :white)]
    end
  end
end