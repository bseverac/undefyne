module Models
  class Word
    attr_reader :string, :color
    
    def initialize(string, color = :white)
      @string = string
      @color = color
    end
  end
end