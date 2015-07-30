require 'views/window.rb'
require 'models/line.rb'
require 'widgets/graph.rb'
require 'tools/info.rb'

module Widgets
  class SysInfo
    def initialize(width, height, x, y)
      @width = width
      @height = height
      @x = x
      @y = y
      @values = []
      @view          = Views::Window.new(position: :top, border: true, width: width, height: 6, x: x, y: y)
      @graph         = Widgets::Graph.new(@values, @width, @height - @view.height, @x, @y + @view.height)
      @iddle_time    = Time.new(0)
    end

    def draw
      @view.draw
      @graph.draw
    end
    
    def handle
      now = Time.now
      if(@iddle_time < now)
        @iddle_time = now + 2
        @ip       = Tools::Info.ip
        @thermal  = Tools::Info.thermal
        @platform = Tools::Info.platform
        @values << @thermal
      end
      set_lines
      @graph.handle
    end
    
    private

    def set_lines
      lines = []
      lines << Models::Line.new('ip       : ',:green).add("#{@ip}", :white)
      lines << Models::Line.new('thermal  : ',:green).add("#{@thermal}", :white)
      lines << Models::Line.new('platform : ',:green).add("#{@platform}", :white)
      lines << Models::Line.new('next_time : ',:green).add("#{@width}, #{@height - @view.height}, #{@x}, #{@y + @view.height}", :white)
      @view.set_lines lines
    end
  end
end