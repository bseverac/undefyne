#!/usr/bin/env ruby

require "views/notices.rb"
require "widgets/command.rb"
require "widgets/sys_info.rb"

module States
  class Test
    def initialize
      @notices_view = Views::Notices.new
      @command_widget = Widgets::Command.new
      @info_widget = Widgets::SysInfo.new
      Models::Notice.create message: 'Undefyne is now on', time: Time.now + 5, color: :green
    end

    def draw
      @command_widget.draw
      @info_widget.draw
      @notices_view.draw
    end
    
    def handle
      @command_widget.handle
      @info_widget.handle
    end
  end
end