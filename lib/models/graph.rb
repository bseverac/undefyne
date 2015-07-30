require 'tools/curses.rb'

module Models
  class Graph
    def initialize(params)
      @width    = params[:width] || 10
      @height   = params[:height] || 10
      @values   = params[:values]
    end

    def get_rows
      @rows = []
      @height.times do |row|
        @rows << get_row(row)
      end
      @rows
    end

    private

    def get_row(row)
      line = Models::Line.new
      line.add get_ordinate_string(row)
      graph_width.times do |col|
        line.add get_graph_string(col, row)
      end
      line
    end

    def get_graph_string(x,y)
      value = if x == 0
        @values[0] if x == 0
      elsif x == graph_width - 1
        @values[-1] if x == graph_width-1
      else
        value = @values[(x/graph_width.to_f*@values.size).to_i]
      end
      return ' ' if value.nil? || value < get_threshold(y)
      '█'
    end

    def get_threshold(y)
      scale = @values.max - @values.min
      cell_threshold = scale / (@height - 1).to_f
      (@height - 1 - y) * cell_threshold + @values.min
    end

    def get_ordinate_string(row)
      string = ''
      if row == @height - 1
        string = min_ordinate_string
      elsif row == 0
        string = max_ordinate_string
      end
      endding = ' '*(ordinate_width - 1 - string.size) + '│'
      string + endding
    end

    def ordinate_width
      max_size_ordinate_value + 1
    end

    def graph_width
      @width - ordinate_width
    end

    def max_size_ordinate_value
      [max_ordinate_string, min_ordinate_string].map(&:size).max
    end

    def max_ordinate_string
      @values.max.to_s
    end
    
    def min_ordinate_string
      @values.min.to_s
    end

    def graph_width
      @width - ordinate_width
    end
  end
end