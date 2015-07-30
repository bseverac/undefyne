require "tools/curses.rb"

module States
  class Base
    def initialize
    end
    
    def width
      Tools::Curses.instance.width
    end

    def height
      Tools::Curses.instance.height
    end
  end
end