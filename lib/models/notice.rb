require 'models/base.rb'
require 'models/line.rb'

module Models
  class Notice < Base
    attr_reader :message, :time, :color


    def initialize(params = {})
      @message = params[:message] || ''
      @time    = params[:time]    || Time.now + 1
      @color   = params[:color]   || :white
    end

    def delete_on_over!
      delete if is_over?
    end

    def is_over?
      Time.now >= @time
    end

    def size
      @message.size
    end

    def line
      Line.new(@message, color)
    end
  end
end