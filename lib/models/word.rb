module Models
  class Word
    attr_reader :string, :color
    
    def initialize(string, color)
      @string = string
      @color = color
    end
  end
end