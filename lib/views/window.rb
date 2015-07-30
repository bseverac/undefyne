require 'tools/curses.rb'

module Views
  class Window
    def initialize(params)
      @lines    = []
      @align    = params[:align]                              || :left
      @position = params[:position]                           || :top
      @border   = params[:border]                             || :none
      @width    = params[:width]                              || :fit
      @height   = params[:height]                             || :fit
      @color    = Tools::Curses.instance.color(params[:color] || :white)
      @x        = params[:x] || 0
      @y        = params[:y] || 0
    end

    def draw
      set_window_aspect
      @lines.each_with_index do |line, index|
        draw_line(line, index)
      end
      close_window if @lines.empty? && @height == :fit
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
    
    def width
      case @width
        when :fit then lines_max_width + padding
        when :max then Tools::Curses.instance.width
        else @width
      end
    end

    def height
      return @lines.size + padding if @height == :fit
      @height
    end

    def y
      case @position
        when :top then 0
        when :bottom then Tools::Curses.instance.height - height
        else @y
      end
    end

    def x
      case @align
        when :left then 0
        when :center then (Tools::Curses.instance.width - width)/2
        else @x
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
    
    def padding
      border? ? 2 : 1
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