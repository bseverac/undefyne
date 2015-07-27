#!/usr/bin/env ruby

require 'views/window.rb'
require 'models/notice.rb'

module Views
  class Notices    
    def window
      @notice_window ||= Views::Window.new(border: true, align: :center)
    end
    
    def notices
      Models::Notice.all
    end

    def draw
      window.close_window; return if notices.empty?
      notices.each &:delete_on_over!
      window.set_lines notices.map &:message
      window.draw
    end
  end
end