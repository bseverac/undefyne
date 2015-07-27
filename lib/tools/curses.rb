#!/usr/bin/env ruby

require "curses"
require "color"
require 'singleton'

module Tools
  class Curses
    include Singleton
    
    def osx?
      (/darwin/ =~ RUBY_PLATFORM) != nil
    end

    def init
      @colors = {}
      ::Curses.init_screen
      ::Curses.start_color
      ::Curses.crmode
      ::Curses.noecho
      ::Curses.timeout = 0
      ::Curses.stdscr.keypad true
      ::Curses.curs_set 0
      ::Curses.flash
      ::Curses.beep
      init_colors unless osx?
    end
    
    def init_colors
      @num_color = 1
      init_color(:red_500, '#F44336')
      init_color(:pink_500, '#E91E63')
      init_color(:purple_500, '#9C27B0')
      init_color(:deep_purple_500, '#673AB7')
      init_color(:indigo_500, '#3F51B5')
      init_color(:blue_500, '#2196F3')
      init_color(:light_blue_500, '#03A9F4')
      init_color(:cyan_500, '#00BCD4')
      init_color(:teal_500, '#009688')
      init_color(:green_500, '#4CAF50')
      init_color(:light_green_500, '#8BC34A')
      init_color(:lime_500, '#CDDC39')
      init_color(:yellow_500, '#FFEB3B')
      init_color(:amber_500, '#FFC107')
      init_color(:orange_500, '#FF9800')
      init_color(:deep_orange_500, '#FF5722')
      init_color(:brown_500, '#795548')
      init_color(:grey_500, '#9E9E9E')
      init_color(:blue_grey_500, '#607D8B')
      init_color(:white, '#FFFFFF')
    end

    def init_color(name, css)
      color = Color::RGB.by_css(css)
      ::Curses.init_color(@num_color, color.r, color.g, color.b)
      @colors[name] = @num_color
      ::Curses.init_pair(@num_color, @num_color, ::Curses::COLOR_BLACK)
      @num_color += 1
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
      ::Curses.color_pair(@colors.has_key?(sym) ? @colors[sym] : 0)
    end
  end
end