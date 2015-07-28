require 'tools/curses.rb'

module Views
  class Window
    def initialize(params)
      @lines    = []
      @align    = params[:align]                              || :left
      @position = params[:position]                           || :top
      @border   = params[:border]                             || :none
      @width    = params[:width]                              || :fit
      @color    = Tools::Curses.instance.color(params[:color] || :white)
    end

    def draw
      set_window_aspect
      @lines.each_with_index do |line, index|
        draw_line(line, index)
      end
      close_window if @lines.empty?
      refresh
    end
    
    def set_lines lines
      @lines = lines
    end
    
    def close_window
      if @window
        @window.close 
        @window = nil
      end
    end

    private

    def border?
      @border != :none
    end

    def window
      @window ||= Curses::Window.new(0, 0, 0, 0)
    end
    
    def lines_max_width
      @lines.map(&:size).max || 0
    end

    def width
      case @width
        when :fit then lines_max_width + padding
        when :max then Curses.cols
        else raise "Views::Window width: #{@width} bad parameter"
      end
    end
    
    def padding
      border? ? 2 : 1
    end

    def height
      @lines.size + padding
    end

    def y
      case @position
        when :top then 0
        when :bottom then Curses.lines - height
        else raise "Views::Window position: '#{@position}' bad parameter"
      end
    end

    def x
      case @align
        when :left then 0
        when :center then (Curses.cols - width)/2
        else raise "Views::Window align: '#{@align}' bad parameter"
      end
    end

    def set_window_aspect
      #refresh
      window.resize(height, width)
      window.box(0,0) if border?
      window.move y, x
    end
    
    def draw_line(line, index)
      window.setpos(index + 1, 1)
      line.words.each do |word|
        window.attron(Tools::Curses.instance.color(word.color)){
          window.addstr word.string
        }
      end
    end

    def refresh
      window.noutrefresh
      window.refresh
      window.clear
    end
  end
end