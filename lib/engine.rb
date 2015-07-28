require 'curses'
require 'singleton'
require 'tools/curses.rb'

class Engine
  include Singleton  
  def init
    Tools::Curses.instance.init
    @current_state = nil
  end
  
  def switch_state state
  	@current_state = state
  end

  def start
    @next = Time.now
    while true
      if @next <= Time.now
        step if @current_state
        @next = Time.now + 0.1
      end
    end
  end

  def step
    handle
    draw
  end
  
  def draw
  	@current_state.draw
  end

  def handle
  	@current_state.handle
  end
end

