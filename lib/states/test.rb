require "views/notices.rb"
require "widgets/command.rb"
require "widgets/sys_info.rb"
require "states/base.rb"

module States
  class Test < States::Base
    def initialize
      @notices_view = Views::Notices.new
      @command_widget = Widgets::Command.new
      @info_widget = Widgets::SysInfo.new(width, height - 3, 0, 0)
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