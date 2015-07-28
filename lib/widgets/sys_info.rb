require 'views/window.rb'
require 'models/line.rb'
require 'tools/info.rb'

module Widgets
  class SysInfo
    def initialize
      @view          = Views::Window.new(position: :top, border: true, width: :max)
      @iddle_time    = Time.new(0)
    end

    def draw
      @view.draw
    end
    
    def handle
      now = Time.now
      if(@iddle_time < now)
        @iddle_time = now + 15
        @ip       = Tools::Info.ip
        @thermal  = Tools::Info.thermal
        @platform = Tools::Info.platform
      end
      set_lines
    end
    
    private

    def set_lines
      lines = []
      lines << Models::Line.new('ip       : ',:green).add("#{@ip}", :white)
      lines << Models::Line.new('thermal  : ',:green).add("#{@thermal}", :white)
      lines << Models::Line.new('platform : ',:green).add("#{@platform}", :white)
      lines << Models::Line.new('next_time : ',:green).add("#{(@iddle_time - Time.now).to_i}", :white)
      @view.set_lines lines
    end
  end
end