require 'views/window.rb'
require 'models/graph.rb'

module Widgets
  class Graph
    def initialize(values, width, height, x, y)
      @view          = Views::Window.new(position: :absolute, border: true, width: width, height: height, x: x, y: y)
      @model_graph   = Models::Graph.new(values: values, width: @view.width - 2, height: @view.height - 2)
    end

    def draw
      @view.draw
    end
    
    def handle
      set_values
    end
    
    private

    def set_values
      @view.set_lines @model_graph.get_rows
    end
  end
end