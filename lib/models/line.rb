 require 'models/word.rb'
 module Models 
  class Line
    attr_reader :words

    def initialize(string = nil, color = nil)
      clear
      add(string, color) if string
    end
    
    def size
      @words.map(&:string).map(&:size).reduce(:+)
    end

    def add(string, color = :white)
      @words << Word.new(string, color)
      self
    end

    def to_s
      @words.map(&:string).reduce(:+)
    end

    def clear
      @words = []
    end
  end
end