#!/usr/bin/env ruby

require "curses"
require 'singleton'

module Tools
  class Curses
    include Singleton

    def init
      ::Curses.init_screen
      ::Curses.start_color
      ::Curses.cbreak
      ::Curses.noecho
      ::Curses.timeout = 0
      ::Curses.stdscr.keypad true
      ::Curses.curs_set 0
      init_colors
    end
    
    def width
      ::Curses.cols
    end
    
    def height
      ::Curses.lines
    end

    def color_hash
      {
        blue:    ::Curses::COLOR_BLUE,
        cyan:    ::Curses::COLOR_CYAN,
        green:   ::Curses::COLOR_GREEN,
        magenta: ::Curses::COLOR_MAGENTA,
        red:     ::Curses::COLOR_RED,
        white:   ::Curses::COLOR_WHITE,
        yellow:  ::Curses::COLOR_YELLOW
      }
    end

    def init_colors
      color_hash.each do |key, color|
        init_color(color)
      end
    end

    def init_color(color)
      ::Curses.init_pair(color, color, ::Curses::COLOR_BLACK)
    end

    def refresh
      ::Curses.refresh
      ::Curses.clear
    end

    def get_c
      ::Curses.getch
    end

    def exit
      ::Curses.close_screen
    end

    def color(sym)
      color = color_hash.has_key?(sym) ? color_hash[sym] : sym.to_s.to_i
      ::Curses.color_pair(color)
    end
  end
end