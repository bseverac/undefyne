require "tools/curses.rb"
require "models/command.rb"
require "models/notice.rb"

module Controllers
	class Command
		KEY_BINDING = {27 => :exit, 263 => :erase, 127=> :erase, 10=> :return, 259=> :arroy_up, 258=> :arroy_down }
		
		def initialize(command_input)
			@command_index = nil
			@command_input = command_input
		end

		def handle
			while c = Tools::Curses.instance.get_c
		      if c.is_a?(String) && c.match(/[\w\W]/)
		        @command_input.add c
		      elsif KEY_BINDING.has_key? c
		        send KEY_BINDING[c]
		      else
		        Models::Notice.create(message: "Character '#{c}' not allowed", color: :red)
		      end
		    end
		end
	  
	  private

	  def replace_input_with_command
	  	@command_input.set Models::Command.find_by_index(@command_index % Models::Command.all.count).string
	  end

	  def arroy_down
	  	return if Models::Command.all.count == 0
	    @command_index = (@command_index.nil?)? 0 : @command_index + 1
	    replace_input_with_command
	  end

	  def arroy_up
	  	return if Models::Command.all.count == 0
	    @command_index = (@command_index.nil?)? Models::Command.all.size - 1 : @command_index - 1
	    replace_input_with_command
	  end
	  
	  def erase
	    @command_input.chomp
	  end

	  def return
	    return if @command_input.empty?
	    command = Models::Command.create(string: @command_input.string)
	    @command_input.clear
	    @command_index = nil
	    say "Call '#{command.string}' ..."
	    if command.method.nil?
	  		say "Bad syntax '#{command.string}'", :red
	  	elsif !exec_command command
	    	say "Command '#{command.method}' not found", :red
	    end
	    
	  end

	  def exec_command(command)
	  	return false unless ALLOWED_COMMAND.include? command.method.to_sym
		    if(command.params?)
		      send(command.method, *command.params)
		    else
		      send(command.method)
		    end
		true
	  end
	  
	  private
	  
	  ALLOWED_COMMAND = [:say, :exit]
	  
	  def say(message = "nothing to tell", color = :white)
	  	Models::Notice.create message: message, color: color.to_sym
	  end
	end
end