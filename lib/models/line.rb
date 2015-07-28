 require 'models/word.rb'
 module Models 
  class Line
    attr_reader :words

    def initialize(string, color)
      clear
      add(string, color)
    end
    
    def size
      @words.map(&:string).map(&:size).reduce(:+)
    end

    def add(string, color)
      @words << Word.new(string, color)
      self
    end

    def clear
      @words = []
    end
  end
end