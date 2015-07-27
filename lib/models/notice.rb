require 'models/base.rb'

module Models
  class Notice < Base
    attr_reader :message, :time, :type


    def initialize(params = {})
      @message = params[:message] || ''
      @time    = params[:time]    || Time.now + 1
      @type    = params[:type]    || :notice
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
  end
end