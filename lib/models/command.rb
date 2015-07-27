require 'models/base.rb'

module Models
  class Command < Base
    attr_reader :string

    def initialize(params = {})
      super(params)
      @string = params[:string] || ''
    end
    
    def method
      return nil unless m = @string.match(/^(\w+)(\([\w,\s]*\))?$/)
      m[1]
    end

    def params
      return [] unless m = @string.match(/^\w+\(([\w,\s]*)\)$/)
      m[1].split(',').map &:strip
    end

    def params?
      !params.empty?
    end
  end
end